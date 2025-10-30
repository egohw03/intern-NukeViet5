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

if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$page_title = $lang_module['my_orders'];
$key_words = $lang_module['my_orders'];

$orders = nv_get_user_orders($user_info['userid']);

// Status mapping
$order_statuses = [
    0 => $lang_module['order_pending'],
    1 => $lang_module['order_processing'],
    2 => $lang_module['order_completed'],
    3 => $lang_module['order_cancelled']
];

$payment_statuses = [
    0 => $lang_module['payment_pending'],
    1 => $lang_module['payment_completed']
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

        $xtpl->assign('ORDER', $order);
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
