<!-- BEGIN: main -->
<div class="orders-management">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-list"></i> {LANG.orders}</h2>
        <div class="stats">
            <span class="badge bg-primary me-2">Tổng: {TOTAL_ORDERS}</span>
            <span class="badge bg-warning me-2">Chờ xử lý: {PENDING_COUNT}</span>
            <span class="badge bg-info me-2">Đang xử lý: {PROCESSING_COUNT}</span>
            <span class="badge bg-success me-2">Đã giao: {DELIVERED_COUNT}</span>
            <span class="badge bg-danger">Đã hủy: {CANCELLED_COUNT}</span>
        </div>
    </div>

    <!-- BEGIN: admin_message -->
    <div class="alert alert-success">{ADMIN_MESSAGE}</div>
    <!-- END: admin_message -->

    <!-- Filters -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="get" class="row g-3">
                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
                <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}">

                <div class="col-md-3">
                    <label class="form-label">Trạng thái đơn hàng</label>
                    <select name="status" class="form-select">
                        <option value="-1" {STATUS_SELECTED_-1}>Tất cả</option>
                        <option value="0" {STATUS_SELECTED_0}>Chờ xử lý</option>
                        <option value="1" {STATUS_SELECTED_1}>Đang xử lý</option>
                        <option value="2" {STATUS_SELECTED_2}>Đã giao</option>
                        <option value="3" {STATUS_SELECTED_3}>Đã hủy</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Trạng thái thanh toán</label>
                    <select name="payment_status" class="form-select">
                        <option value="-1" {PAYMENT_STATUS_SELECTED_-1}>Tất cả</option>
                        <option value="0" {PAYMENT_STATUS_SELECTED_0}>Chưa thanh toán</option>
                        <option value="1" {PAYMENT_STATUS_SELECTED_1}>Đã thanh toán</option>
                    </select>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Tìm kiếm</label>
                    <input type="text" name="q" value="{SEARCH_QUERY}" class="form-control" placeholder="Mã đơn, tên, email">
                </div>

                <div class="col-md-2">
                    <label class="form-label">&nbsp;</label>
                    <button type="submit" class="btn btn-primary w-100"><i class="fas fa-search"></i> Tìm</button>
                </div>
            </form>
        </div>
    </div>

    <!-- BEGIN: order_loop -->
    <div class="card mb-3">
        <div class="card-header d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <div class="customer-avatar me-3">
                    <span class="badge bg-secondary fs-5">{ORDER.customer_initial}</span>
                </div>
                <div>
                    <strong>{ORDER.customer_name}</strong><br>
                    <small class="text-muted">{ORDER.customer_email}</small>
                </div>
            </div>
            <div class="text-end">
                <div class="mb-1">
                    <span class="badge bg-{ORDER.order_status_class} <!-- BEGIN: order_status_text_white -->text-white<!-- END: order_status_text_white --> <!-- BEGIN: order_status_text_dark -->text-dark<!-- END: order_status_text_dark -->">{ORDER.order_status_text}</span>
                    <span class="badge bg-{ORDER.payment_status_class} <!-- BEGIN: payment_status_text_white -->text-white<!-- END: payment_status_text_white --> <!-- BEGIN: payment_status_text_dark -->text-dark<!-- END: payment_status_text_dark -->">{ORDER.payment_status_text}</span>
                </div>
                <small class="text-muted">{ORDER.add_time_format}</small>
            </div>
        </div>

        <div class="card-body">
            <div class="row">
                <div class="col-md-8">
                    <p><strong>Mã đơn:</strong> {ORDER.order_code}</p>
                    <p><strong>Địa chỉ:</strong> {ORDER.customer_address}</p>
                    <p><strong>Phone:</strong> {ORDER.customer_phone}</p>
                </div>
                <div class="col-md-4 text-end">
                    <h5 class="text-success mb-3">{ORDER.total_amount_format}</h5>
                    <a href="{ORDER.LINK_VIEW}" class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-eye"></i> Xem chi tiết
                    </a>
                </div>
            </div>
        </div>

        <div class="card-footer">
            <form method="post" class="row g-2">
                <input type="hidden" name="order_id" value="{ORDER.id}">
                <div class="col-md-4">
                    <label class="form-label">Trạng thái đơn hàng</label>
                    <select name="order_status" class="form-select form-select-sm">
                        <option value="0" {ORDER.order_status_0_selected}>Chờ xử lý</option>
                        <option value="1" {ORDER.order_status_1_selected}>Đang xử lý</option>
                        <option value="2" {ORDER.order_status_2_selected}>Đã giao</option>
                        <option value="3" {ORDER.order_status_3_selected}>Đã hủy</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Trạng thái thanh toán</label>
                    <select name="payment_status" class="form-select form-select-sm" {ORDER.payment_disabled}>
                        <option value="0" {ORDER.payment_status_0_selected}>Chưa thanh toán</option>
                        <option value="1" {ORDER.payment_status_1_selected}>Đã thanh toán</option>
                    </select>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <button type="submit" name="update_status" class="btn btn-sm btn-primary">
                        <i class="fas fa-save"></i> Cập nhật
                    </button>
                </div>
            </form>
        </div>
    </div>
    <!-- END: order_loop -->

    <!-- BEGIN: no_orders -->
    <div class="card">
        <div class="card-body text-center py-5">
            <i class="fas fa-shopping-bag fa-4x text-muted mb-3"></i>
            <h4 class="text-muted">Không có đơn hàng nào</h4>
        </div>
    </div>
    <!-- END: no_orders -->

    <!-- BEGIN: generate_page -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <!-- BEGIN: prev -->
            <li class="page-item">
                <a class="page-link" href="{PREV.link}" {PREV.attr}>
                    <i class="fas fa-chevron-left"></i>
                </a>
            </li>
            <!-- END: prev -->

            <!-- BEGIN: page -->
            <li class="page-item <!-- BEGIN: current -->active<!-- END: current -->">
                <a class="page-link" href="{PAGE.link}">{PAGE.num}</a>
            </li>
            <!-- END: page -->

            <!-- BEGIN: next -->
            <li class="page-item">
                <a class="page-link" href="{NEXT.link}" {NEXT.attr}>
                    <i class="fas fa-chevron-right"></i>
                </a>
            </li>
            <!-- END: next -->
        </ul>
    </nav>
    <!-- END: generate_page -->
</div>
<!-- END: main -->
