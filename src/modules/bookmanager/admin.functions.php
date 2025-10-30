<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) {
    die('Stop!!!');
}

global $module_file;

// Load module language
if (file_exists(NV_ROOTDIR . '/modules/' . $module_file . '/language/' . NV_LANG_DATA . '.php')) {
    require NV_ROOTDIR . '/modules/' . $module_file . '/language/' . NV_LANG_DATA . '.php';
}

require_once NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

define('NV_IS_BOOKMANAGER_ADMIN', true);
define('NV_IS_FILE_ADMIN', true);
