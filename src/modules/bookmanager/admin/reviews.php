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

$page_title = $lang_module['reviews_management'];

$per_page = 20;
$page = $nv_Request->get_int('page', 'get', 1);

// Get reviews with book and user info
$sql = 'SELECT r.*, b.title as book_title, u.username
        FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews r
        LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON r.book_id = b.id
        LEFT JOIN ' . NV_USERS_GLOBALTABLE . ' u ON r.userid = u.userid
        ORDER BY r.add_time DESC
        LIMIT ' . $per_page . ' OFFSET ' . (($page - 1) * $per_page);

$result = $db->query($sql);
$reviews = [];
while ($row = $result->fetch()) {
    $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
    $reviews[] = $row;
}

// Get total reviews for pagination
$total_reviews = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews')->fetchColumn();
$total_pages = ceil($total_reviews / $per_page);

// Handle approve/unapprove review
$review_id = $nv_Request->get_int('id', 'get', 0);
$action = $nv_Request->get_title('action', 'get', '');

if ($review_id > 0 && in_array($action, ['approve', 'unapprove'])) {
    $status = ($action == 'approve') ? 1 : 0;
    $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_reviews SET status = ' . $status . ' WHERE id = ' . $review_id);
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=reviews&page=' . $page);
}

// Handle delete review
if ($review_id > 0 && $action == 'delete') {
    $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews WHERE id = ' . $review_id);
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=reviews&page=' . $page);
}

// Template
$xtpl = new XTemplate('reviews.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);

// Reviews list
if (!empty($reviews)) {
foreach ($reviews as $review) {
$review['status_text'] = $review['status'] ? $lang_module['approved'] : $lang_module['pending'];
$review['status_class'] = $review['status'] ? 'success' : 'warning';

$xtpl->assign('REVIEW', $review);

// Parse stars
for ($i = 1; $i <= $review['rating']; $i++) {
$xtpl->parse('main.review_loop.star');
}

// Parse review title if exists
if (!empty($review['title'])) {
    $xtpl->parse('main.review_loop.review_title');
        }

// Parse review content
    $xtpl->parse('main.review_loop.review_content');

    // Action buttons
        if (!$review['status']) {
            $xtpl->assign('APPROVE_URL', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=reviews&action=approve&id=' . $review['id'] . '&page=' . $page);
            $xtpl->parse('main.review_loop.approve');
        } else {
            $xtpl->assign('UNAPPROVE_URL', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=reviews&action=unapprove&id=' . $review['id'] . '&page=' . $page);
            $xtpl->parse('main.review_loop.unapprove');
        }

        $xtpl->assign('DELETE_URL', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=reviews&action=delete&id=' . $review['id'] . '&page=' . $page);
        $xtpl->parse('main.review_loop');
    }
} else {
    $xtpl->parse('main.no_reviews');
}

// Pagination
if ($total_pages > 1) {
    for ($i = 1; $i <= $total_pages; $i++) {
        $xtpl->assign('PAGE', [
            'num' => $i,
            'url' => NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=reviews&page=' . $i,
            'current' => ($i == $page) ? 'active' : ''
        ]);
        $xtpl->parse('main.pagination');
    }
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
