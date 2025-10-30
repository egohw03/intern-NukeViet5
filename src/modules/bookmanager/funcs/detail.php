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

// Handle add to cart
$added = false;
if ($nv_Request->isset_request('add_to_cart', 'post')) {
    $quantity = $nv_Request->get_int('quantity', 'post', 1);
    if (nv_add_to_cart($book['id'], $quantity)) {
        $added = true;
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

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
