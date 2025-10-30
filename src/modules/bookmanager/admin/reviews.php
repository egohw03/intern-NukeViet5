<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

global $lang_module, $lang_global, $nv_Lang;

$page_title = $nv_Lang->getModule('reviews');

$per_page = 20;
$page = $nv_Request->get_int('page', 'get', 1);

// Filter by status
$status = $nv_Request->get_int('status', 'get', -1);

// Get reviews with book information
$where = '';
if ($status >= 0) {
    $where = 'WHERE r.status = ' . $status;
}

$sql = 'SELECT r.*, b.title as book_title, u.username FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews r
LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON r.book_id = b.id
LEFT JOIN ' . NV_USERS_GLOBALTABLE . ' u ON r.userid = u.userid
' . $where . '
ORDER BY r.add_time DESC
LIMIT ' . $per_page . ' OFFSET ' . (($page - 1) * $per_page);

$result = $db->query($sql);
$reviews = [];
while ($review = $result->fetch()) {
    $review['add_time'] = nv_date('d/m/Y H:i', $review['add_time']);
    $review['status_text'] = $review['status'] ? $nv_Lang->getModule('approved') : $nv_Lang->getModule('pending');
    $review['status_class'] = $review['status'] ? 'success' : 'warning';
    $reviews[] = $review;
}

// Get total reviews for pagination
$sql_total = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews r ' . $where;
$total_reviews = $db->query($sql_total)->fetchColumn();
$total_pages = ceil($total_reviews / $per_page);

// Use XTemplate
$xtpl = new XTemplate('reviews.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('STATUS', $status);

// Pagination
if ($total_pages > 1) {
    for ($i = 1; $i <= $total_pages; $i++) {
        $xtpl->assign('PAGE', [
            'num' => $i,
            'link' => NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=reviews&status=' . $status . '&page=' . $i,
            'current' => ($i == $page) ? 'active' : ''
        ]);
        $xtpl->parse('main.pagination');
    }
}

if (!empty($reviews)) {
    foreach ($reviews as $review) {
        $xtpl->assign('REVIEW', $review);
        $xtpl->parse('main.review_loop');
    }
} else {
    $xtpl->parse('main.no_reviews');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
