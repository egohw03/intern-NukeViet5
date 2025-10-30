<!-- BEGIN: main -->
<div class="my-orders">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3 mb-0">Đơn hàng của tôi</h1>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-primary">
                    <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                </a>
            </div>
        </div>
    </div>

    <!-- BEGIN: order_loop -->
    <div class="card mb-3">
        <div class="card-header">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h6 class="mb-0">Đơn hàng #{ORDER.order_code}</h6>
                    <small class="text-muted">Ngày đặt: {ORDER.add_time}</small>
                </div>
                <div class="col-md-6 text-end">
                    <span class="badge bg-{ORDER.status_class}">{ORDER.order_status_text}</span>
                    <span class="badge bg-{ORDER.payment_class} ms-1">{ORDER.payment_status_text}</span>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-8">
                    <p class="mb-1"><strong>Người nhận:</strong> {ORDER.customer_name}</p>
                    <p class="mb-1"><strong>Email:</strong> {ORDER.customer_email}</p>
                    <p class="mb-1"><strong>SĐT:</strong> {ORDER.customer_phone}</p>
                    <p class="mb-1"><strong>Địa chỉ:</strong> {ORDER.customer_address}</p>
                    <p class="mb-1"><strong>PT thanh toán:</strong> {ORDER.payment_method}</p>
                </div>
                <div class="col-md-4 text-end">
                    <h5 class="text-primary mb-0">{ORDER.total_amount_format}</h5>
                    <small class="text-muted">Tổng tiền</small>
                </div>
            </div>
        </div>
    </div>
    <!-- END: order_loop -->

    <!-- BEGIN: no_orders -->
    <div class="card">
        <div class="card-body text-center py-5">
            <div class="text-muted mb-3">
                <i class="fas fa-receipt fa-4x"></i>
            </div>
            <h4>Bạn chưa có đơn hàng nào</h4>
            <p>Hãy bắt đầu mua sắm để có đơn hàng đầu tiên.</p>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary">
                <i class="fas fa-shopping-bag"></i> Mua sắm ngay
            </a>
        </div>
    </div>
    <!-- END: no_orders -->
</div>
<!-- END: main -->
