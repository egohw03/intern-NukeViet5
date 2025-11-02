<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_SYSTEM')) {
    die('Stop!!!');
}

global $module_file;

// Frontend functions
$array_op = array();
$array_op[] = 'main';
$array_op[] = 'detail';
$array_op[] = 'cart';
$array_op[] = 'checkout';
$array_op[] = 'orders';
$array_op[] = 'order_detail';
$array_op[] = 'search';
$array_op[] = 'address';
$array_op[] = 'success';
$array_op[] = 'webhook';

// Default function
$op = in_array($op, $array_op) ? $op : 'main';

// Functions included in each file
