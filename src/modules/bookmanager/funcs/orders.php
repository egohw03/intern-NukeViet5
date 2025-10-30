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
// Temporarily allow access without login for testing
// if (!defined('NV_IS_USER')) {
//     nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
// }

$page_title = $lang_module['my_orders'];
$key_words = $lang_module['my_orders'];

$userid = defined('NV_IS_USER') ? $user_info['userid'] : 1;

$orders = nv_get_user_orders($userid);

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

// Breadcrumbs
$array_mod_title[] = [
    'title' => $module_info['custom_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];
$array_mod_title[] = [
    'title' => $lang_module['my_orders']
];

// Template
$xtpl = new XTemplate('orders.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);

if (!empty($orders)) {
    foreach ($orders as $order) {
        $order['add_time'] = nv_date('d/m/Y H:i', $order['add_time']);
        $order['total_amount_format'] = nv_format_price($order['total_amount']);
        $order['order_status_text'] = $order_statuses[$order['order_status']] ?? $lang_module['unknown'];
        $order['payment_status_text'] = $payment_statuses[$order['payment_status']] ?? $lang_module['unknown'];

        // Status badges for styling
        $status_badges = [
        0 => 'warning', // Pending
        1 => 'info',    // Processing
        2 => 'success', // Delivered
        3 => 'danger'   // Cancelled
        ];
        $order['status_class'] = $status_badges[$order['order_status']] ?? 'secondary';

        $payment_badges = [
            0 => 'warning', // Pending
            1 => 'success'  // Paid
        ];
        $order['payment_class'] = $payment_badges[$order['payment_status']] ?? 'secondary';

        // Payment method text
        $payment_methods = [
            'COD' => 'Thanh toán khi nhận hàng',
            'bank_transfer' => 'Chuyển khoản ngân hàng',
            'card' => 'Thẻ tín dụng'
        ];
        $order['payment_method_text'] = $payment_methods[$order['payment_method']] ?? $order['payment_method'];

        // Add view detail link
        $order['view_detail_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=order_detail&id=' . $order['id'];

        $xtpl->assign('ORDER', $order);
        $xtpl->parse('main.order_loop.view_detail');
        $xtpl->parse('main.order_loop');
    }
} else {
    $xtpl->parse('main.no_orders');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
