<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once NV_ROOTDIR . '/modules/bookmanager/funcs/functions.php';

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info, $module_info, $module_file, $array_mod_title;



if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$page_title = $lang_module['cart'];
$key_words = $lang_module['cart'];

$cart = nv_get_cart();
$total = nv_get_cart_total();
$total_items = array_sum(array_column($cart, 'quantity'));



// Handle update cart
if ($nv_Request->isset_request('update_cart', 'post')) {
    $quantities = $nv_Request->get_array('quantity', 'post');
    foreach ($quantities as $book_id => $quantity) {
        nv_update_cart($book_id, $quantity);
    }
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart');
}

// Handle remove item
$remove_id = $nv_Request->get_int('remove', 'get', 0);
if ($remove_id > 0) {
    nv_remove_from_cart($remove_id);
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart');
}

// Handle clear cart
if ($nv_Request->isset_request('clear_cart', 'post')) {
    $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = ' . $user_info['userid']);
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart');
}

// Breadcrumbs
$array_mod_title[] = [
    'title' => $lang_module['cart']
];



// Template
$xtpl = new XTemplate('cart.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('TOTAL_ITEMS', $total_items);
$xtpl->assign('TOTAL', nv_format_price($total));

if (!empty($cart)) {
    foreach ($cart as $item) {
        $item['image_url'] = !empty($item['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $item['image'] : '';
        $item['price_format'] = nv_format_price($item['price']);
        $item['subtotal'] = nv_format_price($item['price'] * $item['quantity']);
        $item['remove_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart&remove=' . $item['book_id'];

        $xtpl->assign('ITEM', $item);
        if (!empty($item['image'])) {
            $xtpl->parse('main.cart_items.image');
        } else {
            $xtpl->parse('main.cart_items.no_image');
        }
        $xtpl->parse('main.cart_items.item');
    }

    $xtpl->parse('main.cart_items');

    // Parse checkout separately
    $xtpl->parse('main.checkout');


} else {
    $xtpl->parse('main.empty_cart');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');



include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
