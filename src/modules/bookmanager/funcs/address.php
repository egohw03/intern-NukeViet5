<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

require_once NV_ROOTDIR . '/modules/bookmanager/funcs/functions.php';

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info, $module_info, $module_file, $array_mod_title;

if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$page_title = $lang_module['addresses'];
$key_words = $lang_module['addresses'];

$userid = $user_info['userid'];

// Handle add/edit address
$message = '';
$form_data = [
'id' => 0,
'full_name' => '',
'phone' => '',
'address' => '',
'is_default' => 0,
    'is_default_checked' => ''
];

$edit_id = $nv_Request->get_int('edit', 'get', 0);
if ($edit_id > 0) {
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE id = ' . $edit_id . ' AND userid = ' . $userid;
$address = $db->query($sql)->fetch();
if ($address) {
$form_data = $address;
    $form_data['is_default_checked'] = $address['is_default'] ? 'checked' : '';
    }
}

if ($nv_Request->isset_request('save_address', 'post')) {
    $form_data['full_name'] = $nv_Request->get_title('full_name', 'post', '');
    $form_data['phone'] = $nv_Request->get_title('phone', 'post', '');
    $form_data['address'] = $nv_Request->get_textarea('address', 'post', '', 'br');
    $form_data['is_default'] = $nv_Request->get_int('is_default', 'post', 0);

    $errors = [];
    if (empty($form_data['full_name'])) {
        $errors[] = 'Vui lòng nhập họ và tên';
    }
    if (empty($form_data['phone'])) {
        $errors[] = 'Vui lòng nhập số điện thoại';
    }
    if (empty($form_data['address'])) {
        $errors[] = 'Vui lòng nhập địa chỉ';
    }

    if (empty($errors)) {
        if ($edit_id > 0) {
            // Update
            $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_addresses SET
                full_name = :full_name,
                phone = :phone,
                address = :address,
                is_default = :is_default
                WHERE id = :id AND userid = :userid';

            $stmt = $db->prepare($sql);
            $stmt->bindParam(':full_name', $form_data['full_name'], PDO::PARAM_STR);
            $stmt->bindParam(':phone', $form_data['phone'], PDO::PARAM_STR);
            $stmt->bindParam(':address', $form_data['address'], PDO::PARAM_STR);
            $stmt->bindParam(':is_default', $form_data['is_default'], PDO::PARAM_INT);
            $stmt->bindParam(':id', $edit_id, PDO::PARAM_INT);
            $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);

            if ($stmt->execute()) {
                if ($form_data['is_default']) {
                    $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_addresses SET is_default = 0 WHERE userid = ' . $userid . ' AND id != ' . $edit_id);
                }
                $message = 'Cập nhật địa chỉ thành công!';
            } else {
                $message = 'Có lỗi xảy ra khi cập nhật địa chỉ.';
            }
        } else {
            // Insert
            if (nv_add_user_address($userid, $form_data['full_name'], $form_data['phone'], $form_data['address'], $form_data['is_default'])) {
                $message = 'Thêm địa chỉ thành công!';
                $form_data = ['id' => 0, 'full_name' => '', 'phone' => '', 'address' => '', 'is_default' => 0];
            } else {
                $message = 'Có lỗi xảy ra khi thêm địa chỉ.';
            }
        }
    } else {
        $message = implode('<br>', $errors);
    }
}

// Handle delete address
$delete_id = $nv_Request->get_int('delete', 'get', 0);
if ($delete_id > 0) {
    $sql = 'DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE id = ' . $delete_id . ' AND userid = ' . $userid;
    if ($db->query($sql)) {
        $message = 'Xóa địa chỉ thành công!';
    } else {
        $message = 'Có lỗi xảy ra khi xóa địa chỉ.';
    }
}

// Get all addresses
$addresses = nv_get_user_addresses($userid);

// Breadcrumbs
$array_mod_title[] = [
    'title' => $module_info['custom_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];
$array_mod_title[] = [
    'title' => $lang_module['addresses']
];

// Template
$xtpl = new XTemplate('address.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('FORM_DATA', $form_data);
$xtpl->assign('MESSAGE', $message);

// Addresses list
if (!empty($addresses)) {
    foreach ($addresses as $address) {
        $xtpl->assign('ADDRESS', $address);
        $xtpl->parse('main.addresses.address_loop');
    }
    $xtpl->parse('main.addresses');
} else {
    $xtpl->parse('main.no_addresses');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
