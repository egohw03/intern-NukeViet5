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

$id = $nv_Request->get_int('id', 'get', 0);

if ($id <= 0) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=categories');
}

// Get category data
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE id = ' . $id;
$category = $db->query($sql)->fetch();

// Count books in this category
$sql_books = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE cat_id = ' . $id;
$books_count = $db->query($sql_books)->fetchColumn();

if (empty($category)) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=categories');
}

$page_title = $nv_Lang->getModule('edit_cat');

$error = '';

if ($nv_Request->isset_request('submit', 'post')) {
    $category['title'] = $nv_Request->get_title('title', 'post', '');
    $category['description'] = $nv_Request->get_textarea('description', 'post', '', 'br');
    $category['status'] = $nv_Request->get_int('status', 'post', 0);

    if (empty($category['title'])) {
        $error = $nv_Lang->getModule('error_required_title');
    } else {
        $alias = change_alias($category['title']);

        // Check if alias exists for other categories
        $sql = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE alias = :alias AND id != :id';
        $sth = $db->prepare($sql);
        $sth->bindParam(':alias', $alias, PDO::PARAM_STR);
        $sth->bindParam(':id', $id, PDO::PARAM_INT);
        $sth->execute();
        $count = $sth->fetchColumn();

        if ($count > 0) {
            $alias .= '-' . $id;
        }

        $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_categories SET
            title = :title,
            alias = :alias,
            description = :description,
            status = :status
            WHERE id = :id';

        $stmt = $db->prepare($sql);
        $stmt->bindParam(':title', $category['title'], PDO::PARAM_STR);
        $stmt->bindParam(':alias', $alias, PDO::PARAM_STR);
        $stmt->bindParam(':description', $category['description'], PDO::PARAM_STR);
        $stmt->bindParam(':status', $category['status'], PDO::PARAM_INT);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);

        if ($stmt->execute()) {
            nv_insert_logs(NV_LANG_DATA, $module_name, 'Edit category', 'ID: ' . $id, $admin_info['userid']);
            $nv_Cache->delMod($module_name);
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=categories');
        } else {
            $error = $nv_Lang->getModule('error_save');
        }
    }
}

$xtpl = new XTemplate('edit_cat.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

$xtpl->assign('CAT', $category);
$xtpl->assign('CAT.book_count', $books_count);

if ($books_count > 0) {
$xtpl->assign('CONFIRM_MESSAGE', 'Thể loại này có ' . $books_count . ' cuốn sách. Bạn có chắc chắn muốn sửa? Việc sửa sẽ ảnh hưởng đến tất cả sách trong thể loại này.');
$xtpl->parse('main.has_books_warning');
    $xtpl->parse('main.confirm');
}

if ($category['status'] == 1) {
    $xtpl->assign('CAT.status_checked', 'checked');
}

if (!empty($error)) {
    $xtpl->assign('ERROR', $error);
    $xtpl->parse('main.error');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
