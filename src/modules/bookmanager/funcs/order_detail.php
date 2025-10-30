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

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info;

$order_id = $nv_Request->get_int('id', 'get', 0);

if (!$order_id) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
}

$page_title = $lang_module['order_detail'];
$key_words = $lang_module['order_detail'];

// Get order details
$userid = defined('NV_IS_USER') ? $user_info['userid'] : 0;
$order = nv_get_order($order_id, defined('NV_IS_ADMIN') ? 0 : $userid);

if (empty($order)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
}

// Get order items
$order_items = nv_get_order_items($order_id);

// Format order data
$order['total_amount_format'] = nv_format_price($order['total_amount']);
$order['discount_amount_format'] = nv_format_price($order['discount_amount']);
$order['final_total'] = $order['total_amount'];
$order['final_total_format'] = $order['total_amount_format'];

$order['add_time_format'] = nv_date('d/m/Y H:i', $order['add_time']);
$order['payment_time_format'] = !empty($order['payment_time']) ? nv_date('d/m/Y H:i', $order['payment_time']) : '';

// Status mappings
$order_statuses = [
    0 => '<span class="badge bg-warning">Chờ xử lý</span>',
    1 => '<span class="badge bg-info">Đang xử lý</span>',
    2 => '<span class="badge bg-success">Đã giao hàng</span>',
    3 => '<span class="badge bg-danger">Đã hủy</span>'
];

$payment_statuses = [
    0 => '<span class="badge bg-warning">Chưa thanh toán</span>',
    1 => '<span class="badge bg-success">Đã thanh toán</span>'
];

$payment_methods = [
    'COD' => 'Thanh toán khi nhận hàng',
    'bank_transfer' => 'Chuyển khoản ngân hàng',
    'card' => 'Thẻ tín dụng'
];

$order['order_status_badge'] = $order_statuses[$order['order_status']] ?? '<span class="badge bg-secondary">N/A</span>';
$order['payment_status_badge'] = $payment_statuses[$order['payment_status']] ?? '<span class="badge bg-secondary">N/A</span>';
$order['payment_method_text'] = $payment_methods[$order['payment_method']] ?? $order['payment_method'];

// Breadcrumbs
$array_mod_title[] = [
    'title' => $module_info['custom_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];
$array_mod_title[] = [
    'title' => $lang_module['my_orders'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders'
];
$array_mod_title[] = [
    'title' => $lang_module['order_code'] . ': ' . $order['order_code']
];

// Template
$xtpl = new XTemplate('order_detail.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('ORDER', $order);

// Order items
foreach ($order_items as $item) {
    $xtpl->assign('ITEM', $item);
    if (!empty($item['image'])) {
        $xtpl->parse('main.item.image');
    } else {
        $xtpl->parse('main.item.no_image');
    }
    $xtpl->parse('main.item');
}

// Discount info
if ($order['discount_amount'] > 0) {
    $xtpl->parse('main.discount_info');
}

// Order notes
if (!empty($order['order_note'])) {
    $xtpl->parse('main.order_note');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
