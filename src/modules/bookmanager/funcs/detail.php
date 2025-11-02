<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

require_once NV_ROOTDIR . '/modules/bookmanager/funcs/functions.php';

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info, $module_info, $module_file, $array_mod_title, $op_theme;
$op_theme = 'full';

$id = $nv_Request->get_int('id', 'get', 0);

$book = nv_get_book_with_category($id);

if (empty($book)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$page_title = $book['title'];
$key_words = $book['title'] . ', ' . $book['author'];

// Format data
$book['image_url'] = !empty($book['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $book['image'] : '';
$book['price_format'] = nv_format_price($book['price']);
$book['add_time'] = nv_date('d/m/Y', $book['add_time']);

// Get reviews and rating
$rating_data = nv_get_book_rating($book['id']);
$book['avg_rating'] = $rating_data['avg_rating'];
$book['total_reviews'] = $rating_data['total_reviews'];
$reviews = nv_get_book_reviews($book['id']);

// Handle add to cart
$added = false;
if ($nv_Request->isset_request('add_to_cart', 'post')) {
$quantity = $nv_Request->get_int('quantity', 'post', 1);
if (nv_add_to_cart($book['id'], $quantity)) {
$added = true;
}
}

// Handle review submission
$review_submitted = false;
$review_error = '';
if ($nv_Request->isset_request('submit_review', 'post')) {
    $rating = $nv_Request->get_int('rating', 'post', 5);
    $review_title = $nv_Request->get_title('review_title', 'post', '');
    $review_content = $nv_Request->get_textarea('review_content', 'post', '', 'br');

    if (nv_add_book_review($book['id'], $rating, $review_title, $review_content)) {
        $review_submitted = true;
        // Refresh reviews data
        $rating_data = nv_get_book_rating($book['id']);
        $book['avg_rating'] = $rating_data['avg_rating'];
        $book['total_reviews'] = $rating_data['total_reviews'];
        $reviews = nv_get_book_reviews($book['id']);
    } else {
        $review_error = 'Bạn đã đánh giá sách này rồi hoặc có lỗi xảy ra.';
    }
}

// Breadcrumbs
$array_mod_title[] = [
    'title' => $module_info['custom_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];
$array_mod_title[] = [
    'title' => $book['title']
];

// Template
$xtpl = new XTemplate('detail.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('BOOK', $book);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('REVIEW_ERROR', $review_error);

// Generate stars for average rating
$avg_rating_int = floor($book['avg_rating']);
for ($i = 1; $i <= $avg_rating_int; $i++) {
    $xtpl->parse('main.star');
}

if (!empty($book['image'])) {
    $xtpl->parse('main.image');
} else {
    $xtpl->parse('main.no_image');
}

if ($added) {
    $xtpl->assign('SUCCESS_MESSAGE', $lang_module['added_to_cart']);
    $xtpl->parse('main.success');
}

if (defined('NV_IS_USER')) {
$xtpl->parse('main.add_to_cart');
} else {
$xtpl->parse('main.login_required');
}

// Reviews section
if (!empty($reviews)) {
foreach ($reviews as $review) {
$review['add_time_format'] = nv_date('d/m/Y H:i', $review['add_time']);
// Generate star display for review
$review['stars'] = '';
    for ($i = 1; $i <= 5; $i++) {
        $review['stars'] .= '<span style="color: ' . ($i <= $review['rating'] ? '#ffc107' : '#ddd') . ';">★</span>';
        }
    $xtpl->assign('REVIEW', $review);
        // Parse stars for review
        for ($i = 1; $i <= $review['rating']; $i++) {
            $xtpl->parse('main.reviews.review_loop.review_star');
        }
        $xtpl->parse('main.reviews.review_loop');
    }
    $xtpl->parse('main.reviews');
} else {
    $xtpl->parse('main.no_reviews');
}

// Review form for logged-in users
if (defined('NV_IS_USER')) {
    if ($review_submitted) {
        $xtpl->assign('SUCCESS_MESSAGE', 'Đánh giá của bạn đã được gửi thành công!');
        $xtpl->parse('main.review_success');
    } elseif (!empty($review_error)) {
        $xtpl->parse('main.review_error');
    } else {
        $xtpl->parse('main.review_form');
    }
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
