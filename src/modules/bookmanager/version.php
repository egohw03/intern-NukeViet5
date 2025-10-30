<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE')) {
    die('Stop!!!');
}

$module_version = array(
    'name' => 'Book Store Manager', // Tieu de module
    'modfuncs' => 'main,detail', // Cac function co block
    'change_alias' => '',
    'submenu' => 'categories,orders',
    'is_sysmod' => 0, // 1:0 => Co phai la module he thong hay khong
    'virtual' => 1, // 1:0 => Co cho phep ao hao module hay khong
    'version' => '5.0.00', // Phien ban cua modle
    'date' => 'Tue, 28 Oct 2025 12:00:00 GMT+07:00', // Ngay phat hanh phien ban
    'author' => 'Nguyễn Mạnh Hưng', // Tac gia
    'note' => 'Book store management system with categories, cart and orders', // Ghi chu
    'uploads_dir' => array(
        $module_name,
        $module_name . '/covers'
    ),
    'files_dir' => array($module_name),
    'icon' => 'fa-solid fa-book'
);
