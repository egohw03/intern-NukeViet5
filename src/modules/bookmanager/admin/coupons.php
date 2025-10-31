<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

global $lang_module, $lang_global, $nv_Lang;

$page_title = $nv_Lang->getModule('coupons');

$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_int('id', 'get', 0);

// Handle actions
if ($action == 'delete' && $id > 0) {
    $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupons WHERE id = ' . $id);
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=coupons');
} elseif ($action == 'add' || ($action == 'edit' && $id > 0)) {
    // Show form
    $form_data = [
        'id' => 0,
        'code' => '',
        'discount_value' => '',
        'discount_type' => 'percentage',
        'usage_limit' => '',
        'start_time' => '',
        'end_time' => '',
        'status' => 1
    ];

    if ($action == 'edit' && $id > 0) {
        $row = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupons WHERE id = ' . $id)->fetch();
        if ($row) {
            $form_data = $row;
            $form_data['start_time'] = date('Y-m-d H:i', $row['start_time']);
            $form_data['end_time'] = date('Y-m-d H:i', $row['end_time']);
        }
    }

    // Handle submit
    if ($nv_Request->isset_request('save_coupon', 'post')) {
        $form_data = [
            'code' => $nv_Request->get_title('code', 'post', ''),
            'discount_value' => $nv_Request->get_float('discount_value', 'post', 0),
            'discount_type' => $nv_Request->get_title('discount_type', 'post', 'percentage'),
            'usage_limit' => $nv_Request->get_int('usage_limit', 'post', 0),
            'start_time' => strtotime($nv_Request->get_title('start_time', 'post', '')),
            'end_time' => strtotime($nv_Request->get_title('end_time', 'post', '')),
            'status' => $nv_Request->get_int('status', 'post', 1)
        ];

        if ($action == 'edit') {
            $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_coupons SET code = :code, discount_value = :discount_value, discount_type = :discount_type, usage_limit = :usage_limit, start_time = :start_time, end_time = :end_time, status = :status WHERE id = :id';
            $stmt = $db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        } else {
            $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_coupons (code, discount_value, discount_type, usage_limit, start_time, end_time, status) VALUES (:code, :discount_value, :discount_type, :usage_limit, :start_time, :end_time, :status)';
            $stmt = $db->prepare($sql);
        }
        $stmt->bindParam(':code', $form_data['code'], PDO::PARAM_STR);
        $stmt->bindParam(':discount_value', $form_data['discount_value'], PDO::PARAM_STR);
        $stmt->bindParam(':discount_type', $form_data['discount_type'], PDO::PARAM_STR);
        $stmt->bindParam(':usage_limit', $form_data['usage_limit'], PDO::PARAM_INT);
        $stmt->bindParam(':start_time', $form_data['start_time'], PDO::PARAM_INT);
        $stmt->bindParam(':end_time', $form_data['end_time'], PDO::PARAM_INT);
        $stmt->bindParam(':status', $form_data['status'], PDO::PARAM_INT);

        if ($stmt->execute()) {
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=coupons');
        }
    }

    $xtpl = new XTemplate('coupon_form.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('FORM_DATA', $form_data);
    $xtpl->assign('ACTION', $action);
    $xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
    $xtpl->assign('MODULE_NAME', $module_name);

    // Parse mode
    if ($action == 'edit') {
        $xtpl->parse('main.edit_mode');
    } else {
        $xtpl->parse('main.add_mode');
    }

    // Selected for discount type
    $form_data['percentage_selected'] = $form_data['discount_type'] == 'percentage' ? 'selected' : '';
    $form_data['fixed_selected'] = $form_data['discount_type'] == 'fixed' ? 'selected' : '';
    $form_data['status_checked'] = $form_data['status'] ? 'checked' : '';

    $xtpl->assign('FORM_DATA', $form_data);

    $xtpl->parse('main');
    $contents = $xtpl->text('main');
    include (NV_ROOTDIR . "/includes/header.php");
    echo nv_admin_theme($contents);
    include (NV_ROOTDIR . "/includes/footer.php");
    exit;
}

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
    $coupon['type_text'] = ($coupon['discount_type'] ?? 'percentage') == 'fixed' ? $nv_Lang->getModule('fixed_amount') : $nv_Lang->getModule('percentage');
    $coupon['status_text'] = $coupon['status'] ? $nv_Lang->getModule('active') : $nv_Lang->getModule('inactive');
    $coupon['status_color'] = $coupon['status'] ? '#28a745' : '#dc3545';
    $coupon['value_format'] = ($coupon['discount_type'] ?? 'percentage') == 'fixed' ? number_format(($coupon['discount_value'] ?? 0), 0, ',', '.') . ' VNĐ' : ($coupon['discount_value'] ?? 0) . '%';
    $coupon['used_count'] = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupon_usage WHERE coupon_id = ' . $coupon['id'])->fetchColumn();
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
