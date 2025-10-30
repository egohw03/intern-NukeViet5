<?php

/**
 * @Project NUKEVIET 5.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Oct 28, 2025
 */

if (!defined('NV_IS_FILE_ADMIN'))
    die('Stop!!!');

$id = $nv_Request->get_int('id', 'get', 0);

if ($id <= 0) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
}

// Get order info
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE id = ' . $id;
$order = $db->query($sql)->fetch();

if (empty($order)) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');
}

$page_title = $lang_module['view_order'] . ': ' . $order['order_code'];

// Format order data
$order['add_time_format'] = nv_date('d/m/Y H:i', $order['add_time']);
$order['total_amount_format'] = number_format($order['total_amount'], 0, ',', '.') . ' VNĐ';

// Order status
switch ($order['order_status']) {
    case 0:
        $order['order_status_text'] = $lang_module['order_pending'];
        $order['order_status_class'] = 'warning';
        break;
    case 1:
        $order['order_status_text'] = $lang_module['order_processing'];
        $order['order_status_class'] = 'info';
        break;
    case 2:
        $order['order_status_text'] = $lang_module['order_delivered'];
        $order['order_status_class'] = 'success';
        break;
    case 3:
        $order['order_status_text'] = $lang_module['order_cancelled'];
        $order['order_status_class'] = 'danger';
        break;
    default:
        $order['order_status_text'] = 'Không xác định';
        $order['order_status_class'] = 'secondary';
}

// Payment status
switch ($order['payment_status']) {
    case 0:
        $order['payment_status_text'] = $lang_module['payment_pending'];
        $order['payment_status_class'] = 'danger';
        break;
    case 1:
        $order['payment_status_text'] = $lang_module['payment_paid'];
        $order['payment_status_class'] = 'success';
        break;
    default:
        $order['payment_status_text'] = 'Không xác định';
        $order['payment_status_class'] = 'secondary';
}

// Get order items
$sql = 'SELECT oi.*, b.title as book_title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_order_items oi
        LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON oi.book_id = b.id
        WHERE oi.order_id = ' . $id;
$result = $db->query($sql);
$order_items = array();
while ($item = $result->fetch()) {
    $item['price_format'] = number_format($item['price'], 0, ',', '.') . ' VNĐ';
    $item['total_format'] = number_format($item['price'] * $item['quantity'], 0, ',', '.') . ' VNĐ';
    $order_items[] = $item;
}

$xtpl = new XTemplate('view_order.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', \NukeViet\Core\Language::$lang_module);
$xtpl->assign('GLANG', \NukeViet\Core\Language::$lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

$xtpl->assign('ORDER', $order);
$xtpl->assign('BACK_LINK', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders');

// Order items
if (!empty($order_items)) {
    foreach ($order_items as $item) {
        $xtpl->assign('ITEM', $item);
        $xtpl->parse('main.order_items.loop');
    }
    $xtpl->parse('main.order_items');
} else {
    $xtpl->parse('main.no_items');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
