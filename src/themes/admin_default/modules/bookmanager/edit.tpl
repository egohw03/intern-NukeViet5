<!-- BEGIN: main -->
<div class="book-form">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="mb-0">{LANG.edit_book}: {BOOK.title}</h1>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-secondary">
        {LANG.back}
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

    <form method="post" action="" enctype="multipart/form-data">
        <div class="row">
            <div class="col-lg-8">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">{LANG.book_info}</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">{LANG.title} <span class="text-danger">*</span></label>
                                    <input type="text" name="title" value="{BOOK.title}" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">{LANG.category} <span class="text-danger">*</span></label>
                                    <select name="cat_id" class="form-select" required>
                                        <option value="">{LANG.select_category}</option>
                                        <!-- BEGIN: cat_option -->
                                        <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
                                        <!-- END: cat_option -->
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">{LANG.author} <span class="text-danger">*</span></label>
                                    <input type="text" name="author" value="{BOOK.author}" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">{LANG.publisher}</label>
                                    <input type="text" name="publisher" value="{BOOK.publisher}" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">{LANG.publish_year}</label>
                                    <input type="number" name="publish_year" value="{BOOK.publish_year}" class="form-control" min="1900" max="2025">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">{LANG.price} (VNĐ) <span class="text-danger">*</span></label>
                                    <input type="number" name="price" value="{BOOK.price}" class="form-control" min="0" step="1000" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label class="form-label">{LANG.stock_quantity} <span class="text-danger">*</span></label>
                                    <input type="number" name="stock_quantity" value="{BOOK.stock_quantity}" class="form-control" min="0" required>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">{LANG.isbn}</label>
                            <input type="text" name="isbn" value="{BOOK.isbn}" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">{LANG.description}</label>
                            <textarea name="description" class="form-control" rows="5">{BOOK.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">{LANG.image}</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <input type="file" name="image" class="form-control" accept="image/*">
                            <small class="text-muted">Chọn hình ảnh sách mới (JPG, PNG, GIF). Để trống nếu không muốn thay đổi.</small>
                        </div>
                        <!-- BEGIN: current_image -->
                        <div class="mb-3">
                            <label class="form-label">{LANG.current_image}:</label>
                            <div>
                                <img src="{IMAGE_URL}" alt="Current image" class="img-fluid rounded" style="max-width: 200px;">
                            </div>
                        </div>
                        <!-- END: current_image -->
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">{LANG.settings}</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <div class="form-check">
                                <input type="checkbox" name="status" value="1" {BOOK.status_checked} class="form-check-input" id="status">
                                <label class="form-check-label" for="status">{LANG.active}</label>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" name="submit" class="btn btn-primary">
                            {LANG.update}
                            </button>
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-secondary">
                                {LANG.cancel}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- END: main -->
