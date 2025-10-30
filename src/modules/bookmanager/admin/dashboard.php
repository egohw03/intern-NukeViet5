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

$page_title = $nv_Lang->getModule('dashboard');

// Revenue statistics
$revenue_today = $db->query('SELECT SUM(total_amount) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_status = 2 AND DATE(FROM_UNIXTIME(add_time)) = CURDATE()')->fetchColumn();
$revenue_week = $db->query('SELECT SUM(total_amount) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_status = 2 AND FROM_UNIXTIME(add_time) >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)')->fetchColumn();
$revenue_month = $db->query('SELECT SUM(total_amount) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_status = 2 AND MONTH(FROM_UNIXTIME(add_time)) = MONTH(CURDATE()) AND YEAR(FROM_UNIXTIME(add_time)) = YEAR(CURDATE())')->fetchColumn();

// Order statistics
$orders_pending = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_status = 0')->fetchColumn();
$orders_completed = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_status = 2')->fetchColumn();
$orders_cancelled = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_status = 3')->fetchColumn();

// Top selling books
$top_books = [];
$result = $db->query('SELECT oi.book_id, SUM(oi.quantity) as total_sold, b.title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_order_items oi INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON oi.book_id = b.id GROUP BY oi.book_id ORDER BY total_sold DESC LIMIT 5');
while ($row = $result->fetch()) {
    $top_books[] = $row;
}

// Low stock alerts
$low_stock = [];
$result = $db->query('SELECT id, title, stock_quantity FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE stock_quantity < 10 AND stock_quantity > 0 ORDER BY stock_quantity ASC');
while ($row = $result->fetch()) {
    $low_stock[] = $row;
}

// Use XTemplate
$xtpl = new XTemplate('dashboard.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);

$xtpl->assign('REVENUE_TODAY', ($revenue_today ? number_format($revenue_today, 0, ',', '.') : '0') . ' VND');
$xtpl->assign('REVENUE_WEEK', ($revenue_week ? number_format($revenue_week, 0, ',', '.') : '0') . ' VND');
$xtpl->assign('REVENUE_MONTH', ($revenue_month ? number_format($revenue_month, 0, ',', '.') : '0') . ' VND');

$xtpl->assign('ORDERS_PENDING', $orders_pending);
$xtpl->assign('ORDERS_COMPLETED', $orders_completed);
$xtpl->assign('ORDERS_CANCELLED', $orders_cancelled);

// Top books
foreach ($top_books as $book) {
    $xtpl->assign('TOP_BOOK', $book);
    $xtpl->parse('main.top_book');
}

// Low stock
foreach ($low_stock as $book) {
    $xtpl->assign('LOW_STOCK', $book);
    $xtpl->parse('main.low_stock');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
