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

    // Get current values
    $current = $db->query('SELECT order_status, payment_status FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE id = ' . $order_id)->fetch();

    $order_status = $nv_Request->isset_request('order_status', 'post') ? $nv_Request->get_int('order_status', 'post', $current['order_status']) : $current['order_status'];
    $payment_status = $nv_Request->isset_request('payment_status', 'post') ? $nv_Request->get_int('payment_status', 'post', $current['payment_status']) : $current['payment_status'];

    // Logic: if order_status is delivered (2), set payment_status to paid (1)
    if ($order_status == 2) {
        $payment_status = 1;
    }

    if ($order_id > 0) {
        $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_orders SET order_status = :order_status, payment_status = :payment_status WHERE id = :id';
        $stmt = $db->prepare($sql);
        $stmt->bindParam(':order_status', $order_status, PDO::PARAM_INT);
        $stmt->bindParam(':payment_status', $payment_status, PDO::PARAM_INT);
        $stmt->bindParam(':id', $order_id, PDO::PARAM_INT);
        if ($stmt->execute()) {
            $_SESSION['admin_message'] = 'Cập nhật trạng thái thành công';
        } else {
            $_SESSION['admin_message'] = 'Lỗi cập nhật';
        }
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

if (!empty($_SESSION['admin_message'])) {
    $xtpl->assign('ADMIN_MESSAGE', $_SESSION['admin_message']);
    $xtpl->parse('main.admin_message');
    unset($_SESSION['admin_message']);
}

// Filters
$status_filter = $nv_Request->get_int('status', 'get', -1);
$payment_status_filter = $nv_Request->get_int('payment_status', 'get', -1);
$search_query = $nv_Request->get_title('q', 'get', '');
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;

// Build WHERE clause
$where = [];
$params = [];

if ($status_filter >= 0) {
    $where[] = 'order_status = ?';
    $params[] = $status_filter;
}

if ($payment_status_filter >= 0) {
    $where[] = 'payment_status = ?';
    $params[] = $payment_status_filter;
}

if (!empty($search_query)) {
    $where[] = '(order_code LIKE ? OR customer_name LIKE ? OR customer_email LIKE ?)';
    $params[] = '%' . $search_query . '%';
    $params[] = '%' . $search_query . '%';
    $params[] = '%' . $search_query . '%';
}

$where_clause = !empty($where) ? ' WHERE ' . implode(' AND ', $where) : '';

// Get orders with pagination
$offset = ($page - 1) * $per_page;
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders' . $where_clause . ' ORDER BY add_time DESC LIMIT ' . $per_page . ' OFFSET ' . $offset;
$stmt = $db->prepare($sql);
$stmt->execute($params);
$result = $stmt;

// Get total count for current filter
$sql_total = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders' . $where_clause;
$stmt_total = $db->prepare($sql_total);
$stmt_total->execute($params);
$total_records = $stmt_total->fetchColumn();

// Get counts for display (all records)
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
$xtpl->assign('TOTAL_ORDERS', $total_records);
$xtpl->assign('SEARCH_QUERY', $search_query);

// Set selected values for filters
$xtpl->assign('STATUS_SELECTED_' . $status_filter, 'selected');
$xtpl->assign('PAYMENT_STATUS_SELECTED_' . $payment_status_filter, 'selected');

$array = array();
while ($row = $result->fetch()) {
    $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
    $row['total_amount_format'] = number_format($row['total_amount'], 0, ',', '.') . ' VND';

    // Order status
    switch ($row['order_status']) {
    case 0:
    $row['order_status_text'] = $nv_Lang->getModule('order_pending');
    $row['order_status_class'] = 'warning';
    $row['order_status_text_dark'] = true;
        break;
    case 1:
    $row['order_status_text'] = $nv_Lang->getModule('order_processing');
    $row['order_status_class'] = 'info';
        $row['order_status_text_dark'] = true;
    break;
    case 2:
    $row['order_status_text'] = $nv_Lang->getModule('order_delivered');
        $row['order_status_class'] = 'success';
    $row['order_status_text_white'] = true;
    break;
    case 3:
        $row['order_status_text'] = $nv_Lang->getModule('order_cancelled');
    $row['order_status_class'] = 'danger';
    $row['order_status_text_white'] = true;
            break;
        default:
            $row['order_status_text'] = 'Unknown';
            $row['order_status_class'] = 'secondary';
            $row['order_status_text_dark'] = true;
    }

    // Payment status
    switch ($row['payment_status']) {
    case 0:
    $row['payment_status_text'] = $nv_Lang->getModule('payment_pending');
    $row['payment_status_class'] = 'danger';
    $row['payment_status_text_white'] = true;
        break;
    case 1:
    $row['payment_status_text'] = $nv_Lang->getModule('payment_paid');
    $row['payment_status_class'] = 'success';
        $row['payment_status_text_white'] = true;
    break;
    default:
            $row['payment_status_text'] = 'Unknown';
            $row['payment_status_class'] = 'secondary';
            $row['payment_status_text_dark'] = true;
    }

    // Selected for dropdowns
    for ($i = 0; $i <= 3; $i++) {
        $row['order_status_' . $i . '_selected'] = $row['order_status'] == $i ? 'selected' : '';
    }
    for ($i = 0; $i <= 1; $i++) {
        $row['payment_status_' . $i . '_selected'] = $row['payment_status'] == $i ? 'selected' : '';
    }

    // Disable payment paid option if order status is pending or cancelled
    $row['payment_disabled'] = ($row['order_status'] == 0 || $row['order_status'] == 3) ? 'disabled' : '';

    // Add customer initial
    $row['customer_initial'] = strtoupper(substr($row['customer_name'], 0, 1));

    $array[$row['id']] = $row;
}

if (!empty($array)) {
foreach ($array as $order) {
$order['LINK_VIEW'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=view_order&amp;id=' . $order['id'];
$xtpl->assign('ORDER', $order);

// Parse text color for badges
if (!empty($order['order_status_text_white'])) {
    $xtpl->parse('main.order_loop.order_status_text_white');
} elseif (!empty($order['order_status_text_dark'])) {
    $xtpl->parse('main.order_loop.order_status_text_dark');
}

if (!empty($order['payment_status_text_white'])) {
    $xtpl->parse('main.order_loop.payment_status_text_white');
} elseif (!empty($order['payment_status_text_dark'])) {
    $xtpl->parse('main.order_loop.payment_status_text_dark');
}

$xtpl->parse('main.order_loop');
}
} else {
$xtpl->parse('main.no_orders');
}

// Generate page
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=orders';
if ($status_filter >= 0) {
    $base_url .= '&status=' . $status_filter;
}

$total_pages = ceil($total_records / $per_page);
if ($total_pages > 1) {
    // Previous
    if ($page > 1) {
        $xtpl->assign('PREV', ['link' => $base_url . '&page=' . ($page - 1), 'attr' => '', 'style' => '', 'color' => '#007bff']);
    $xtpl->parse('main.generate_page.prev');
    }

    // Pages
for ($i = max(1, $page - 2); $i <= min($total_pages, $page + 2); $i++) {
    $xtpl->assign('PAGE', [
    'num' => $i,
        'link' => $base_url . '&page=' . $i,
            'style' => ($i == $page) ? 'background: #007bff; color: white !important; border-color: #007bff !important;' : '',
            'border' => ($i == $page) ? '#007bff' : '#007bff',
            'color' => ($i == $page) ? 'white' : '#007bff'
        ]);
        $xtpl->parse('main.generate_page.page');
    }

    // Next
if ($page < $total_pages) {
    $xtpl->assign('NEXT', ['link' => $base_url . '&page=' . ($page + 1), 'attr' => '', 'style' => '', 'color' => '#007bff']);
    $xtpl->parse('main.generate_page.next');
    }

$xtpl->parse('main.generate_page');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
