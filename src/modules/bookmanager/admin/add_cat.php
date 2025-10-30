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

$page_title = $nv_Lang->getModule('add_cat');

$error = '';
$array = array(
    'title' => '',
    'description' => '',
    'status' => 1
);

if ($nv_Request->isset_request('submit', 'post')) {
    $array['title'] = $nv_Request->get_title('title', 'post', '');
    $array['description'] = $nv_Request->get_textarea('description', 'post', '', 'br');
    $array['status'] = $nv_Request->get_int('status', 'post', 0);

    if (empty($array['title'])) {
        $error = $nv_Lang->getModule('error_required_title');
    } else {
        $alias = change_alias($array['title']);
        $sql = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE alias = :alias';
        $sth = $db->prepare($sql);
        $sth->bindParam(':alias', $alias, PDO::PARAM_STR);
        $sth->execute();
        $count = $sth->fetchColumn();

        if ($count > 0) {
            $alias .= '-' . NV_CURRENTTIME;
        }

        // Get max weight
        $sql = 'SELECT MAX(weight) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories';
        $weight = $db->query($sql)->fetchColumn();
        $weight = intval($weight) + 1;

        $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_categories (
            title, alias, description, weight, status
        ) VALUES (
            :title, :alias, :description, :weight, :status
        )';

        $data_insert = array();
        $data_insert['title'] = $array['title'];
        $data_insert['alias'] = $alias;
        $data_insert['description'] = $array['description'];
        $data_insert['weight'] = $weight;
        $data_insert['status'] = $array['status'];

        if ($db->insert_id($sql, 'id', $data_insert)) {
            nv_insert_logs(NV_LANG_DATA, $module_name, 'Add category', 'ID: ' . $db->lastInsertId(), $admin_info['userid']);
            $nv_Cache->delMod($module_name);
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=categories');
        } else {
            $error = $nv_Lang->getModule('error_save');
        }
    }
}

$xtpl = new XTemplate('add_cat.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

$xtpl->assign('DATA', $array);

if ($array['status'] == 1) {
    $xtpl->assign('STATUS_ACTIVE', 'selected="selected"');
} else {
    $xtpl->assign('STATUS_INACTIVE', 'selected="selected"');
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
