<!-- BEGIN: main -->
<div class="category-form">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="mb-0">{LANG.edit_cat}: {CAT.title}</h1>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=categories" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> {LANG.back}
        </a>
    </div>

    <!-- BEGIN: error -->
    <div class="alert alert-danger">
        <ul class="mb-0">
            <!-- BEGIN: error_item -->
            <li>{ERROR}</li>
            <!-- END: error_item -->
        </ul>
    </div>
    <!-- END: error -->

    <div class="row">
        <div class="col-lg-8">
            <form method="post" action="">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">{LANG.category_info}</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">{LANG.title} <span class="text-danger">*</span></label>
                            <input type="text" name="title" value="{CAT.title}" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">{LANG.description}</label>
                            <textarea name="description" class="form-control" rows="3">{CAT.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">{LANG.parent_category}</label>
                            <select name="parent_id" class="form-select">
                                <option value="0">{LANG.root_category}</option>
                                <!-- BEGIN: parent_option -->
                                <option value="{PARENT.id}" {PARENT.selected}>{PARENT.title}</option>
                                <!-- END: parent_option -->
                            </select>
                            <small class="text-muted">Không thể chọn thể loại con của chính nó</small>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">{LANG.weight}</label>
                            <input type="number" name="weight" value="{CAT.weight}" class="form-control" min="1" max="255">
                            <small class="text-muted">Thứ tự hiển thị (số nhỏ hiển thị trước)</small>
                        </div>

                        <div class="mb-3">
                            <div class="form-check">
                                <input type="checkbox" name="status" value="1" {CAT.status_checked} class="form-check-input" id="status">
                                <label class="form-check-label" for="status">{LANG.active}</label>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="submit" name="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> {LANG.update}
                            </button>
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=categories" class="btn btn-secondary">
                                {LANG.cancel}
                            </a>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-lg-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Thông tin thêm</h5>
                </div>
                <div class="card-body">
                    <p><strong>ID thể loại:</strong> {CAT.id}</p>
                    <p><strong>Số sách:</strong> {CAT.book_count} cuốn</p>
                    <!-- BEGIN: has_books_warning -->
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        Thể loại này có {CAT.book_count} cuốn sách. Thay đổi có thể ảnh hưởng đến các sách này.
                    </div>
                    <!-- END: has_books_warning -->
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.help}</h5>
                </div>
                <div class="card-body">
                    <h6>Lưu ý khi chỉnh sửa:</h6>
                    <ul class="mb-0">
                        <li>Thay đổi tên thể loại sẽ ảnh hưởng đến tất cả sách trong thể loại</li>
                        <li>Có thể thay đổi thứ tự weight để sắp xếp lại</li>
                        <li>Vô hiệu hóa thể loại sẽ ẩn tất cả sách trong đó</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
