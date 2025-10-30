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

$page_title = $module_info['custom_title'];
$key_words = $module_info['keywords'];

$cart_count = nv_get_cart_count();
$cart_total = nv_get_cart_total();

$array_data = [];
$cat_id = $nv_Request->get_int('cat_id', 'get', 0);
$search_query = $nv_Request->get_title('q', 'get', '');

// Pagination
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 12; // Số sách per page
$offset = ($page - 1) * $per_page;

// Handle add to cart success from redirect
$added = $nv_Request->get_int('added', 'get', 0) == 1;

$add_cart_error = '';
if ($nv_Request->isset_request('add_to_cart', 'post')) {
    $book_id = $nv_Request->get_int('book_id', 'post', 0);
    $quantity = $nv_Request->get_int('quantity', 'post', 1);

    if (!defined('NV_IS_USER')) {
        $add_cart_error = 'Vui lòng đăng nhập để thêm vào giỏ hàng';
    } elseif (empty($book_id)) {
        $add_cart_error = 'Sách không hợp lệ';
    } elseif ($quantity <= 0) {
        $add_cart_error = 'Số lượng phải lớn hơn 0';
    } else {
        $result = nv_add_to_cart($book_id, $quantity);
        if ($result) {
            // Redirect to avoid resubmit
            nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&added=1');
        } else {
            $add_cart_error = 'Không thể thêm vào giỏ hàng. Vui lòng thử lại.';
        }
    }
}

// Build WHERE clause
$where = [];
$params = [];

if ($cat_id > 0) {
    $where[] = 'b.cat_id = ?';
    $params[] = $cat_id;
}

if (!empty($search_query)) {
    $where[] = '(b.title LIKE ? OR b.author LIKE ? OR b.publisher LIKE ? OR b.description LIKE ?)';
    $params[] = '%' . $search_query . '%';
    $params[] = '%' . $search_query . '%';
    $params[] = '%' . $search_query . '%';
    $params[] = '%' . $search_query . '%';
}

$where[] = 'b.status = 1';
$where_clause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Get books with pagination
$sql = 'SELECT b.*, c.title as cat_title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b
LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_categories c ON b.cat_id = c.id
' . $where_clause . '
ORDER BY b.add_time DESC LIMIT ' . $per_page . ' OFFSET ' . $offset;

$stmt = $db->prepare($sql);
$stmt->execute($params);

while ($row = $stmt->fetch()) {
    $row['image_url'] = !empty($row['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['image'] : '';
$row['price_format'] = nv_format_price($row['price']);
$row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $row['id'];
$array_data[] = $row;
}

// Count total for pagination
$sql_count = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b ' . $where_clause;
$stmt_count = $db->prepare($sql_count);
$stmt_count->execute($params);
$total_books = $stmt_count->fetchColumn();

// Categories for filter
$categories = nv_get_categories();

// Pagination
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name;
if ($cat_id > 0) {
    $base_url .= '&cat_id=' . $cat_id;
}
if (!empty($search_query)) {
    $base_url .= '&q=' . urlencode($search_query);
}
$generate_page = nv_generate_page($base_url, $total_books, $per_page, $page);

// Template
$xtpl = new XTemplate('main.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('SEARCH_QUERY', $search_query);
$xtpl->assign('CART_COUNT', $cart_count);
$xtpl->assign('CART_TOTAL', nv_format_price($cart_total));
$xtpl->assign('USER_NAME', $user_info['full_name']);
$xtpl->assign('ADD_CART_ERROR', $add_cart_error);
$xtpl->assign('GENERATE_PAGE', $generate_page);

// Categories filter
foreach ($categories as $cat) {
    $cat['selected'] = ($cat['id'] == $cat_id) ? 'selected' : '';
    $xtpl->assign('CAT', $cat);
    $xtpl->parse('main.cat_filter');
}

// Books
if (!empty($array_data)) {
    foreach ($array_data as $book) {
        $xtpl->assign('BOOK', $book);
        if (!empty($book['image'])) {
            $xtpl->parse('main.book_loop.image');
        } else {
            $xtpl->parse('main.book_loop.no_image');
        }
        if (defined('NV_IS_USER')) {
            $xtpl->parse('main.book_loop.add_to_cart');
        }
        $xtpl->parse('main.book_loop');
    }
} else {
    $xtpl->parse('main.no_books');
}

// Success message
if ($added) {
    $xtpl->assign('SUCCESS_MESSAGE', $lang_module['added_to_cart']);
    $xtpl->parse('main.success');
}

// Error message
if (!empty($add_cart_error)) {
    $xtpl->assign('ERROR_MESSAGE', $add_cart_error);
    $xtpl->parse('main.error');
}



// User logged in flag
if (defined('NV_IS_USER')) {
$xtpl->parse('main.user_logged_in');
}

// Pagination
if (!empty($generate_page)) {
    $xtpl->parse('main.generate_page');
}

// No pagination - show all books

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
