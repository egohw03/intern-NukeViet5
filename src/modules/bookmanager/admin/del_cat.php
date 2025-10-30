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
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=categories');
}

// Check if category has books
$sql = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE cat_id = ' . $id;
$count_books = $db->query($sql)->fetchColumn();

if ($count_books > 0) {
    nv_info_die($lang_module['error_cat_has_books'], $lang_module['error'], 0);
}

// Delete category
$sql = 'DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE id = ' . $id;
if ($db->query($sql)) {
    nv_insert_logs(NV_LANG_DATA, $module_name, 'Delete category', 'ID: ' . $id, $admin_info['userid']);
    $nv_Cache->delMod($module_name);
}

nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=categories');
