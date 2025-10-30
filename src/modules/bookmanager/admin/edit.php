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

global $lang_module, $lang_global, $nv_Lang, $module_upload;

use NukeViet\Files\Upload;

$id = $nv_Request->get_int('id', 'get', 0);

if ($id <= 0) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$page_title = $nv_Lang->getModule('edit_book');

// Load book data
$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE id = ' . $id;
$book = $db->query($sql)->fetch();

if (empty($book)) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$errors = [];

if ($nv_Request->isset_request('submit', 'post')) {
    $book['cat_id'] = $nv_Request->get_int('cat_id', 'post', 0);
    $book['title'] = $nv_Request->get_title('title', 'post', '');
    $book['author'] = $nv_Request->get_title('author', 'post', '');
    $book['publisher'] = $nv_Request->get_title('publisher', 'post', '');
    $book['publish_year'] = $nv_Request->get_int('publish_year', 'post', 0);
    $book['isbn'] = $nv_Request->get_title('isbn', 'post', '');
    $book['description'] = $nv_Request->get_textarea('description', '', '', NV_ALLOWED_HTML_TAGS);
    $book['price'] = $nv_Request->get_float('price', 'post', 0);
    $book['stock_quantity'] = $nv_Request->get_int('stock_quantity', 'post', 0);
    $book['status'] = $nv_Request->get_int('status', 'post', 1);

    // Validate
    if (empty($book['title'])) {
        $errors[] = $nv_Lang->getModule('error_title');
    }
    if (empty($book['author'])) {
        $errors[] = $nv_Lang->getModule('error_author');
    }
    if (empty($book['cat_id'])) {
        $errors[] = $nv_Lang->getModule('error_category');
    }

    // Upload new image if provided
    if (isset($_FILES['image']) && is_uploaded_file($_FILES['image']['tmp_name'])) {
        // Delete old image
        if (!empty($book['image'])) {
            $old_image_path = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $book['image'];
            if (file_exists($old_image_path)) {
                unlink($old_image_path);
            }
        }

        $upload = new Upload($upload_info = [
            'nv_path' => NV_UPLOADS_DIR . '/' . $module_upload,
            'path' => '',
            'maxfile' => '',
            'type' => ''
        ], $global_config['forbid_extensions'], $global_config['forbid_mimes'], NV_UPLOAD_MAX_FILESIZE, NV_MAX_WIDTH, NV_MAX_HEIGHT);

        $upload->setLanguage($nv_Lang);

        $upload_info = $upload->save_file($_FILES['image'], NV_UPLOADS_REAL_DIR . '/' . $module_upload, false, $global_config['auto_resize']);

        if (empty($upload_info['error'])) {
            $book['image'] = $upload_info['basename'];
        } else {
            $errors[] = $upload_info['error'];
        }
    }

    if (empty($errors)) {
        $alias = change_alias($book['title']);
        $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_books SET cat_id = :cat_id, title = :title, alias = :alias, author = :author, publisher = :publisher, publish_year = :publish_year, isbn = :isbn, description = :description, image = :image, price = :price, stock_quantity = :stock_quantity, edit_time = :edit_time, status = :status WHERE id = :id';
        $stmt = $db->prepare($sql);
        $stmt->bindParam(':cat_id', $book['cat_id'], PDO::PARAM_INT);
        $stmt->bindParam(':title', $book['title'], PDO::PARAM_STR);
        $stmt->bindParam(':alias', $alias, PDO::PARAM_STR);
        $stmt->bindParam(':author', $book['author'], PDO::PARAM_STR);
        $stmt->bindParam(':publisher', $book['publisher'], PDO::PARAM_STR);
        $stmt->bindParam(':publish_year', $book['publish_year'], PDO::PARAM_INT);
        $stmt->bindParam(':isbn', $book['isbn'], PDO::PARAM_STR);
        $stmt->bindParam(':description', $book['description'], PDO::PARAM_STR);
        $stmt->bindParam(':image', $book['image'], PDO::PARAM_STR);
        $stmt->bindParam(':price', $book['price'], PDO::PARAM_STR);
        $stmt->bindParam(':stock_quantity', $book['stock_quantity'], PDO::PARAM_INT);
        $stmt->bindValue(':edit_time', NV_CURRENTTIME, PDO::PARAM_INT);
        $stmt->bindParam(':status', $book['status'], PDO::PARAM_INT);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);

        if ($stmt->execute()) {
            nv_insert_logs(NV_LANG_DATA, $module_name, 'Edit book', 'ID: ' . $id, $admin_info['userid']);
            $nv_Cache->delMod($module_name);
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
        } else {
            $errors[] = $lang_module['error_save'] . ': ' . $stmt->errorInfo()[2];
        }
    }
}

// Get categories for dropdown
$categories = [];
$sql = 'SELECT id, title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories ORDER BY weight ASC';
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $categories[] = [
        'id' => $row['id'],
        'title' => $row['title'],
        'selected' => ($book['cat_id'] == $row['id']) ? 'selected' : ''
    ];
}

// Use XTemplate
$xtpl = new XTemplate('edit.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$book['image_url'] = !empty($book['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $book['image'] : '';

$xtpl->assign('DATA', $book);
$xtpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&id=' . $id);
$xtpl->assign('BACK_LINK', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
$xtpl->assign('CURRENT_YEAR', date('Y'));

if ($book['status'] == 1) {
    $xtpl->assign('DATA.status_1_selected', 'selected');
} else {
    $xtpl->assign('DATA.status_0_selected', 'selected');
}

if (!empty($book['image'])) {
    $xtpl->parse('main.current_image');
}

if (!empty($errors)) {
    $xtpl->assign('ERROR', implode('<br>', $errors));
    $xtpl->parse('main.error');
}

// Assign categories to template
foreach ($categories as $cat) {
    $xtpl->assign('CAT', $cat);
    $xtpl->parse('main.category');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
