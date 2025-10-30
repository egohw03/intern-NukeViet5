<?php

if (!defined('NV_IS_FILE_ADMIN')) die('Stop!!!');

global $lang_module, $lang_global, $module_upload;

$id = $nv_Request->get_int('id', 'get', 0);

if ($id <= 0) {
nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Check if book exists
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE id = ' . $id;
$book = $db->query($sql)->fetch();

if (empty($book)) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$page_title = $lang_module['delete_book'] . ': ' . $book['title'];

$errors = [];

if ($nv_Request->isset_request('confirm', 'post')) {
    // Delete image if exists
    if (!empty($book['image'])) {
    $image_path = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $book['image'];
    if (file_exists($image_path)) {
    unlink($image_path);
}
}

// Delete from database
    $sql = 'DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE id = ' . $id;
if ($db->exec($sql)) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
} else {
$errors[] = $lang_module['error_delete'];
}
}

$xtpl = new XTemplate('delete.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

$xtpl->assign('BOOK', $book);
$xtpl->assign('CANCEL_LINK', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);

if (!empty($errors)) {
foreach ($errors as $error) {
        $xtpl->assign('ERROR', $error);
        $xtpl->parse('main.error');
    }
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
