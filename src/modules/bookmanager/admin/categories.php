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

$page_title = $nv_Lang->getModule('categories');

$xtpl = new XTemplate('categories.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);

// Get categories with book count
$sql = 'SELECT c.*,
    (SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE cat_id = c.id) as book_count
    FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories c
    ORDER BY c.weight ASC, c.id ASC';
$result = $db->query($sql);

$categories = [];
while ($row = $result->fetch()) {
    $categories[] = $row;
}

if (!empty($categories)) {
    foreach ($categories as $cat) {
        // Build category path for hierarchical display
        $cat['level'] = 0; // For now, assume flat structure
        $cat['indent'] = str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $cat['level']);

        // Status formatting
        $cat['status_class'] = $cat['status'] ? 'success' : 'danger';
        $cat['status_text'] = $cat['status'] ? $lang_module['active'] : $lang_module['inactive'];
        $cat['bg_class'] = $cat['level'] > 0 ? 'bg-light' : '';

        // Subcategory count (simplified)
        $cat['subcat_count'] = 0; // For now

        // Check if category has books for delete permission
        $cat['has_books'] = $cat['book_count'] > 0;

        $xtpl->assign('CAT', $cat);

        // Always show weight info
        $xtpl->parse('main.category_loop.weight_info');

        if ($cat['has_books']) {
            $xtpl->parse('main.category_loop.has_books_warning');
            $xtpl->parse('main.category_loop.delete_disabled');
        } else {
            $xtpl->parse('main.category_loop.delete_allowed');
        }

        $xtpl->parse('main.category_loop');
    }
} else {
    $xtpl->parse('main.no_categories');
}

// Calculate statistics
$active_count = 0;
$inactive_count = 0;
$total_books = 0;

foreach ($categories as $cat) {
    if ($cat['status'] == 1) {
        $active_count++;
    } else {
        $inactive_count++;
    }
    $total_books += $cat['book_count'];
}

$xtpl->assign('LINK_ADD', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=add_cat');
$xtpl->assign('CATEGORIES_COUNT', count($categories));
$xtpl->assign('ACTIVE_COUNT', $active_count);
$xtpl->assign('INACTIVE_COUNT', $inactive_count);
$xtpl->assign('TOTAL_BOOKS', $total_books);

$xtpl->parse('main');
$contents = $xtpl->text('main');

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
