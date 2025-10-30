<!-- BEGIN: main -->
<div class="orders-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="fas fa-list"></i> {LANG.my_orders}
        </h2>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}"
           class="btn btn-outline-primary">
            <i class="fas fa-arrow-left"></i> {LANG.continue_shopping}
        </a>
    </div>

    <!-- BEGIN: order_loop -->
    <div class="card mb-3">
        <div class="card-header d-flex justify-content-between align-items-center">
            <div>
                <strong>{LANG.order_code}:</strong> {ORDER.order_code}
                <span class="badge bg-{ORDER.status_badge} ms-2">{ORDER.order_status_text}</span>
                <span class="badge bg-{ORDER.payment_badge}">{ORDER.payment_status_text}</span>
            </div>
            <small class="text-muted">{ORDER.add_time}</small>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-8">
                    <p><strong>{LANG.customer_name}:</strong> {ORDER.customer_name}</p>
                    <p><strong>{LANG.customer_email}:</strong> {ORDER.customer_email}</p>
                    <p><strong>{LANG.customer_phone}:</strong> {ORDER.customer_phone}</p>
                    <p><strong>{LANG.customer_address}:</strong> {ORDER.customer_address}</p>
                    <p><strong>{LANG.payment_method}:</strong> {ORDER.payment_method_text}</p>
                </div>
                <div class="col-md-4 text-end">
                    <h4 class="text-primary mb-3">{ORDER.total_amount_format}</h4>
                    <!-- BEGIN: view_detail -->
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=payment&order_code={ORDER.order_code}"
                       class="btn btn-sm btn-info me-1">
                        <i class="fas fa-credit-card"></i> Thanh toán
                    </a>
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=order_detail&id={ORDER.id}"
                       class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-eye"></i> {LANG.view_detail}
                    </a>
                    <!-- END: view_detail -->
                </div>
            </div>
        </div>
    </div>
    <!-- END: order_loop -->

    <!-- BEGIN: no_orders -->
    <div class="card">
        <div class="card-body text-center py-5">
            <i class="fas fa-shopping-bag fa-4x text-muted mb-3"></i>
            <h4 class="text-muted">{LANG.no_orders}</h4>
            <p class="text-muted">{LANG.no_orders_message}</p>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}"
               class="btn btn-primary">
                <i class="fas fa-shopping-cart"></i> {LANG.continue_shopping}
            </a>
        </div>
    </div>
    <!-- END: no_orders -->
</div>
<!-- END: main -->
