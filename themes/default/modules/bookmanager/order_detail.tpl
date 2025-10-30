<!-- BEGIN: main -->
<div class="order-detail-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="fas fa-file-invoice"></i> {LANG.order_detail}
        </h2>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left"></i> {LANG.back_to_orders}
        </a>
    </div>

    <!-- Order Info -->
    <div class="row mb-4">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">
                        <i class="fas fa-info-circle"></i> {LANG.order_info}
                        <span class="badge ms-2">{ORDER.order_status_badge}</span>
                        <span class="badge ms-1">{ORDER.payment_status_badge}</span>
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>{LANG.order_code}:</strong> {ORDER.order_code}</p>
                            <p><strong>{LANG.add_time}:</strong> {ORDER.add_time_format}</p>
                            <p><strong>{LANG.payment_method}:</strong> {ORDER.payment_method_text}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>{LANG.customer_name}:</strong> {ORDER.customer_name}</p>
                            <p><strong>{LANG.customer_email}:</strong> {ORDER.customer_email}</p>
                            <p><strong>{LANG.customer_phone}:</strong> {ORDER.customer_phone}</p>
                            <p><strong>{LANG.customer_address}:</strong> {ORDER.customer_address}</p>
                        </div>
                    </div>

                    <!-- BEGIN: order_note -->
                    <div class="mt-3">
                        <strong>{LANG.order_note}:</strong>
                        <p class="mt-1">{ORDER.order_note}</p>
                    </div>
                    <!-- END: order_note -->
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">
                        <i class="fas fa-calculator"></i> {LANG.order_summary}
                    </h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>{LANG.subtotal}:</span>
                        <span class="fw-bold">{ORDER.total_amount_format}</span>
                    </div>

                    <!-- BEGIN: discount_info -->
                    <div class="d-flex justify-content-between mb-2 text-success">
                        <span>{LANG.discount}:</span>
                        <span class="fw-bold">-{ORDER.discount_amount_format}</span>
                    </div>
                    <!-- END: discount_info -->

                    <hr>
                    <div class="d-flex justify-content-between">
                        <strong>{LANG.total}:</strong>
                        <strong class="text-primary">{ORDER.final_total_format}</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Items -->
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">
                <i class="fas fa-shopping-bag"></i> {LANG.order_items}
            </h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>{LANG.image}</th>
                            <th>{LANG.title}</th>
                            <th>{LANG.unit_price}</th>
                            <th>{LANG.quantity}</th>
                            <th>{LANG.subtotal}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: item -->
                        <tr>
                            <td>
                                <!-- BEGIN: image -->
                                <img src="{ITEM.image_url}" alt="{ITEM.title}" class="img-thumbnail" style="width: 60px; height: 80px; object-fit: cover;">
                                <!-- END: image -->
                                <!-- BEGIN: no_image -->
                                <div class="bg-light d-flex align-items-center justify-content-center" style="width: 60px; height: 80px;">
                                    <i class="fas fa-book text-muted"></i>
                                </div>
                                <!-- END: no_image -->
                            </td>
                            <td>
                                <strong>{ITEM.title}</strong>
                                <br><small class="text-muted">ID: {ITEM.book_id}</small>
                            </td>
                            <td class="fw-bold">{ITEM.price_format}</td>
                            <td>{ITEM.quantity}</td>
                            <td class="fw-bold text-primary">{ITEM.subtotal}</td>
                        </tr>
                        <!-- END: item -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="text-center mt-4">
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-primary me-2">
            <i class="fas fa-list"></i> {LANG.view_orders}
        </a>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-primary">
            <i class="fas fa-shopping-cart"></i> {LANG.continue_shopping}
        </a>
    </div>
</div>
<!-- END: main -->
