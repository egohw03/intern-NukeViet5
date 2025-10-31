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

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info, $module_info, $module_file, $array_mod_title;

if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$order_id = $nv_Request->get_int('id', 'get', 0);

if (!$order_id) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
}

// Get order details
$order = nv_get_order($order_id);

if (!$order || $order['userid'] != $user_info['userid']) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
}

$page_title = $lang_module['order_detail'] . ' #' . $order['order_code'];
$key_words = $lang_module['order_detail'];

// Get order items
$order_items = nv_get_order_items($order['id']);

// Status mapping
$order_statuses = [
    0 => $lang_module['order_pending'],
    1 => $lang_module['order_processing'],
    2 => $lang_module['order_delivered'],
    3 => $lang_module['order_cancelled']
];

$payment_statuses = [
    0 => $lang_module['payment_pending'],
    1 => $lang_module['payment_paid']
];

// Payment method text
$payment_methods = [
    'COD' => 'Thanh toán khi nhận hàng',
    'bank_transfer' => 'Chuyển khoản ngân hàng',
    'card' => 'Thẻ tín dụng'
];
$order['payment_method_text'] = $payment_methods[$order['payment_method']] ?? $order['payment_method'];

// Format data
$order['add_time'] = nv_date('d/m/Y H:i', $order['add_time']);
$order['total_amount_format'] = nv_format_price($order['total_amount']);
$order['order_status_text'] = $order_statuses[$order['order_status']] ?? $lang_module['unknown'];
$order['payment_status_text'] = $payment_statuses[$order['payment_status']] ?? $lang_module['unknown'];

// Status badges
$status_badges = [
    0 => 'warning',
    1 => 'info',
    2 => 'success',
    3 => 'danger'
];
$order['status_class'] = $status_badges[$order['order_status']] ?? 'secondary';

$payment_badges = [
    0 => 'warning',
    1 => 'success'
];
$order['payment_class'] = $payment_badges[$order['payment_status']] ?? 'secondary';

// Breadcrumbs
$array_mod_title[] = [
    'title' => $lang_module['my_orders'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders'
];
$array_mod_title[] = [
    'title' => $lang_module['order_detail'] . ' #' . $order['order_code']
];

// Template
$xtpl = new XTemplate('order_detail.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('ORDER', $order);

// Order items
if (!empty($order_items)) {
    foreach ($order_items as $item) {
        $item['image_url'] = !empty($item['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $item['image'] : '';
        $item['price_format'] = nv_format_price($item['price']);
        $item['subtotal'] = nv_format_price($item['price'] * $item['quantity']);

        $xtpl->assign('ITEM', $item);
        $xtpl->parse('main.item');
    }
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
