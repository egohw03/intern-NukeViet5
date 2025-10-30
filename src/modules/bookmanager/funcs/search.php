<?php

if (!defined('NV_IS_MOD_BOOKMANAGER')) {
    die('Stop!!!');
}

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info, $module_info, $module_file, $array_mod_title;

$page_title = $lang_module['search'];
$key_words = $module_info['keywords'];

$search_query = $nv_Request->get_title('q', 'get', '');
$cat_id = $nv_Request->get_int('cat', 'get', 0);
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 12;

// Advanced search parameters
$author = $nv_Request->get_title('author', 'get', '');
$publisher = $nv_Request->get_title('publisher', 'get', '');
$min_price = $nv_Request->get_int('min_price', 'get', 0);
$max_price = $nv_Request->get_int('max_price', 'get', 0);
$sort_by = $nv_Request->get_title('sort', 'get', 'add_time'); // add_time, price_asc, price_desc, rating

$where = [];
$params = [];

if (!empty($search_query)) {
$where[] = '(b.title LIKE :query OR b.author LIKE :query OR b.publisher LIKE :query OR b.description LIKE :query)';
$params[':query'] = '%' . $search_query . '%';
}

if (!empty($author)) {
$where[] = 'b.author LIKE :author';
$params[':author'] = '%' . $author . '%';
}

if (!empty($publisher)) {
    $where[] = 'b.publisher LIKE :publisher';
    $params[':publisher'] = '%' . $publisher . '%';
}

if ($cat_id > 0) {
    $where[] = 'b.cat_id = :cat_id';
    $params[':cat_id'] = $cat_id;
}

if ($min_price > 0) {
    $where[] = 'b.price >= :min_price';
    $params[':min_price'] = $min_price;
}

if ($max_price > 0 && $max_price >= $min_price) {
    $where[] = 'b.price <= :max_price';
    $params[':max_price'] = $max_price;
}

$where_clause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Build ORDER BY clause
$order_by = 'b.add_time DESC';
switch ($sort_by) {
    case 'price_asc':
        $order_by = 'b.price ASC';
        break;
    case 'price_desc':
        $order_by = 'b.price DESC';
        break;
    case 'rating':
        // For rating sort, we need to join with a subquery to get average ratings
        $sql = 'SELECT b.*, c.title as cat_title, COALESCE(AVG(r.rating), 0) as avg_rating FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b
        LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_categories c ON b.cat_id = c.id
        LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_reviews r ON b.id = r.book_id AND r.status = 1
        ' . $where_clause . '
        GROUP BY b.id
        ORDER BY avg_rating DESC, b.add_time DESC
        LIMIT ' . $per_page . ' OFFSET ' . (($page - 1) * $per_page);
        break;
    default:
        $sql = 'SELECT b.*, c.title as cat_title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b
        LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_categories c ON b.cat_id = c.id
        ' . $where_clause . '
        ORDER BY ' . $order_by . '
        LIMIT ' . $per_page . ' OFFSET ' . (($page - 1) * $per_page);
        break;
}

$stmt = $db->prepare($sql);
foreach ($params as $key => $value) {
    $stmt->bindValue($key, $value);
}
$stmt->execute();

$books = [];
while ($book = $stmt->fetch()) {
    $book['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $book['id'];
    $book['price_format'] = number_format($book['price'], 0, ',', '.') . ' VNĐ';
    $books[] = $book;
}

// Get total for pagination
$sql_total = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b ' . $where_clause;
$stmt_total = $db->prepare($sql_total);
foreach ($params as $key => $value) {
    $stmt_total->bindValue($key, $value);
}
$stmt_total->execute();
$total_books = $stmt_total->fetchColumn();
$total_pages = ceil($total_books / $per_page);

// Get categories for filter
$categories = [];
$sql_cat = 'SELECT id, title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories ORDER BY weight ASC';
$result_cat = $db->query($sql_cat);
while ($row = $result_cat->fetch()) {
    $categories[] = $row;
}

// Use XTemplate
$xtpl = new XTemplate('search.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
$xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('SEARCH_QUERY', $search_query);
$xtpl->assign('CAT_ID', $cat_id);
$xtpl->assign('AUTHOR', $author);
$xtpl->assign('PUBLISHER', $publisher);
$xtpl->assign('MIN_PRICE', $min_price);
$xtpl->assign('MAX_PRICE', $max_price);

// Sort options selected
$sort_options = [
    'add_time' => '',
    'price_asc' => '',
    'price_desc' => '',
    'rating' => ''
];
$sort_options[$sort_by] = 'selected';
$xtpl->assign('SORT_BY', $sort_options);

// Categories filter
foreach ($categories as $cat) {
    $cat['selected'] = ($cat['id'] == $cat_id) ? 'selected' : '';
    $xtpl->assign('CAT', $cat);
    $xtpl->parse('main.cat_filter');
}

// Books
if (!empty($books)) {
    foreach ($books as $book) {
        $xtpl->assign('BOOK', $book);
        $xtpl->parse('main.book_loop');
    }
} else {
    $xtpl->parse('main.no_books');
}

// Pagination
if ($total_pages > 1) {
    for ($i = 1; $i <= $total_pages; $i++) {
        $xtpl->assign('PAGE', [
            'num' => $i,
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=search&q=' . urlencode($search_query) . '&cat=' . $cat_id . '&page=' . $i,
            'current' => ($i == $page) ? 'active' : ''
        ]);
        $xtpl->parse('main.pagination');
    }
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
