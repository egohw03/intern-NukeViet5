<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div class="page-header">
        <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center py-3">
                <div>
                    <h1 class="h4 mb-1">Quản lý sách</h1>
                    <small class="text-muted">Tổng cộng: {TOTAL_BOOKS} cuốn sách</small>
                </div>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add" class="btn btn-primary">
                    Thêm sách mới
                </a>
            </div>
        </div>
    </div>

    <div class="container-fluid">

    



    <!-- Quick Filters -->
    <div class="bg-light p-3 mb-4 rounded">
        <form method="get" action="{NV_BASE_ADMINURL}index.php" class="row g-3 align-items-end">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />

        <div class="col-md-3">
        <label class="form-label small fw-bold">Danh mục</label>
        <select name="cat_id" class="form-select form-select-sm" onchange="this.form.submit()">
                    <option value="0">Tất cả danh mục</option>
            <!-- BEGIN: cat_filter -->
        <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
    <!-- END: cat_filter -->
    </select>
    </div>
    <div class="col-md-3">
    <label class="form-label small fw-bold">Trạng thái</label>
    <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
    <option value="-1" {STATUS_ALL}>Tất cả</option>
        <option value="1" {STATUS_ACTIVE}>Đang hoạt động</option>
        <option value="0" {STATUS_INACTIVE}>Tạm ngưng</option>
    </select>
    </div>
    <div class="col-md-4">
    <label class="form-label small fw-bold">Tìm kiếm</label>
    <div class="input-group input-group-sm">
    <input type="text" name="q" value="{SEARCH_QUERY}" class="form-control" placeholder="Tên sách, tác giả, nhà xuất bản, ISBN, mô tả...">
        <button type="submit" class="btn btn-outline-secondary">
            <span class="small">Tìm</span>
    </button>
    </div>
    </div>
    <div class="col-md-2 text-end">
    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-secondary btn-sm">
    <span class="small">Xóa lọc</span>
    </a>
    </div>
    </form>
    </div>

    <!-- Books Table -->
    <div class="card">
        <div class="card-header bg-white">
        <div class="d-flex justify-content-between align-items-center">
            <h6 class="mb-0 fw-bold">Danh sách sách</h6>
                <small class="text-muted">Hiển thị {TOTAL_BOOKS} cuốn sách</small>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 60px;">Ảnh</th>
                            <th>Sách & Tác giả</th>
                        <th style="width: 120px;">Danh mục</th>
                    <th class="text-center" style="width: 100px;">Giá</th>
                        <th class="text-center" style="width: 80px;">Tồn kho</th>
                            <th class="text-center" style="width: 90px;">Trạng thái</th>
                            <th class="text-center" style="width: 140px;">Thao tác</th>
                        </tr>
                    </thead>
    <tbody>
    <!-- BEGIN: book_loop -->
    <tr>
    <td class="text-center">
                            <!-- BEGIN: image -->
                            <img src="{BOOK.image_url}" alt="{BOOK.title}" class="rounded" style="width: 40px; height: 40px; object-fit: cover; border: 1px solid #dee2e6;">
                        <!-- END: image -->
                            <!-- BEGIN: no_image -->
                            <div class="bg-light rounded d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; font-size: 16px; color: #6c757d; border: 1px solid #dee2e6;">
                                <span>📖</span>
                        </div>
                    <!-- END: no_image -->
                </td>
    <td>
                            <div>
                            <div class="fw-semibold text-dark mb-1">{BOOK.title}</div>
                                <small class="text-muted">{BOOK.author}</small>
                            </div>
                    </td>
                        <td>
                            <span class="badge bg-light text-dark small">{BOOK.cat_title}</span>
                        </td>
                        <td class="text-center fw-semibold text-primary">
                            {BOOK.price_format}
                        </td>
                        <td class="text-center">
                            <span class="badge bg-{BOOK.stock_class} small">{BOOK.stock_quantity}</span>
                        </td>
                        <td class="text-center">
                            <span class="badge bg-{BOOK.status_class} small">{BOOK.status_text}</span>
                        </td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm" role="group">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=edit&id={BOOK.id}" class="btn btn-outline-primary" title="Sửa">
                                Sửa
                                </a>
                                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=delete&id={BOOK.id}" class="btn btn-outline-danger" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa cuốn sách này?')">
                                    Xóa
                                </a>
                            </div>
                        </td>
                        </tr>
                        <!-- END: book_loop -->
                    </tbody>
                </table>
            </div>
            <!-- BEGIN: no_books -->
            <div class="text-center py-4">
                <div class="text-muted mb-3">
                    <p class="mb-2">Chưa có cuốn sách nào</p>
                <small>Hãy thêm cuốn sách đầu tiên của bạn</small>
            </div>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add" class="btn btn-primary btn-sm">
                Thêm sách đầu tiên
            </a>
            </div>
            <!-- END: no_books -->
        </div>
    </div>

    <!-- BEGIN: generate_page -->
    <div class="d-flex justify-content-center mt-3">
        <nav aria-label="Page navigation">
        <ul class="pagination pagination-sm">
        <!-- BEGIN: prev -->
        <li class="page-item {PREV.disabled}">
        <a class="page-link" href="{PREV.link}" {PREV.attr}>Trước</a>
        </li>
        <!-- END: prev -->

        <!-- BEGIN: page -->
        <li class="page-item {PAGE.current}">
        <a class="page-link" href="{PAGE.link}">{PAGE.num}</a>
        </li>
        <!-- END: page -->

        <!-- BEGIN: next -->
        <li class="page-item {NEXT.disabled}">
        <a class="page-link" href="{NEXT.link}" {NEXT.attr}>Sau</a>
        </li>
        <!-- END: next -->
        </ul>
        </nav>
    </div>
    <!-- END: generate_page -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
