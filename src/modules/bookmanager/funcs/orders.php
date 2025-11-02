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

// Search and filter parameters
$search = [
    'order_code' => $nv_Request->get_title('order_code', 'get', ''),
    'customer_name' => $nv_Request->get_title('customer_name', 'get', ''),
    'order_status' => $nv_Request->get_int('order_status', 'get', -1),
    'payment_status' => $nv_Request->get_int('payment_status', 'get', -1),
    'date_from' => $nv_Request->get_title('date_from', 'get', ''),
    'date_to' => $nv_Request->get_title('date_to', 'get', '')
];

// Validate dates
if (!empty($search['date_from']) && !preg_match('/^\d{2}\/\d{2}\/\d{4}$/', $search['date_from'])) {
    $search['date_from'] = '';
}
if (!empty($search['date_to']) && !preg_match('/^\d{2}\/\d{2}\/\d{4}$/', $search['date_to'])) {
    $search['date_to'] = '';
}

// Get all user orders for filtering
$all_orders = nv_get_user_orders($userid);
$orders = [];

// Apply filters
foreach ($all_orders as $order) {
    $match = true;

    // Filter by order code
    if (!empty($search['order_code']) && stripos($order['order_code'], $search['order_code']) === false) {
        $match = false;
    }

    // Filter by customer name
    if (!empty($search['customer_name']) && stripos($order['customer_name'], $search['customer_name']) === false) {
        $match = false;
    }

    // Filter by order status
    if ($search['order_status'] >= 0 && $order['order_status'] != $search['order_status']) {
        $match = false;
    }

    // Filter by payment status
    if ($search['payment_status'] >= 0 && $order['payment_status'] != $search['payment_status']) {
        $match = false;
    }

    // Filter by date range
    if (!empty($search['date_from'])) {
        $date_from_timestamp = strtotime(str_replace('/', '-', $search['date_from']));
        if ($order['add_time'] < $date_from_timestamp) {
            $match = false;
        }
    }

    if (!empty($search['date_to'])) {
        $date_to_timestamp = strtotime(str_replace('/', '-', $search['date_to']) . ' 23:59:59');
        if ($order['add_time'] > $date_to_timestamp) {
            $match = false;
        }
    }

    if ($match) {
        $orders[] = $order;
    }
}

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
    'title' => $lang_module['my_orders']
];

// Calculate statistics
$stats = [
    'total_orders' => count($all_orders),
    'filtered_orders' => count($orders),
    'total_amount' => 0,
    'paid_amount' => 0,
    'pending_amount' => 0
];

foreach ($all_orders as $order) {
    $stats['total_amount'] += $order['total_amount'];
    if ($order['payment_status'] == 1) {
        $stats['paid_amount'] += $order['total_amount'];
    } else {
        $stats['pending_amount'] += $order['total_amount'];
    }
}

// Format amounts
$stats['total_amount_format'] = nv_format_price($stats['total_amount']);
$stats['paid_amount_format'] = nv_format_price($stats['paid_amount']);
$stats['pending_amount_format'] = nv_format_price($stats['pending_amount']);

// Prepare search template variables
$search_vars = [
    'order_code' => $search['order_code'],
    'customer_name' => $search['customer_name'],
    'date_from' => $search['date_from'],
    'date_to' => $search['date_to']
];

// Add selected attributes for status filters
if ($search['order_status'] >= 0) {
    $search_vars['order_status_' . $search['order_status']] = 'selected';
}
if ($search['payment_status'] >= 0) {
    $search_vars['payment_status_' . $search['payment_status']] = 'selected';
}

// Template
$xtpl = new XTemplate('orders.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('SEARCH', $search_vars);
$xtpl->assign('STATS', $stats);

// Check if any search filters are applied
$has_filters = !empty($search['order_code']) || !empty($search['customer_name']) ||
               $search['order_status'] >= 0 || $search['payment_status'] >= 0 ||
               !empty($search['date_from']) || !empty($search['date_to']);

// Show search results info if filters are applied
if ($has_filters) {
    $xtpl->parse('main.search_results');
}

if (!empty($orders)) {
    foreach ($orders as $order) {
        $order['add_time'] = nv_date('d/m/Y H:i', $order['add_time']);
        $order['total_amount_format'] = nv_format_price($order['total_amount']);
        $order['order_status_text'] = $order_statuses[$order['order_status']] ?? $lang_module['unknown'];
        $order['payment_status_text'] = $payment_statuses[$order['payment_status']] ?? $lang_module['unknown'];

        // Enhanced status badges with icons and colors
        $status_badges = [
            0 => ['class' => 'warning', 'icon' => '⏳', 'bg' => '#ffc107', 'text' => 'Chờ xử lý'],
            1 => ['class' => 'info', 'icon' => '⚙️', 'bg' => '#17a2b8', 'text' => 'Đang xử lý'],
            2 => ['class' => 'success', 'icon' => '✅', 'bg' => '#28a745', 'text' => 'Đã giao'],
            3 => ['class' => 'danger', 'icon' => '❌', 'bg' => '#dc3545', 'text' => 'Đã hủy']
        ];
        $order['status_config'] = $status_badges[$order['order_status']] ?? ['class' => 'secondary', 'icon' => '❓', 'bg' => '#6c757d', 'text' => 'Không xác định'];

        $payment_badges = [
            0 => ['class' => 'warning', 'icon' => '💰', 'bg' => '#ffc107', 'text' => 'Chưa thanh toán'],
            1 => ['class' => 'success', 'icon' => '💳', 'bg' => '#28a745', 'text' => 'Đã thanh toán']
        ];
        $order['payment_config'] = $payment_badges[$order['payment_status']] ?? ['class' => 'secondary', 'icon' => '❓', 'bg' => '#6c757d', 'text' => 'Không xác định'];

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
