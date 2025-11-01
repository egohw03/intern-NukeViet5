<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="margin-bottom: 35px; overflow: hidden;">
<div style="float: left;">
<h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.orders}</h1>
<p style="font-size: 18px; color: #666; margin: 5px 0 0;">Tổng cộng: {TOTAL_ORDERS} đơn hàng</p>
</div>
<div style="float: right;">
<!-- BEGIN: export_button -->
<a href="{EXPORT_URL}" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">
<i class="fas fa-file-excel"></i> Xuất Excel
</a>
<!-- END: export_button -->
</div>
</div>



<!-- BEGIN: admin_message -->
<div style="background: #d1ecf1; border: 2px solid #bee5eb; color: #0c5460; padding: 20px; border-radius: 8px; font-size: 18px; margin-bottom: 25px;">{ADMIN_MESSAGE}</div>
<!-- END: admin_message -->

<!-- Filter Tabs -->
<div style="background: #fff; border: 3px solid #007bff; padding: 25px; border-radius: 15px; margin-bottom: 35px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
<div style="margin-bottom: 20px;">
<h5 style="font-size: 24px; margin: 0; color: #333;">Lọc đơn hàng</h5>
</div>
<div style="overflow: hidden;">
<a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="float: left; padding: 12px 20px; background: {ALL_ACTIVE_BG}; color: {ALL_ACTIVE_COLOR}; border: 2px solid #007bff; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; margin-right: 15px; margin-bottom: 10px;">
{LANG.all} <span style="background: #6c757d; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{ALL_COUNT}</span>
</a>
<a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=0" style="float: left; padding: 12px 20px; background: {PENDING_ACTIVE_BG}; color: {PENDING_ACTIVE_COLOR}; border: 2px solid #ffc107; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; margin-right: 15px; margin-bottom: 10px;">
{LANG.order_pending} <span style="background: #ffc107; color: #000; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{PENDING_COUNT}</span>
</a>
<a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=1" style="float: left; padding: 12px 20px; background: {PROCESSING_ACTIVE_BG}; color: {PROCESSING_ACTIVE_COLOR}; border: 2px solid #17a2b8; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; margin-right: 15px; margin-bottom: 10px;">
{LANG.order_processing} <span style="background: #17a2b8; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{PROCESSING_COUNT}</span>
</a>
<a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=2" style="float: left; padding: 12px 20px; background: {DELIVERED_ACTIVE_BG}; color: {DELIVERED_ACTIVE_COLOR}; border: 2px solid #28a745; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; margin-right: 15px; margin-bottom: 10px;">
{LANG.order_delivered} <span style="background: #28a745; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{DELIVERED_COUNT}</span>
</a>
<a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders&status=3" style="float: left; padding: 12px 20px; background: {CANCELLED_ACTIVE_BG}; color: {CANCELLED_ACTIVE_COLOR}; border: 2px solid #dc3545; border-radius: 8px; font-size: 16px; font-weight: bold; text-decoration: none; margin-right: 15px; margin-bottom: 10px;">
{LANG.order_cancelled} <span style="background: #dc3545; color: #fff; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 8px;">{CANCELLED_COUNT}</span>
</a>
</div>
</div>

    <!-- Orders Table -->
    <div style="background: #fff; border: 3px solid #333; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="padding: 25px; background: #f8f9fa; border-bottom: 2px solid #333; overflow: hidden;">
    <div style="float: left;">
    <h2 style="font-size: 24px; margin: 0; color: #333;">{LANG.orders}</h2>
    </div>
    <div style="float: right;">
    <p style="font-size: 18px; color: #666; margin: 0;">Hiển thị {TOTAL_ORDERS} đơn hàng</p>
    </div>
    </div>
    <div style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; font-size: 18px;">
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
                        <tr style="background: #f9f9f9; border-bottom: 1px solid #ddd;">
                            <td style="padding: 20px; text-align: center;">
                                <strong style="font-size: 18px; color: #007bff;">{ORDER.order_code}</strong>
                                <!-- BEGIN: transaction_id -->
                                <br><small style="font-size: 14px; color: #666;">TXN: {ORDER.transaction_id}</small>
                                <!-- END: transaction_id -->
                            </td>
                            <td style="padding: 20px;">
                                <div style="overflow: hidden;">
                                    <div style="float: left; width: 45px; height: 45px; background: #007bff; color: #fff; border-radius: 50%; text-align: center; line-height: 45px; font-size: 18px; font-weight: bold; margin-right: 15px;">
                                        {ORDER.customer_initial}
                                    </div>
                                    <div style="float: left;">
                                        <div style="font-size: 18px; font-weight: bold; color: #333; margin-bottom: 5px;">{ORDER.customer_name}</div>
                                        <div style="font-size: 14px; color: #666;">{ORDER.customer_email}</div>
                                    </div>
                                </div>
                            </td>
                            <td style="padding: 20px;">
                                <div>
                                    <div style="font-size: 20px; font-weight: bold; color: #28a745; margin-bottom: 5px;">{ORDER.total_amount_format}</div>
                                    <!-- BEGIN: discount -->
                                    <div style="font-size: 16px; color: #dc3545;">
                                        Giảm: {ORDER.discount_amount_format}
                                    </div>
                                    <!-- END: discount -->
                                </div>
                            </td>
                            <td style="padding: 20px;">
                                <form method="post" action="" style="display: inline;">
                                    <select name="order_status" style="width: auto; font-size: 16px; padding: 8px 12px; margin-right: 10px; border: 2px solid #28a745; border-radius: 6px;">
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
                                <form method="post" action="" style="display: inline;">
                                    <select name="payment_status" id="payment_status_{ORDER.id}" style="width: auto; font-size: 16px; padding: 8px 12px; margin-right: 10px; border: 2px solid #ffc107; border-radius: 6px;" {ORDER.payment_disabled}>
                                    <option value="0" {ORDER.payment_status_0_selected}>Chưa thanh toán</option>
                                    <option value="1" {ORDER.payment_status_1_selected}>Đã thanh toán</option>
                                    </select>
                                    <input type="hidden" name="order_id" value="{ORDER.id}">
                                    <button type="submit" name="update_status" style="padding: 8px 16px; background: #ffc107; color: #333; border: 2px solid #ffc107; border-radius: 6px; font-size: 16px; font-weight: bold;">Cập nhật</button>
                                </form>
                            </td>
                            <td style="padding: 20px;">
                                <div style="font-size: 16px; color: #666;">{ORDER.add_time_format}</div>
                                <!-- BEGIN: edit_time -->
                                <div style="font-size: 14px; color: #28a745; margin-top: 5px;">
                                    {ORDER.edit_time}
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

    <!-- BEGIN: generate_page -->
    <div style="text-align: center; margin-top: 30px;">
        <div style="display: inline-block;">
            <!-- BEGIN: prev -->
            <a href="{PREV.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid #007bff; border-radius: 8px; color: {PREV.color}; font-size: 18px; font-weight: bold; margin-right: 10px; {PREV.style}" {PREV.attr}>Trước</a>
            <!-- END: prev -->

            <!-- BEGIN: page -->
            <a href="{PAGE.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid {PAGE.border}; border-radius: 8px; color: {PAGE.color}; font-size: 18px; font-weight: bold; margin-right: 10px; {PAGE.style}">{PAGE.num}</a>
            <!-- END: page -->

            <!-- BEGIN: next -->
            <a href="{NEXT.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid #007bff; border-radius: 8px; color: {NEXT.color}; font-size: 18px; font-weight: bold; {NEXT.style}" {NEXT.attr}>Sau</a>
            <!-- END: next -->
        </div>
    </div>
    <!-- END: generate_page -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
