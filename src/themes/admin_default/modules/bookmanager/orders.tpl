<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div class="page-header">
        <div class="container-fluid">
            <div class="header-content">
                <div class="d-flex justify-content-between align-items-center">
                <h1 class="h3 mb-0">{LANG.orders}</h1>
                <div class="d-flex gap-2">
                <!-- BEGIN: export_button -->
                <a href="{EXPORT_URL}" class="btn btn-light">
                        Xuất Excel
                        </a>
                        <!-- END: export_button -->
                </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">

    

        <!-- Filter Tabs -->
        <div class="card mb-4">
        <div class="card-header">
        <h5 class="mb-0">Lọc đơn hàng</h5>
        </div>
        <div class="card-body">
        <ul class="nav nav-pills">
        <li class="nav-item">
        <a class="nav-link {ALL_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders">
        {LANG.all}
        <span class="badge bg-secondary ms-1">{ALL_COUNT}</span>
        </a>
        </li>
        <li class="nav-item">
        <a class="nav-link {PENDING_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=0">
        {LANG.order_pending}
        <span class="badge bg-warning ms-1">{PENDING_COUNT}</span>
        </a>
        </li>
        <li class="nav-item">
        <a class="nav-link {PROCESSING_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=1">
        {LANG.order_processing}
        <span class="badge bg-info ms-1">{PROCESSING_COUNT}</span>
        </a>
        </li>
        <li class="nav-item">
        <a class="nav-link {COMPLETED_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=2">
        {LANG.order_delivered}
        <span class="badge bg-success ms-1">{COMPLETED_COUNT}</span>
        </a>
        </li>
        <li class="nav-item">
        <a class="nav-link {CANCELLED_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=3">
        {LANG.order_cancelled}
        <span class="badge bg-danger ms-1">{CANCELLED_COUNT}</span>
        </a>
        </li>
        </ul>
        </div>
        </div>

    <!-- Orders Table -->
    <div class="card">
    <div class="card-header">
        <h5 class="mb-0">{LANG.orders}</h5>
        </div>
    <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>{LANG.order_code}</th>
                            <th>{LANG.customer_name}</th>
                            <th>{LANG.total_amount}</th>
                            <th>{LANG.order_status}</th>
                            <th>{LANG.payment_status}</th>
                            <th>{LANG.add_time}</th>
                            <th class="text-center">{LANG.actions}</th>
                        </tr>
                    </thead>
                    <tbody>
                    <!-- BEGIN: order_loop -->
                    <tr class="hover-lift">
                    <td>
                    <strong class="text-primary">{ORDER.order_code}</strong>
                        <!-- BEGIN: transaction_id -->
                        <br><small class="text-muted">TXN: {ORDER.transaction_id}</small>
                    <!-- END: transaction_id -->
                    </td>
                    <td>
                        <div class="d-flex align-items-center">
                        <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2 fw-bold" style="width: 35px; height: 35px; font-size: 16px;">
                        {ORDER.customer_name|substr:0:1|upper}
                        </div>
                        <div>
                                <strong class="text-dark">{ORDER.customer_name}</strong>
                                <br><small class="text-muted">{ORDER.customer_email}</small>
                        </div>
                        </div>
                    </td>
                    <td>
                        <div>
                            <strong class="text-success fs-6">{ORDER.total_amount_format}</strong>
                        <!-- BEGIN: discount -->
                        <div class="mt-1">
                        <small class="text-danger">
                        Giảm: {ORDER.discount_amount_format}
                        </small>
                        </div>
                        <!-- END: discount -->
                                </div>
                            </td>
                            <td>
                                <span class="status-badge status-{ORDER.order_status_text}">{ORDER.order_status_text}</span>
                            </td>
                            <td>
                                <span class="status-badge status-{ORDER.payment_status_text}">{ORDER.payment_status_text}</span>
                            </td>
                            <td>
                                <small class="text-muted">{ORDER.add_time}</small>
                                <!-- BEGIN: edit_time -->
                                <div class="mt-1">
                                <small class="text-success">
                                {ORDER.edit_time}
                                </small>
                                </div>
                                <!-- END: edit_time -->
                            </td>
                            <td>
                            <div class="action-buttons d-flex gap-1">
                                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=view_order&id={ORDER.id}" class="btn btn-outline-primary btn-sm" title="{LANG.view_order}">
                                {LANG.view}
                            </a>
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=update_order&id={ORDER.id}" class="btn btn-outline-success btn-sm" title="{LANG.update_order_status}">
                                {LANG.update}
                            </a>
                            </div>
                                </td>
                            </tr>
                                <!-- END: order_loop -->
                                </tbody>
                                </table>
            </div>

            <div class="card-body">
                <!-- BEGIN: no_orders -->
                <div class="text-center py-5">
                <h4 class="text-muted">{LANG.no_orders}</h4>
                <p class="text-muted">{LANG.no_orders_message}</p>
            </div>
                <!-- END: no_orders -->
            </div>
        </div>
    </div>

    <!-- Pagination -->
    <!-- BEGIN: pagination -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- BEGIN: page -->
            <li class="page-item {PAGE.current}">
                <a class="page-link" href="{PAGE.link}">{PAGE.num}</a>
            </li>
            <!-- END: page -->
        </ul>
    </nav>
    <!-- END: pagination -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
