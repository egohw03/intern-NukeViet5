<!-- BEGIN: main -->
<div class="container-fluid" style="font-size: 20px; line-height: 1.8;">
    <div class="page-header">
        <div class="d-flex justify-content-between align-items-center py-4">
            <div>
                <h1 class="h2 mb-2" style="color: #333;">{LANG.orders}</h1>
                <p class="text-muted mb-0" style="font-size: 18px;">Quản lý các đơn hàng</p>
            </div>
            <!-- BEGIN: export_button -->
            <a href="{EXPORT_URL}" class="btn btn-success btn-lg" style="font-size: 18px; font-weight: bold;">
                <i class="fas fa-file-excel"></i> Xuất Excel
            </a>
            <!-- END: export_button -->
        </div>
    </div>

    <!-- BEGIN: admin_message -->
    <div class="alert alert-info" style="font-size: 18px; padding: 20px;">{ADMIN_MESSAGE}</div>
    <!-- END: admin_message -->

    <!-- Filter Tabs -->
    <div class="card mb-4" style="box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-radius: 12px;">
        <div class="card-header bg-primary text-white" style="font-size: 20px; font-weight: bold; padding: 20px;">
            <h5 class="mb-0" style="font-size: 24px;">Lọc đơn hàng</h5>
        </div>
        <div class="card-body" style="padding: 25px;">
            <div class="d-flex flex-wrap gap-3">
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-outline-primary btn-lg" style="font-size: 18px; font-weight: bold; padding: 12px 20px; border-radius: 8px;">
                    {LANG.all} <span class="badge bg-secondary ms-2" style="font-size: 14px;">{ALL_COUNT}</span>
                </a>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=0" class="btn btn-outline-warning btn-lg" style="font-size: 18px; font-weight: bold; padding: 12px 20px; border-radius: 8px;">
                    {LANG.order_pending} <span class="badge bg-warning text-dark ms-2" style="font-size: 14px;">{PENDING_COUNT}</span>
                </a>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=1" class="btn btn-outline-info btn-lg" style="font-size: 18px; font-weight: bold; padding: 12px 20px; border-radius: 8px;">
                    {LANG.order_processing} <span class="badge bg-info ms-2" style="font-size: 14px;">{PROCESSING_COUNT}</span>
                </a>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=2" class="btn btn-outline-success btn-lg" style="font-size: 18px; font-weight: bold; padding: 12px 20px; border-radius: 8px;">
                    {LANG.order_delivered} <span class="badge bg-success ms-2" style="font-size: 14px;">{DELIVERED_COUNT}</span>
                </a>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=3" class="btn btn-outline-danger btn-lg" style="font-size: 18px; font-weight: bold; padding: 12px 20px; border-radius: 8px;">
                    {LANG.order_cancelled} <span class="badge bg-danger ms-2" style="font-size: 14px;">{CANCELLED_COUNT}</span>
                </a>
            </div>
        </div>
    </div>

    <!-- Orders Table -->
    <div class="card" style="box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-radius: 12px;">
        <div class="card-header bg-dark text-white" style="font-size: 20px; font-weight: bold; padding: 20px;">
            <h5 class="mb-0" style="font-size: 24px;">{LANG.orders}</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0" style="font-size: 18px;">
                    <thead class="table-dark" style="font-size: 20px;">
                        <tr>
                            <th class="text-center" style="padding: 20px;">{LANG.order_code}</th>
                            <th style="padding: 20px;">{LANG.customer_name}</th>
                            <th style="padding: 20px;">{LANG.total_amount}</th>
                            <th style="padding: 20px;">{LANG.order_status}</th>
                            <th style="padding: 20px;">{LANG.payment_status}</th>
                            <th style="padding: 20px;">{LANG.add_time}</th>
                            <th class="text-center" style="padding: 20px;">{LANG.actions}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: order_loop -->
                        <tr>
                            <td class="text-center" style="padding: 20px;">
                                <strong class="text-primary" style="font-size: 18px;">{ORDER.order_code}</strong>
                                <!-- BEGIN: transaction_id -->
                                <br><small class="text-muted" style="font-size: 14px;">TXN: {ORDER.transaction_id}</small>
                                <!-- END: transaction_id -->
                            </td>
                            <td style="padding: 20px;">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 45px; height: 45px; font-size: 18px; font-weight: bold;">
                                        {ORDER.customer_initial}
                                    </div>
                                    <div>
                                        <strong class="text-dark" style="font-size: 18px;">{ORDER.customer_name}</strong>
                                        <br><small class="text-muted" style="font-size: 14px;">{ORDER.customer_email}</small>
                                    </div>
                                </div>
                            </td>
                            <td style="padding: 20px;">
                                <div>
                                    <strong class="text-success" style="font-size: 20px;">{ORDER.total_amount_format}</strong>
                                    <!-- BEGIN: discount -->
                                    <div class="mt-2">
                                        <small class="text-danger" style="font-size: 16px;">
                                            Giảm: {ORDER.discount_amount_format}
                                        </small>
                                    </div>
                                    <!-- END: discount -->
                                </div>
                            </td>
                            <td style="padding: 20px;">
                                <form method="post" action="" class="d-inline">
                                    <select name="order_status" class="form-select d-inline" style="width: auto; font-size: 16px; padding: 8px 12px; margin-right: 10px;">
                                    <option value="0" {ORDER.order_status_0_selected}>Chờ xử lý</option>
                                    <option value="1" {ORDER.order_status_1_selected}>Đang xử lý</option>
                                    <option value="2" {ORDER.order_status_2_selected}>Đã giao</option>
                                    <option value="3" {ORDER.order_status_3_selected}>Đã hủy</option>
                                    </select>
                                    <input type="hidden" name="order_id" value="{ORDER.id}">
                                    <button type="submit" name="update_status" class="btn btn-success btn-lg">Cập nhật</button>
                                </form>
                            </td>
                            <td style="padding: 20px;">
                                <form method="post" action="" class="d-inline">
                                    <select name="payment_status" id="payment_status_{ORDER.id}" class="form-select d-inline" style="width: auto; font-size: 16px; padding: 8px 12px; margin-right: 10px;">
                                    <option value="0" {ORDER.payment_status_0_selected}>Chưa thanh toán</option>
                                    <option value="1" {ORDER.payment_status_1_selected} {ORDER.payment_disabled}>Đã thanh toán</option>
                                    </select>
                                    <input type="hidden" name="order_id" value="{ORDER.id}">
                                    <button type="submit" name="update_status" class="btn btn-warning btn-lg">Cập nhật</button>
                                </form>
                            </td>
                            <td style="padding: 20px;">
                                <small class="text-muted" style="font-size: 16px;">{ORDER.add_time}</small>
                                <!-- BEGIN: edit_time -->
                                <div class="mt-2">
                                    <small class="text-success" style="font-size: 14px;">
                                        {ORDER.edit_time}
                                    </small>
                                </div>
                                <!-- END: edit_time -->
                            </td>
                            <td class="text-center" style="padding: 20px;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=view_order&id={ORDER.id}" class="btn btn-primary btn-lg" title="{LANG.view_order}">
                            {LANG.view}
                            </a>
                            </td>
                            </tr>
                                <!-- END: order_loop -->
                                </tbody>
                                </table>
            </div>

            <!-- BEGIN: no_orders -->
            <div style="text-align: center; padding: 60px 20px;">
                <div style="font-size: 64px; color: #6c757d; margin-bottom: 20px;">📦</div>
                <h3 style="color: #333; margin-bottom: 10px;">{LANG.no_orders}</h3>
                <p style="font-size: 18px; color: #666;">{LANG.no_orders_message}</p>
            </div>
            <!-- END: no_orders -->
        </div>
    </div>

    <!-- BEGIN: pagination -->
    <div style="text-align: center; margin-top: 35px;">
        <nav aria-label="Page navigation">
            <ul style="list-style: none; display: inline-flex; gap: 10px;">
                <!-- BEGIN: page -->
                <li style="{PAGE.style}">
                    <a href="{PAGE.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid {PAGE.border}; border-radius: 8px; color: {PAGE.color}; font-size: 18px; font-weight: bold;">{PAGE.num}</a>
                </li>
                <!-- END: page -->
            </ul>
        </nav>
    </div>
    <!-- END: pagination -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
