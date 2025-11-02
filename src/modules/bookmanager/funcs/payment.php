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

$page_title = $lang_module['payment'];
$key_words = $lang_module['payment'];

$order_code = $nv_Request->get_title('order_code', 'get', '');
$action = $nv_Request->get_title('action', 'get', '');

// Check if user is logged in
if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Verify order belongs to current user
if (!empty($order_code)) {
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_code = :order_code AND userid = ' . $user_info['userid'];
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);
    $stmt->execute();
    $order = $stmt->fetch();

    if (!$order) {
        nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
    }

    // Format order data
    $order['total_amount_format'] = nv_format_price($order['total_amount']);
    $order['add_time_format'] = nv_date('d/m/Y H:i', $order['add_time']);
    $order['payment_time_format'] = !empty($order['payment_time']) ? nv_date('d/m/Y H:i', $order['payment_time']) : '';
}

// Payment confirmation not needed for COD only system

// Breadcrumbs
$array_mod_title[] = [
    'title' => $module_info['custom_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];
$array_mod_title[] = [
    'title' => $lang_module['payment']
];

// Template
$xtpl = new XTemplate('payment.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('ORDER_CODE', $order_code);

// Order details
if (!empty($order)) {
    $xtpl->assign('ORDER', $order);

    // Payment status
    $payment_statuses = [
        0 => '<span class="badge bg-warning">Chưa thanh toán</span>',
        1 => '<span class="badge bg-success">Đã thanh toán</span>'
    ];

    $xtpl->assign('PAYMENT_STATUS', $payment_statuses[$order['payment_status']] ?? 'N/A');

    // Payment instructions - only COD is supported
    if ($order['payment_method'] == 'COD') {
        $xtpl->parse('main.order_details.cod');
    }

    $xtpl->parse('main.order_details');
}

// No payment confirmation needed for COD

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
