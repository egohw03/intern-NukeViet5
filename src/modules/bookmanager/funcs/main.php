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

$array_data = [];
$cat_id = $nv_Request->get_int('cat_id', 'get', 0);
$search_query = $nv_Request->get_title('q', 'get', '');

// Handle add to cart
$added = false;
if ($nv_Request->isset_request('add_to_cart', 'post') && defined('NV_IS_USER')) {
    $book_id = $nv_Request->get_int('book_id', 'post', 0);
    $quantity = $nv_Request->get_int('quantity', 'post', 1);
    if (nv_add_to_cart($book_id, $quantity)) {
        $added = true;
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

// Get all books
$sql = 'SELECT b.*, c.title as cat_title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b
LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_categories c ON b.cat_id = c.id
' . $where_clause . '
ORDER BY b.add_time DESC';

$stmt = $db->prepare($sql);
$stmt->execute($params);
$result = $stmt;

while ($row = $result->fetch()) {
    $row['image_url'] = !empty($row['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['image'] : '';
    $row['price_format'] = nv_format_price($row['price']);
    $row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $row['id'];
    $array_data[] = $row;
}

// Categories for filter
$categories = nv_get_categories();

// Breadcrumbs
$array_mod_title[] = [
    'title' => $module_info['custom_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];

// Template
$xtpl = new XTemplate('main.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('SEARCH_QUERY', $search_query);

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

// Cart link
$cart_link = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart';
$xtpl->assign('CART_LINK', $cart_link);

// Add to cart for logged in users
if (defined('NV_IS_USER')) {
    foreach ($array_data as &$book) {
        $book['add_to_cart_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $book['id'] . '#add_to_cart';
        $xtpl->assign('BOOK', $book);
        $xtpl->parse('main.book_loop.add_to_cart');
    }
}

// Cart link
if (defined('NV_IS_USER')) {
    $xtpl->parse('main.cart_link');
}

// No pagination - show all books

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
