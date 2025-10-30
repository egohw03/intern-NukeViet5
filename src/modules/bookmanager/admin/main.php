<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

global $lang_module, $lang_global, $nv_Lang, $module_upload;

$page_title = $nv_Lang->getModule('book_list');

// Filters
$cat_id = $nv_Request->get_int('cat_id', 'get', 0);
$status_filter = $nv_Request->get_int('status', 'get', -1);
$search_query = $nv_Request->get_title('q', 'get', '');

// Build WHERE clause
$where = [];
$params = [];

if ($cat_id > 0) {
    $where[] = 'b.cat_id = :cat_id';
    $params[':cat_id'] = $cat_id;
}

if ($status_filter >= 0) {
    $where[] = 'b.status = :status';
    $params[':status'] = $status_filter;
}

if (!empty($search_query)) {
    $where[] = '(b.title LIKE :query OR b.author LIKE :query OR b.isbn LIKE :query)';
    $params[':query'] = '%' . $search_query . '%';
}

$where_clause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Get books with category information
$sql = 'SELECT b.*, c.title as cat_title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b
LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_categories c ON b.cat_id = c.id
' . $where_clause . '
ORDER BY b.add_time DESC
LIMIT 50'; // Limit for admin view

$stmt = $db->prepare($sql);
foreach ($params as $key => $value) {
    $stmt->bindValue($key, $value);
}
$stmt->execute();
$result = $stmt;

$processed_books = [];
while ($book = $result->fetch()) {
$book['status_class'] = $book['status'] ? 'success' : 'danger';
$book['status_text'] = $book['status'] ? $nv_Lang->getModule('active') : $nv_Lang->getModule('inactive');
$book['add_time'] = nv_date('d/m/Y H:i', $book['add_time']);
$book['price_format'] = number_format($book['price'], 0, ',', '.') . ' VNĐ';
$book['edit_link'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=edit&id=' . $book['id'];
$book['delete_link'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=delete&id=' . $book['id'];
$processed_books[] = $book;
}

// Get categories for filter
$categories = [];
$sql_cat = 'SELECT id, title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories ORDER BY weight ASC';
$result_cat = $db->query($sql_cat);
while ($row = $result_cat->fetch()) {
    $categories[] = $row;
}

// Get statistics for dashboard cards
$sql_stats = 'SELECT
    (SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books) as total_books,
    (SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories) as total_categories,
    (SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders) as total_orders,
    (SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews WHERE status = 1) as total_reviews';
$stats = $db->query($sql_stats)->fetch();

// Use XTemplate
$xtpl = new XTemplate('main.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);

// Statistics
$xtpl->assign('TOTAL_BOOKS', $stats['total_books']);
$xtpl->assign('TOTAL_CATEGORIES', $stats['total_categories']);
$xtpl->assign('TOTAL_ORDERS', $stats['total_orders']);
$xtpl->assign('TOTAL_REVIEWS', $stats['total_reviews']);

// Filters
$xtpl->assign('SEARCH_QUERY', $nv_Request->get_title('q', 'get', ''));

// Status filters
$status_current = $nv_Request->get_int('status', 'get', -1);
$xtpl->assign('STATUS_ALL', ($status_current == -1) ? 'selected' : '');
$xtpl->assign('STATUS_ACTIVE', ($status_current == 1) ? 'selected' : '');
$xtpl->assign('STATUS_INACTIVE', ($status_current == 0) ? 'selected' : '');

// Filter categories
foreach ($categories as $cat) {
    $cat['selected'] = ($cat['id'] == $cat_id) ? 'selected' : '';
    $xtpl->assign('CAT', $cat);
    $xtpl->parse('main.cat_filter');
}

// Process books for table display
if (!empty($processed_books)) {
    foreach ($processed_books as $book) {
        // Format book data for table
        $book['image_url'] = !empty($book['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $book['image'] : '';
        $book['stock_class'] = ($book['stock_quantity'] > 10) ? 'success' : (($book['stock_quantity'] > 0) ? 'warning' : 'danger');
        $book['status_class'] = $book['status'] ? 'success' : 'danger';
        $book['status_text'] = $book['status'] ? $nv_Lang->getModule('active') : $nv_Lang->getModule('inactive');
        $book['edit_time'] = !empty($book['edit_time']) ? nv_date('d/m/Y H:i', $book['edit_time']) : '';

        $xtpl->assign('BOOK', $book);
        $xtpl->parse('main.book_loop');
    }
} else {
    $xtpl->parse('main.no_books');
}

// Pagination (simplified)
$total_pages = 1; // For now, keep it simple
if ($total_pages > 1) {
    $xtpl->parse('main.generate_page');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
