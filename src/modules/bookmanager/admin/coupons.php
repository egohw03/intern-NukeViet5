<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

global $lang_module, $lang_global, $nv_Lang;

$page_title = $nv_Lang->getModule('coupons');

$per_page = 20;
$page = $nv_Request->get_int('page', 'get', 1);

// Get coupons
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupons
ORDER BY id DESC
LIMIT ' . $per_page . ' OFFSET ' . (($page - 1) * $per_page);

$result = $db->query($sql);
$coupons = [];
while ($coupon = $result->fetch()) {
    $coupon['start_time'] = nv_date('d/m/Y H:i', $coupon['start_time']);
    $coupon['end_time'] = nv_date('d/m/Y H:i', $coupon['end_time']);
    $coupon['type_text'] = $coupon['type'] ? $nv_Lang->getModule('fixed_amount') : $nv_Lang->getModule('percentage');
    $coupon['status_text'] = $coupon['status'] ? $nv_Lang->getModule('active') : $nv_Lang->getModule('inactive');
    $coupon['status_class'] = $coupon['status'] ? 'success' : 'danger';
    $coupon['value_format'] = $coupon['type'] ? number_format($coupon['value'], 0, ',', '.') . ' VNĐ' : $coupon['value'] . '%';
    $coupons[] = $coupon;
}

// Get total coupons for pagination
$sql_total = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupons';
$total_coupons = $db->query($sql_total)->fetchColumn();
$total_pages = ceil($total_coupons / $per_page);

// Use XTemplate
$xtpl = new XTemplate('coupons.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

// Pagination
if ($total_pages > 1) {
    for ($i = 1; $i <= $total_pages; $i++) {
        $xtpl->assign('PAGE', [
            'num' => $i,
            'link' => NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=coupons&page=' . $i,
            'current' => ($i == $page) ? 'active' : ''
        ]);
        $xtpl->parse('main.pagination');
    }
}

if (!empty($coupons)) {
    foreach ($coupons as $coupon) {
        $xtpl->assign('COUPON', $coupon);
        $xtpl->parse('main.coupon_loop');
    }
} else {
    $xtpl->parse('main.no_coupons');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
