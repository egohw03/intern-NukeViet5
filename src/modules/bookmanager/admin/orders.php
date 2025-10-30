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

global $lang_module, $lang_global, $nv_Lang;

$page_title = $nv_Lang->getModule('orders');

$xtpl = new XTemplate('orders.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

// Get orders
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders ORDER BY add_time DESC';
$result = $db->query($sql);

$array = array();
while ($row = $result->fetch()) {
    $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
    $row['total_amount_format'] = number_format($row['total_amount'], 0, ',', '.') . ' VND';

    // Order status
    switch ($row['order_status']) {
        case 0:
            $row['order_status_text'] = $nv_Lang->getModule('order_pending');
            $row['order_status_class'] = 'warning';
            break;
        case 1:
            $row['order_status_text'] = $nv_Lang->getModule('order_processing');
            $row['order_status_class'] = 'info';
            break;
        case 2:
            $row['order_status_text'] = $nv_Lang->getModule('order_delivered');
            $row['order_status_class'] = 'success';
            break;
        case 3:
            $row['order_status_text'] = $nv_Lang->getModule('order_cancelled');
            $row['order_status_class'] = 'danger';
            break;
        default:
            $row['order_status_text'] = 'Unknown';
            $row['order_status_class'] = 'secondary';
    }

    // Payment status
    switch ($row['payment_status']) {
        case 0:
            $row['payment_status_text'] = $nv_Lang->getModule('payment_pending');
            $row['payment_status_class'] = 'danger';
            break;
        case 1:
            $row['payment_status_text'] = $nv_Lang->getModule('payment_paid');
            $row['payment_status_class'] = 'success';
            break;
        default:
            $row['payment_status_text'] = 'Unknown';
            $row['payment_status_class'] = 'secondary';
    }

    $array[$row['id']] = $row;
}

$xtpl->assign('ORDERS', $array);

if (!empty($array)) {
    foreach ($array as $order) {
        $order['LINK_VIEW'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=view_order&amp;id=' . $order['id'];
        $xtpl->assign('ORDER', $order);
        $xtpl->parse('main.loop');
    }
} else {
    $xtpl->parse('main.no_data');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
