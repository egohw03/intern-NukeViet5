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

global $lang_module, $lang_global, $nv_Lang, $nv_Request;

$page_title = $nv_Lang->getModule('orders');

// Handle update status
if ($nv_Request->isset_request('update_status', 'post')) {
    $order_id = $nv_Request->get_int('order_id', 'post', 0);
    $order_status = $nv_Request->get_int('order_status', 'post', 0);
    $payment_status = $nv_Request->get_int('payment_status', 'post', 0);

    if ($order_id > 0) {
        $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_orders SET order_status = :order_status, payment_status = :payment_status WHERE id = :id';
        $stmt = $db->prepare($sql);
        $stmt->bindParam(':order_status', $order_status, PDO::PARAM_INT);
        $stmt->bindParam(':payment_status', $payment_status, PDO::PARAM_INT);
        $stmt->bindParam(':id', $order_id, PDO::PARAM_INT);
        $stmt->execute();

        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
    }
}

$xtpl = new XTemplate('orders.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

// Filter by status
$status_filter = $nv_Request->get_int('status', 'get', -1);
$where = '';
if ($status_filter >= 0) {
    $where = ' WHERE order_status = ' . $status_filter;
}

// Get orders
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders' . $where . ' ORDER BY add_time DESC';
$result = $db->query($sql);

// Get counts for tabs
$counts = array();
$sql_count = 'SELECT order_status, COUNT(*) as count FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders GROUP BY order_status';
$result_count = $db->query($sql_count);
while ($row_count = $result_count->fetch()) {
    $counts[$row_count['order_status']] = $row_count['count'];
}

$all_count = array_sum($counts);
$pending_count = $counts[0] ?? 0;
$processing_count = $counts[1] ?? 0;
$delivered_count = $counts[2] ?? 0;
$cancelled_count = $counts[3] ?? 0;

$xtpl->assign('ALL_COUNT', $all_count);
$xtpl->assign('PENDING_COUNT', $pending_count);
$xtpl->assign('PROCESSING_COUNT', $processing_count);
$xtpl->assign('DELIVERED_COUNT', $delivered_count);
$xtpl->assign('CANCELLED_COUNT', $cancelled_count);

// Set active tab
$all_bg = $status_filter == -1 ? '#007bff' : 'transparent';
$all_color = $status_filter == -1 ? 'white' : '#007bff';
$pending_bg = $status_filter == 0 ? '#ffc107' : 'transparent';
$pending_color = $status_filter == 0 ? 'black' : '#ffc107';
$processing_bg = $status_filter == 1 ? '#0dcaf0' : 'transparent';
$processing_color = $status_filter == 1 ? 'white' : '#0dcaf0';
$delivered_bg = $status_filter == 2 ? '#198754' : 'transparent';
$delivered_color = $status_filter == 2 ? 'white' : '#198754';
$cancelled_bg = $status_filter == 3 ? '#dc3545' : 'transparent';
$cancelled_color = $status_filter == 3 ? 'white' : '#dc3545';

$xtpl->assign('ALL_ACTIVE_BG', $all_bg);
$xtpl->assign('ALL_ACTIVE_COLOR', $all_color);
$xtpl->assign('PENDING_ACTIVE_BG', $pending_bg);
$xtpl->assign('PENDING_ACTIVE_COLOR', $pending_color);
$xtpl->assign('PROCESSING_ACTIVE_BG', $processing_bg);
$xtpl->assign('PROCESSING_ACTIVE_COLOR', $processing_color);
$xtpl->assign('DELIVERED_ACTIVE_BG', $delivered_bg);
$xtpl->assign('DELIVERED_ACTIVE_COLOR', $delivered_color);
$xtpl->assign('CANCELLED_ACTIVE_BG', $cancelled_bg);
$xtpl->assign('CANCELLED_ACTIVE_COLOR', $cancelled_color);

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

    // Selected for dropdowns
    for ($i = 0; $i <= 3; $i++) {
        $row['order_status_' . $i . '_selected'] = $row['order_status'] == $i ? 'selected' : '';
    }
    for ($i = 0; $i <= 1; $i++) {
        $row['payment_status_' . $i . '_selected'] = $row['payment_status'] == $i ? 'selected' : '';
    }

    $array[$row['id']] = $row;
}

if (!empty($array)) {
    foreach ($array as $order) {
        $order['LINK_VIEW'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=view_order&amp;id=' . $order['id'];
        $xtpl->assign('ORDER', $order);
        $xtpl->parse('main.order_loop');
    }
} else {
    $xtpl->parse('main.no_orders');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
