<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
<div>
<h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.orders}</h1>
<p style="font-size: 18px; color: #666; margin: 5px 0 0;">Quản lý các đơn hàng</p>
</div>
<!-- BEGIN: export_button -->
<a href="{EXPORT_URL}" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">
<i class="fas fa-file-excel"></i> Xuất Excel
</a>
<!-- END: export_button -->
</div>

    <!-- BEGIN: admin_message -->
    <div style="background: #d1ecf1; border: 2px solid #bee5eb; color: #0c5460; padding: 20px; border-radius: 8px; font-size: 18px; margin-bottom: 25px;">{ADMIN_MESSAGE}</div>
    <!-- END: admin_message -->

    <!-- Filter Tabs -->
    <div style="background: #fff; border: 3px solid #007bff; padding: 25px; border-radius: 15px; margin-bottom: 35px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="margin-bottom: 20px;">
            <h5 style="font-size: 24px; margin: 0; color: #333;">Lọc đơn hàng</h5>
        </div>
            <div class="d-flex flex-wrap gap-3">
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="padding: 12px 20px; background: transparent; color: #007bff; border: 2px solid #007bff; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; transition: all 0.3s ease;" onmouseover="this.style.background='#007bff'; this.style.color='#fff';" onmouseout="this.style.background='transparent'; this.style.color='#007bff';">
            {LANG.all} <span style="background: #6c757d; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{ALL_COUNT}</span>
            </a>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=0" style="padding: 12px 20px; background: transparent; color: #ffc107; border: 2px solid #ffc107; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; transition: all 0.3s ease;" onmouseover="this.style.background='#ffc107'; this.style.color='#000';" onmouseout="this.style.background='transparent'; this.style.color='#ffc107';">
            {LANG.order_pending} <span style="background: #ffc107; color: #000; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{PENDING_COUNT}</span>
            </a>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=1" style="padding: 12px 20px; background: transparent; color: #17a2b8; border: 2px solid #17a2b8; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; transition: all 0.3s ease;" onmouseover="this.style.background='#17a2b8'; this.style.color='#fff';" onmouseout="this.style.background='transparent'; this.style.color='#17a2b8';">
            {LANG.order_processing} <span style="background: #17a2b8; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{PROCESSING_COUNT}</span>
            </a>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=2" style="padding: 12px 20px; background: transparent; color: #28a745; border: 2px solid #28a745; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; transition: all 0.3s ease;" onmouseover="this.style.background='#28a745'; this.style.color='#fff';" onmouseout="this.style.background='transparent'; this.style.color='#28a745';">
            {LANG.order_delivered} <span style="background: #28a745; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{DELIVERED_COUNT}</span>
            </a>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=3" style="padding: 12px 20px; background: transparent; color: #dc3545; border: 2px solid #dc3545; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; transition: all 0.3s ease;" onmouseover="this.style.background='#dc3545'; this.style.color='#fff';" onmouseout="this.style.background='transparent'; this.style.color='#dc3545';">
            {LANG.order_cancelled} <span style="background: #dc3545; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{CANCELLED_COUNT}</span>
            </a>
            </div>
        </div>
    </div>

    <!-- Orders Table -->
    <div style="background: #fff; border: 3px solid #333; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="padding: 25px; background: #f8f9fa; border-bottom: 2px solid #333;">
    <div style="display: flex; justify-content: space-between; align-items: center;">
    <h2 style="font-size: 24px; margin: 0; color: #333;">{LANG.orders}</h2>
    <p style="font-size: 18px; color: #666; margin: 0;">Hiển thị {TOTAL_ORDERS} đơn hàng</p>
    </div>
    </div>
    <div style="overflow-x: auto;">
            <style>
            .orders-table tbody tr { background: #f9f9f9; border-bottom: 1px solid #ddd; }
            .orders-table tbody tr:hover { background: #f1f3f4 !important; }
            </style>
            <table class="orders-table" style="width: 100%; border-collapse: collapse; font-size: 18px;">
            <thead>
            <tr style="background: #007bff; color: #fff;">
            <th style="padding: 20px; text-align: center; font-size: 20px;">{LANG.order_code}</th>
            <th style="padding: 20px; font-size: 20px;">{LANG.customer_name}</th>
            <th style="padding: 20px; font-size: 20px;">{LANG.total_amount}</th>
                <th style="padding: 20px; font-size: 20px;">{LANG.order_status}</th>
                    <th style="padding: 20px; font-size: 20px;">{LANG.payment_status}</th>
                            <th style="padding: 20px; font-size: 20px;">{LANG.add_time}</th>
                            <th style="padding: 20px; text-align: center; font-size: 20px;">{LANG.actions}</th>
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
                                    <button type="submit" name="update_status" style="padding: 8px 16px; background: #28a745; color: #fff; border: 2px solid #28a745; border-radius: 6px; font-size: 16px; font-weight: bold;">Cập nhật</button>
                                </form>
                            </td>
                            <td style="padding: 20px;">
                                <form method="post" action="" class="d-inline">
                                    <select name="payment_status" id="payment_status_{ORDER.id}" class="form-select d-inline" style="width: auto; font-size: 16px; padding: 8px 12px; margin-right: 10px;">
                                    <option value="0" {ORDER.payment_status_0_selected}>Chưa thanh toán</option>
                                    <option value="1" {ORDER.payment_status_1_selected} {ORDER.payment_disabled}>Đã thanh toán</option>
                                    </select>
                                    <input type="hidden" name="order_id" value="{ORDER.id}">
                                    <button type="submit" name="update_status" style="padding: 8px 16px; background: #ffc107; color: #333; border: 2px solid #ffc107; border-radius: 6px; font-size: 16px; font-weight: bold;">Cập nhật</button>
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
                            <td style="padding: 20px; text-align: center;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=view_order&id={ORDER.id}" style="padding: 8px 16px; background: #28a745; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px; font-weight: bold;" title="{LANG.view_order}">
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
