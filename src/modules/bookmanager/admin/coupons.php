<?php
/**
 * Coupons management - REMOVED
 * This file is kept for compatibility but functionality has been removed
 */
if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

// Redirect to main admin page
nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
?>
