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

global $module_file, $op_theme;

// Set full width layout for all pages
$op_theme = 'full';
define('NV_IS_FULL', true);

// Frontend functions with SEO URLs
$array_op = array(
    'main' => '',
    'detail' => 'detail',
    'cart' => 'cart',
    'checkout' => 'checkout',
    'orders' => 'orders',
    'order_detail' => 'order_detail',
    'search' => 'search',
    'address' => 'address',
    'success' => 'success',
    'webhook' => 'webhook'
);

// Default function
$op = array_key_exists($op, $array_op) ? $op : 'main';

// Functions included in each file
