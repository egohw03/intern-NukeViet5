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

$page_title = $nv_Lang->getModule('add_book');

$errors = [];
$book = [
    'cat_id' => 0,
    'title' => '',
    'author' => '',
    'publisher' => '',
    'publish_year' => '',
    'isbn' => '',
    'description' => '',
    'image' => '',
    'price' => 0,
    'stock_quantity' => 0,
    'status' => 1
];

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
        $errors[] = $nv_Lang->getModule('error_required_title');
    }
    if (empty($book['author'])) {
        $errors[] = $nv_Lang->getModule('error_author');
    }
    if (empty($book['cat_id'])) {
        $errors[] = $nv_Lang->getModule('error_category');
    }

    // Upload image
    if (isset($_FILES['image']) && is_uploaded_file($_FILES['image']['tmp_name'])) {
        $upload = new Upload([
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
        $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_books (cat_id, title, alias, author, publisher, publish_year, isbn, description, image, price, stock_quantity, add_time, status) VALUES (:cat_id, :title, :alias, :author, :publisher, :publish_year, :isbn, :description, :image, :price, :stock_quantity, :add_time, :status)';
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
        $stmt->bindValue(':add_time', NV_CURRENTTIME, PDO::PARAM_INT);
        $stmt->bindParam(':status', $book['status'], PDO::PARAM_INT);

        if ($stmt->execute()) {
            nv_insert_logs(NV_LANG_DATA, $module_name, 'Add book', 'ID: ' . $db->lastInsertId(), $admin_info['userid']);
            $nv_Cache->delMod($module_name);
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
        } else {
            $errors[] = $nv_Lang->getModule('error_save');
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

// Use XTemplate instead of string concatenation
$xtpl = new XTemplate('add.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('DATA', $book);
$xtpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
$xtpl->assign('BACK_LINK', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
$xtpl->assign('CURRENT_YEAR', date('Y'));

if ($book['status'] == 1) {
    $xtpl->assign('DATA.status_1_selected', 'selected');
} else {
    $xtpl->assign('DATA.status_0_selected', 'selected');
}

foreach ($categories as $cat) {
    $xtpl->assign('CAT', $cat);
    $xtpl->parse('main.category');
}

if (!empty($errors)) {
    $xtpl->assign('ERROR', implode('<br>', $errors));
    $xtpl->parse('main.error');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
