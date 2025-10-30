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
$page_title = $nv_Lang->getModule('books');
$key_words = $module_info['keywords'];
$description = $module_info['description'];

// Filter by category
$cat_id = $nv_Request->get_int('cat_id', 'get', 0);
$categories = [];
$sql = 'SELECT id, title, alias FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE status = 1 ORDER BY weight ASC';
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $categories[$row['id']] = $row;
}

// Get books
$where = 'WHERE status = 1';
if ($cat_id > 0 && isset($categories[$cat_id])) {
    $where .= ' AND cat_id = ' . $cat_id;
    $page_title = $categories[$cat_id]['title'] . ' - ' . $page_title;
}

$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 5;
$full_size = $nv_Request->get_int('full_size', 'get', 0);
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name;
if ($cat_id > 0) {
    $base_url .= '&cat_id=' . $cat_id;
}
if ($full_size) {
    $base_url .= '&full_size=1';
}

$sql = 'SELECT SQL_CALC_FOUND_ROWS * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books ' . $where . ' ORDER BY add_time DESC LIMIT ' . (($page - 1) * $per_page) . ', ' . $per_page;
$result = $db->query($sql);
$books = [];
while ($row = $result->fetch()) {
    $row['image_url'] = !empty($row['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['image'] : '';
    $row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $row['id'];
    $books[] = $row;
}

$result = $db->query('SELECT FOUND_ROWS()');
$all_page = $result->fetchColumn();
$num_pages = ceil($all_page / $per_page);

if ($cat_id > 0) {
    $array_mod_title[] = [
        'title' => $categories[$cat_id]['title'],
        'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&cat_id=' . $cat_id
    ];
}

// Check if AJAX request
$isAjax = $nv_Request->get_int('nv_ajax', 'get', 0) || isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';

if ($isAjax) {
    // Return only books content for AJAX
    $ajax_content = book_main_ajax_theme($books, $categories, $cat_id, $base_url, $page, $num_pages, $full_size);
    echo $ajax_content;
    exit;
}

$contents = book_main_theme($books, $categories, $cat_id, $base_url, $page, $num_pages, $full_size);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
