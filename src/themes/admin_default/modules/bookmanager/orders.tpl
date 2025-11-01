<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
    <div>
    <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.orders}</h1>
    <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Tổng cộng: {TOTAL_ORDERS} đơn hàng</p>
    </div>
    <!-- BEGIN: export_button -->
    <a href="{EXPORT_URL}" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">
    <i class="fas fa-file-excel"></i> Xuất Excel
    </a>
    <!-- END: export_button -->
    </div>




    <!-- Quick Filters -->
    <div style="background: #fff; border: 3px solid #007bff; padding: 25px; border-radius: 15px; margin-bottom: 35px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <form method="get" action="{NV_BASE_ADMINURL}index.php" style="display: grid; grid-template-columns: 1fr 1fr 2fr 1fr; gap: 20px; align-items: end;">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
        <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
            <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />

            <div>
                <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 8px; color: #333;">Trạng thái đơn hàng</label>
                <select name="status" onchange="this.form.submit()" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px;">
                    <option value="-1" {STATUS_SELECTED_-1}>Tất cả</option>
                    <option value="0" {STATUS_SELECTED_0}>Chờ xử lý</option>
                    <option value="1" {STATUS_SELECTED_1}>Đang xử lý</option>
                    <option value="2" {STATUS_SELECTED_2}>Đã giao</option>
                    <option value="3" {STATUS_SELECTED_3}>Đã hủy</option>
                </select>
            </div>

            <div>
                <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 8px; color: #333;">Trạng thái thanh toán</label>
                <select name="payment_status" onchange="this.form.submit()" style="width: 100%; padding: 12px; border: 2px solid #28a745; border-radius: 8px; font-size: 16px;">
                    <option value="-1" {PAYMENT_STATUS_SELECTED_-1}>Tất cả</option>
                    <option value="0" {PAYMENT_STATUS_SELECTED_0}>Chưa thanh toán</option>
                    <option value="1" {PAYMENT_STATUS_SELECTED_1}>Đã thanh toán</option>
                </select>
            </div>

            <div>
                <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 8px; color: #333;">Tìm kiếm</label>
                <div style="display: flex;">
                    <input type="text" name="q" value="{SEARCH_QUERY}" placeholder="Mã đơn hàng, tên khách hàng..." style="flex: 1; padding: 12px; border: 2px solid #ffc107; border-radius: 8px 0 0 8px; font-size: 16px;" />
                    <button type="submit" style="padding: 12px 20px; background: #ffc107; color: #333; border: 2px solid #ffc107; border-radius: 0 8px 8px 0; font-size: 16px; font-weight: bold;">Tìm</button>
                </div>
            </div>

            <div style="text-align: right;">
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="padding: 12px 20px; background: #6c757d; color: #fff; text-decoration: none; border-radius: 8px; font-size: 16px;">Xóa lọc</a>
            </div>
        </form>
    </div>

    <!-- Orders Table -->
    <div style="background: #fff; border: 3px solid #333; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="padding: 25px; background: #f8f9fa; border-bottom: 2px solid #333;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2 style="font-size: 24px; margin: 0; color: #333;">Danh sách đơn hàng</h2>
                <p style="font-size: 18px; color: #666; margin: 0;">Hiển thị {TOTAL_ORDERS} đơn hàng</p>
            </div>
        </div>

        <div style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; font-size: 18px;">
                <thead>
                    <tr style="background: #007bff; color: #fff;">
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 140px;">Mã đơn hàng</th>
                        <th style="padding: 20px; font-size: 20px; width: 100px;">Khách hàng</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 130px;">Tổng tiền</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 130px;">Trạng thái</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 130px;">Thanh toán</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 140px;">Thời gian</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 130px;">Thao tác</th>
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
                        <div style="display: flex; align-items: center;">
                        <div style="width: 30px; height: 30px; background: #007bff; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: bold; margin-right: 8px;">
                        {ORDER.customer_initial}
                        </div>
                        <div>
                        <div style="font-size: 16px; font-weight: bold; color: #333; margin-bottom: 3px;">{ORDER.customer_name}</div>
                        <div style="font-size: 12px; color: #666;">{ORDER.customer_email}</div>
                        </div>
                        </div>
                        </td>
                        <td style="padding: 20px; text-align: center; font-size: 18px; font-weight: bold; color: #28a745;">{ORDER.total_amount_format}</td>
                        <td style="padding: 20px; text-align: center;">
                            <form method="post" action="" style="display: inline-block;">
                                <select name="order_status" style="width: 100%; font-size: 16px; padding: 8px 12px; margin-bottom: 8px; border: 2px solid #28a745; border-radius: 6px;">
                                <option value="0" {ORDER.order_status_0_selected}>Chờ xử lý</option>
                                <option value="1" {ORDER.order_status_1_selected}>Đang xử lý</option>
                                <option value="2" {ORDER.order_status_2_selected}>Đã giao</option>
                                <option value="3" {ORDER.order_status_3_selected}>Đã hủy</option>
                                </select>
                                <input type="hidden" name="order_id" value="{ORDER.id}">
                                <button type="submit" name="update_status" style="width: 100%; padding: 8px 16px; background: #28a745; color: #fff; border: 2px solid #28a745; border-radius: 6px; font-size: 16px; font-weight: bold;">Cập nhật</button>
                            </form>
                        </td>
                        <td style="padding: 20px; text-align: center;">
                            <form method="post" action="" style="display: inline-block;">
                                <select name="payment_status" id="payment_status_{ORDER.id}" style="width: 100%; font-size: 16px; padding: 8px 12px; margin-bottom: 8px; border: 2px solid #ffc107; border-radius: 6px;" {ORDER.payment_disabled}>
                                <option value="0" {ORDER.payment_status_0_selected}>Chưa thanh toán</option>
                                <option value="1" {ORDER.payment_status_1_selected}>Đã thanh toán</option>
                                </select>
                                <input type="hidden" name="order_id" value="{ORDER.id}">
                                <button type="submit" name="update_status" style="width: 100%; padding: 8px 16px; background: #ffc107; color: #333; border: 2px solid #ffc107; border-radius: 6px; font-size: 16px; font-weight: bold;">Cập nhật</button>
                            </form>
                        </td>
                        <td style="padding: 20px; text-align: center;">
                            <div style="font-size: 16px; color: #666;">{ORDER.add_time_format}</div>
                        </td>
                        <td style="padding: 20px; text-align: center;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=view_order&id={ORDER.id}" style="padding: 8px 16px; background: #28a745; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px; font-weight: bold;" title="{LANG.view_order}">
                            <i class="fa fa-eye"></i> Xem chi tiết
                            </a>
                        </td>
                    </tr>
                    <!-- END: order_loop -->
                </tbody>
            </table>
        </div>

        <!-- BEGIN: no_orders -->
        <div style="text-align: center; padding: 50px;">
            <div style="font-size: 48px; color: #6c757d; margin-bottom: 20px;">📦</div>
            <h3 style="color: #333; margin-bottom: 10px;">Chưa có đơn hàng nào</h3>
            <p style="font-size: 18px; color: #666; margin-bottom: 20px;">Hệ thống chưa có đơn hàng nào.</p>
        </div>
        <!-- END: no_orders -->
    </div>

    <!-- BEGIN: generate_page -->
    <div style="text-align: center; margin-top: 30px;">
        <nav aria-label="Page navigation">
            <ul style="list-style: none; display: inline-flex; gap: 10px;">
                <!-- BEGIN: prev -->
                <li style="{PREV.style}">
                    <a href="{PREV.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid #007bff; border-radius: 8px; color: {PREV.color}; font-size: 18px; font-weight: bold;" {PREV.attr}>Trước</a>
                </li>
                <!-- END: prev -->

                <!-- BEGIN: page -->
                <li style="{PAGE.style}">
                    <a href="{PAGE.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid {PAGE.border}; border-radius: 8px; color: {PAGE.color}; font-size: 18px; font-weight: bold;">{PAGE.num}</a>
                </li>
                <!-- END: page -->

                <!-- BEGIN: next -->
                <li style="{NEXT.style}">
                    <a href="{NEXT.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid #007bff; border-radius: 8px; color: {NEXT.color}; font-size: 18px; font-weight: bold;" {NEXT.attr}>Sau</a>
                </li>
                <!-- END: next -->
            </ul>
        </nav>
    </div>
    <!-- END: generate_page -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
