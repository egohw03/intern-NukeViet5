<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div class="page-header">
        <div class="container-fluid">
            <div class="header-content">
                <div class="header-title">
                    <i class="fas fa-tags"></i>
                    <div>
                        <h1>{LANG.coupons}</h1>
                        <div class="header-subtitle"><!-- BEGIN: edit_mode -->Chỉnh sửa<!-- END: edit_mode --><!-- BEGIN: add_mode -->Thêm mới<!-- END: add_mode --> mã giảm giá</div>
                    </div>
                </div>
                <div class="header-actions">
                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><!-- BEGIN: edit_mode -->Chỉnh sửa<!-- END: edit_mode --><!-- BEGIN: add_mode -->Thêm mới<!-- END: add_mode --> mã giảm giá</h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="">
                            <div class="mb-3">
                                <label for="code" class="form-label">Mã giảm giá *</label>
                                <input type="text" class="form-control" id="code" name="code" value="{FORM_DATA.code}" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="discount_value" class="form-label">Giá trị giảm *</label>
                                    <input type="number" step="0.01" class="form-control" id="discount_value" name="discount_value" value="{FORM_DATA.discount_value}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="discount_type" class="form-label">Loại giảm</label>
                                    <select class="form-select" id="discount_type" name="discount_type">
                                        <option value="percentage" {FORM_DATA.percentage_selected}>Phần trăm (%)</option>
                                        <option value="fixed" {FORM_DATA.fixed_selected}>Số tiền cố định (VNĐ)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="usage_limit" class="form-label">Giới hạn sử dụng</label>
                                <input type="number" class="form-control" id="usage_limit" name="usage_limit" value="{FORM_DATA.usage_limit}" placeholder="Để trống nếu không giới hạn">
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="start_time" class="form-label">Thời gian bắt đầu *</label>
                                    <input type="datetime-local" class="form-control" id="start_time" name="start_time" value="{FORM_DATA.start_time}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="end_time" class="form-label">Thời gian kết thúc *</label>
                                    <input type="datetime-local" class="form-control" id="end_time" name="end_time" value="{FORM_DATA.end_time}" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="status" name="status" value="1" {FORM_DATA.status_checked}>
                                    <label class="form-check-label" for="status">
                                        Kích hoạt
                                    </label>
                                </div>
                            </div>
                            <button type="submit" name="save_coupon" class="btn btn-primary">Lưu</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h6 class="mb-0">Hướng dẫn</h6>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled">
                            <li><i class="fas fa-info-circle text-info me-2"></i>Mã giảm giá phải là duy nhất</li>
                            <li><i class="fas fa-info-circle text-info me-2"></i>Thời gian bắt đầu phải trước thời gian kết thúc</li>
                            <li><i class="fas fa-info-circle text-info me-2"></i>Để trống giới hạn sử dụng nếu không muốn giới hạn</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
