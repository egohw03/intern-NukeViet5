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
        <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
        <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
        <h5 style="margin: 0;">Lọc đơn hàng</h5>
        </div>
        <div style="padding: 20px;">
        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 8px 16px; background: {ALL_ACTIVE_BG}; color: {ALL_ACTIVE_COLOR}; text-decoration: none; border-radius: 4px; border: 1px solid #ddd;">
        {LANG.all} <span style="background: #6c757d; color: white; padding: 2px 6px; border-radius: 10px; font-size: 12px;">{ALL_COUNT}</span>
        </a>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=0" style="display: inline-block; padding: 8px 16px; background: {PENDING_ACTIVE_BG}; color: {PENDING_ACTIVE_COLOR}; text-decoration: none; border-radius: 4px; border: 1px solid #ddd;">
        {LANG.order_pending} <span style="background: #ffc107; color: black; padding: 2px 6px; border-radius: 10px; font-size: 12px;">{PENDING_COUNT}</span>
        </a>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=1" style="display: inline-block; padding: 8px 16px; background: {PROCESSING_ACTIVE_BG}; color: {PROCESSING_ACTIVE_COLOR}; text-decoration: none; border-radius: 4px; border: 1px solid #ddd;">
        {LANG.order_processing} <span style="background: #0dcaf0; color: white; padding: 2px 6px; border-radius: 10px; font-size: 12px;">{PROCESSING_COUNT}</span>
        </a>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=2" style="display: inline-block; padding: 8px 16px; background: {DELIVERED_ACTIVE_BG}; color: {DELIVERED_ACTIVE_COLOR}; text-decoration: none; border-radius: 4px; border: 1px solid #ddd;">
        {LANG.order_delivered} <span style="background: #198754; color: white; padding: 2px 6px; border-radius: 10px; font-size: 12px;">{DELIVERED_COUNT}</span>
        </a>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=3" style="display: inline-block; padding: 8px 16px; background: {CANCELLED_ACTIVE_BG}; color: {CANCELLED_ACTIVE_COLOR}; text-decoration: none; border-radius: 4px; border: 1px solid #ddd;">
        {LANG.order_cancelled} <span style="background: #dc3545; color: white; padding: 2px 6px; border-radius: 10px; font-size: 12px;">{CANCELLED_COUNT}</span>
        </a>
        </div>
        </div>
        </div>

    <!-- Orders Table -->
    <div style="background: white; border: 1px solid #ddd; border-radius: 8px;">
    <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
    <h5 style="margin: 0;">{LANG.orders}</h5>
    </div>
    <div style="overflow-x: auto;">
    <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                    <tr style="background: #f8f9fa;">
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.order_code}</th>
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.customer_name}</th>
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.total_amount}</th>
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.order_status}</th>
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.payment_status}</th>
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.add_time}</th>
                    <th style="padding: 12px; text-align: center; border-bottom: 1px solid #ddd;">{LANG.actions}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- BEGIN: order_loop -->
                    <tr style="border-bottom: 1px solid #eee; background: white;">
                    <td style="padding: 12px; border-bottom: 1px solid #eee;">
                    <strong style="color: #007bff;">{ORDER.order_code}</strong>
                        <!-- BEGIN: transaction_id -->
                        <br><small style="color: #666;">TXN: {ORDER.transaction_id}</small>
                        <!-- END: transaction_id -->
                        </td>
                        <td style="padding: 12px; border-bottom: 1px solid #eee;">
                        <div style="display: flex; align-items: center;">
                        <div style="background: #007bff; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; width: 35px; height: 35px; font-size: 16px; font-weight: bold; margin-right: 10px;">
                        {ORDER.customer_name|substr:0:1|upper}
                        </div>
                        <div>
                        <strong style="color: #333;">{ORDER.customer_name}</strong>
                        <br><small style="color: #666;">{ORDER.customer_email}</small>
                        </div>
                        </div>
                        </td>
                        <td style="padding: 12px; border-bottom: 1px solid #eee;">
                        <div>
                        <strong style="color: #28a745; font-size: 16px;">{ORDER.total_amount_format}</strong>
                        <!-- BEGIN: discount -->
                        <div style="margin-top: 5px;">
                        <small style="color: #dc3545;">
                        Giảm: {ORDER.discount_amount_format}
                        </small>
                        </div>
                        <!-- END: discount -->
                        </div>
                        </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
                            <form method="post" action="" style="display: inline;">
                            <select name="order_status" style="padding: 4px 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;">
                            <option value="0" {ORDER.order_status_0_selected}>Chờ xử lý</option>
                            <option value="1" {ORDER.order_status_1_selected}>Đang xử lý</option>
                            <option value="2" {ORDER.order_status_2_selected}>Đã giao</option>
                            <option value="3" {ORDER.order_status_3_selected}>Đã hủy</option>
                            </select>
                            </form>
                            </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
                            <form method="post" action="" style="display: inline;">
                            <select name="payment_status" style="padding: 4px 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;">
                            <option value="0" {ORDER.payment_status_0_selected}>Chưa thanh toán</option>
                            <option value="1" {ORDER.payment_status_1_selected}>Đã thanh toán</option>
                            </select>
                            <input type="hidden" name="order_id" value="{ORDER.id}">
                            <button type="submit" name="update_status" style="padding: 4px 8px; background: #007bff; color: white; border: none; border-radius: 4px; font-size: 14px; margin-left: 5px; cursor: pointer;">Cập nhật</button>
                            </form>
                            </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
                            <small style="color: #666;">{ORDER.add_time}</small>
                            <!-- BEGIN: edit_time -->
                            <div style="margin-top: 5px;">
                            <small style="color: #28a745;">
                            {ORDER.edit_time}
                            </small>
                            </div>
                            <!-- END: edit_time -->
                            </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee; text-align: center;">
                            <div style="display: flex; gap: 5px; justify-content: center;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=view_order&id={ORDER.id}" style="padding: 6px 12px; background: transparent; color: #007bff; text-decoration: none; border: 1px solid #007bff; border-radius: 4px; font-size: 14px;" title="{LANG.view_order}">
                            {LANG.view}
                            </a>
                            </div>
                            </td>
                            </tr>
                                <!-- END: order_loop -->
                                </tbody>
                                </table>
            </div>

            <div style="padding: 20px;">
            <!-- BEGIN: no_orders -->
            <div style="text-align: center; padding: 60px 20px;">
            <h4 style="color: #666; margin: 0 0 10px 0;">{LANG.no_orders}</h4>
            <p style="color: #666; margin: 0;">{LANG.no_orders_message}</p>
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
