<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_BOOKMANAGER')) {
    die('Stop!!!');
}

/**
 * book_main_theme()
 */
function book_main_theme($books, $categories, $cat_id, $base_url, $page, $num_pages, $full_size = 0)
{
    global $nv_Lang, $module_upload;

    $xtpl = new XTemplate('main.tpl', get_module_tpl_dir('main.tpl'));
    $xtpl->assign('LANG', $nv_Lang->getModule());
    $xtpl->assign('GLANG', $nv_Lang->getGlobal());
    $xtpl->assign('BASE_URL', $base_url);
    $xtpl->assign('FULL_SIZE', $full_size);
    $xtpl->assign('CAT_ID', $cat_id);

    if ($cat_id > 0) {
        $xtpl->parse('main.cat_link');
    }

    if (!$full_size) {
        $xtpl->parse('main.not_full_size');
        $xtpl->parse('main.normal_size');
        $xtpl->parse('main.normal');
    } else {
        $xtpl->parse('main.full_size');
    }

    // Categories
    if ($cat_id == 0) {
        $xtpl->parse('main.all_selected');
    }
    foreach ($categories as $cat) {
        $xtpl->assign('CAT', $cat);
        if ($cat['id'] == $cat_id) {
            $xtpl->parse('main.category.selected');
            $xtpl->assign('CATEGORY_TITLE', $cat['title']);
            $xtpl->parse('main.category_title');
        }
        $xtpl->parse('main.category');
    }

    // Books
    if (!empty($books)) {
        foreach ($books as $book) {
            $xtpl->assign('BOOK', $book);
            if (!empty($book['image_url'])) {
                $xtpl->parse('main.book.image');
            } else {
                $xtpl->parse('main.book.no_image');
            }
            if ($book['stock_quantity'] > 0) {
                $xtpl->parse('main.book.in_stock');
                if (defined('NV_IS_USER')) {
                    $xtpl->parse('main.book.can_add_cart');
                } else {
                    $xtpl->parse('main.book.cannot_add_cart');
                }
            } else {
                $xtpl->parse('main.book.out_of_stock');
                $xtpl->parse('main.book.cannot_add_cart');
            }
            $xtpl->parse('main.book');
        }

        // Pagination
        if ($num_pages > 1) {
            // Previous/Next
            $prev_page = max(1, $page - 1);
            $next_page = min($num_pages, $page + 1);

            $xtpl->assign('PREV_PAGE', $prev_page);
            $xtpl->assign('NEXT_PAGE', $next_page);

            if ($page == 1) {
                $xtpl->parse('main.generate_page.prev_disabled');
            }
            if ($page == $num_pages) {
                $xtpl->parse('main.generate_page.next_disabled');
            }

            // Page numbers
            $start_page = max(1, $page - 2);
            $end_page = min($num_pages, $page + 2);

            for ($i = $start_page; $i <= $end_page; $i++) {
                $xtpl->assign('PAGE_NUM', $i);
                if ($i == $page) {
                    $xtpl->parse('main.generate_page.page.active');
                }
                $xtpl->parse('main.generate_page.page');
            }

            $xtpl->parse('main.generate_page');
        }
    } else {
        $xtpl->parse('main.no_books');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * book_detail_theme()
 */
function book_detail_theme($book, $reviews = [], $avg_rating = 0, $total_reviews = 0)
{
    global $nv_Lang, $module_upload;

    $xtpl = new XTemplate('detail.tpl', get_module_tpl_dir('detail.tpl'));
    $xtpl->assign('LANG', $nv_Lang->getModule());
    $xtpl->assign('GLANG', $nv_Lang->getGlobal());
    $xtpl->assign('BOOK', $book);
    $xtpl->assign('AVG_RATING', $avg_rating);
    $xtpl->assign('TOTAL_REVIEWS', $total_reviews);

    // Image handling
    if (!empty($book['image_url'])) {
        $xtpl->parse('main.image');
    } else {
        $xtpl->parse('main.no_image');
    }

    // Meta fields
    if (!empty($book['publisher'])) {
        $xtpl->parse('main.publisher');
    }
    if (!empty($book['publish_year'])) {
        $xtpl->parse('main.publish_year');
    }
    if (!empty($book['isbn'])) {
        $xtpl->parse('main.isbn');
    }

    // Stock status
    if ($book['stock_quantity'] > 0) {
        $xtpl->parse('main.in_stock');
        $xtpl->parse('main.in_stock_detail');
    } else {
        $xtpl->parse('main.out_of_stock');
        $xtpl->parse('main.out_of_stock_detail');
    }

    // User status
    if (defined('NV_IS_USER')) {
        $xtpl->parse('main.add_to_cart');
    } else {
        $xtpl->parse('main.login_required');
    }

    // Description
    if (!empty($book['description'])) {
        $xtpl->parse('main.description');
    } else {
        $xtpl->parse('main.no_description');
    }

    // Details table
    if (!empty($book['publisher'])) {
        $xtpl->parse('main.publisher_row');
    }
    if (!empty($book['publish_year'])) {
        $xtpl->parse('main.publish_year_row');
    }
    if (!empty($book['isbn'])) {
        $xtpl->parse('main.isbn_row');
    }

    // Reviews
    if (!empty($reviews)) {
        foreach ($reviews as $review) {
            $review['add_time_format'] = nv_date('d/m/Y H:i', $review['add_time']);
            $xtpl->assign('REVIEW', $review);
            $xtpl->parse('main.review_loop');
        }
        $xtpl->parse('main.reviews');
    } else {
        $xtpl->parse('main.no_reviews');
    }

    // Review form for logged-in users
    if (defined('NV_IS_USER')) {
        $xtpl->parse('main.review_form');
    }

    // Related books (placeholder - can be implemented later)
    // For now, we'll skip this or add dummy data

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * book_cart_theme()
 */
function book_cart_theme($cart_items, $total, $total_format, $discount = 0, $discount_format = '0 VND', $final_total = 0, $final_total_format = '0 VND', $coupon_code = '', $coupon_error = '', $coupon_applied = false)
{
    global $nv_Lang;

    $xtpl = new XTemplate('cart.tpl', get_module_tpl_dir('cart.tpl'));
    $xtpl->assign('LANG', $nv_Lang->getModule());
    $xtpl->assign('GLANG', $nv_Lang->getGlobal());
    $xtpl->assign('DISCOUNT', $discount_format);
    $xtpl->assign('FINAL_TOTAL', $final_total_format);
    $xtpl->assign('COUPON_CODE', $coupon_code);
    $xtpl->assign('COUPON_ERROR', $coupon_error);
    $xtpl->assign('COUPON_APPLIED', $coupon_applied);

    if (!empty($cart_items)) {
        foreach ($cart_items as $item) {
            if (!empty($item['image_url'])) {
                $xtpl->parse('main.checkout.item.image');
            } else {
                $xtpl->parse('main.checkout.item.no_image');
            }
            $xtpl->assign('ITEM', $item);
            $xtpl->parse('main.checkout.item');
        }
        $xtpl->assign('TOTAL', $total_format);
        $xtpl->assign('NUM_ITEMS', count($cart_items));
        $xtpl->parse('main.checkout');
    } else {
        $xtpl->parse('main.empty');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * book_checkout_theme()
 */
function book_checkout_theme($checkout_items, $total, $customer_info, $errors)
{
    global $nv_Lang;

    $xtpl = new XTemplate('checkout.tpl', get_module_tpl_dir('checkout.tpl'));
    $xtpl->assign('LANG', $nv_Lang->getModule());
    $xtpl->assign('GLANG', $nv_Lang->getGlobal());
    $xtpl->assign('CUSTOMER', $customer_info);

    // Cart items
    foreach ($checkout_items as $item) {
        $item['subtotal_format'] = number_format($item['subtotal'], 0, ',', '.') . ' VND';
        $xtpl->assign('ITEM', $item);
        $xtpl->parse('main.item');
    }

    $xtpl->assign('TOTAL', number_format($total, 0, ',', '.') . ' VND');

    // Errors
    if (!empty($errors)) {
        foreach ($errors as $error) {
            $xtpl->assign('ERROR', $error);
            $xtpl->parse('main.error');
        }
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * book_success_theme()
 */
function book_success_theme($order)
{
    global $nv_Lang;

    $xtpl = new XTemplate('success.tpl', get_module_tpl_dir('success.tpl'));
    $xtpl->assign('LANG', $nv_Lang->getModule());
    $xtpl->assign('GLANG', $nv_Lang->getGlobal());

    // Format order data
    $order['total_amount_format'] = number_format($order['total_amount'], 0, ',', '.') . ' VND';
    $order['add_time_format'] = date('d/m/Y H:i', $order['add_time']);

    // Parse status
    if ($order['order_status'] == 0) {
        $xtpl->parse('main.pending');
    } elseif ($order['order_status'] == 1) {
        $xtpl->parse('main.processing');
    } elseif ($order['order_status'] == 2) {
        $xtpl->parse('main.completed');
    } elseif ($order['order_status'] == 3) {
        $xtpl->parse('main.cancelled');
    }

    // Order note
    if (!empty($order['order_note'])) {
        $xtpl->parse('main.order_note');
    }

    $xtpl->assign('ORDER', $order);
    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * book_main_ajax_theme() - For AJAX pagination
 */
function book_main_ajax_theme($books, $categories, $cat_id, $base_url, $page, $num_pages, $full_size = 0)
{
    global $nv_Lang;

    $xtpl = new XTemplate('main_ajax.tpl', get_module_tpl_dir('main_ajax.tpl'));
    $xtpl->assign('LANG', $nv_Lang->getModule());
    $xtpl->assign('GLANG', $nv_Lang->getGlobal());
    $xtpl->assign('BASE_URL', $base_url);
    $xtpl->assign('FULL_SIZE', $full_size);

    if ($full_size) {
        $xtpl->parse('main.full_size');
    } else {
        $xtpl->parse('main.normal');
    }

    // Categories
    if ($cat_id == 0) {
        $xtpl->parse('main.all_selected');
    }
    foreach ($categories as $cat) {
        $xtpl->assign('CAT', $cat);
        if ($cat['id'] == $cat_id) {
            $xtpl->parse('main.category.selected');
            $xtpl->assign('CATEGORY_TITLE', $cat['title']);
            $xtpl->parse('main.category_title');
        }
        $xtpl->parse('main.category');
    }

    // Books
    if (!empty($books)) {
        foreach ($books as $book) {
            if (!empty($book['image_url'])) {
                $xtpl->parse('main.book.image');
            } else {
                $xtpl->parse('main.book.no_image');
            }
            if ($book['stock_quantity'] > 0) {
                $xtpl->parse('main.book.in_stock');
                if (defined('NV_IS_USER')) {
                    $xtpl->parse('main.book.can_add_cart');
                } else {
                    $xtpl->parse('main.book.cannot_add_cart');
                }
            } else {
                $xtpl->parse('main.book.out_of_stock');
                $xtpl->parse('main.book.cannot_add_cart');
            }
            $xtpl->parse('main.book');
        }

        // Pagination
        if ($num_pages > 1) {
            // Previous/Next
            $prev_page = max(1, $page - 1);
            $next_page = min($num_pages, $page + 1);

            $xtpl->assign('PREV_PAGE', $prev_page);
            $xtpl->assign('NEXT_PAGE', $next_page);

            if ($page == 1) {
                $xtpl->parse('main.generate_page.prev_disabled');
            }
            if ($page == $num_pages) {
                $xtpl->parse('main.generate_page.next_disabled');
            }

            // Page numbers
            $start_page = max(1, $page - 2);
            $end_page = min($num_pages, $page + 2);

            for ($i = $start_page; $i <= $end_page; $i++) {
                $xtpl->assign('PAGE_NUM', $i);
                if ($i == $page) {
                    $xtpl->parse('main.generate_page.page.active');
                }
                $xtpl->parse('main.generate_page.page');
            }

            $xtpl->parse('main.generate_page');
        }
    } else {
        $xtpl->parse('main.no_books');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}
