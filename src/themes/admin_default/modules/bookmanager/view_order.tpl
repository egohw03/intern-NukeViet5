<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
        <div>
            <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.view_order}: {ORDER.order_code}</h1>
            <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Chi tiết đơn hàng</p>
        </div>
    </div>

    <div style="display: flex; gap: 20px;">
        <!-- Order Info -->
        <div style="flex: 2;">
            <div style="background: #fff; border: 3px solid #007bff; padding: 25px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15); margin-bottom: 25px;">
            <h2 style="font-size: 24px; margin-bottom: 20px; color: #333;">{LANG.order_info}</h2>
                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                    <p style="font-size: 18px;"><strong>{LANG.order_code}:</strong> {ORDER.order_code}</p>
                    <p style="font-size: 18px;"><strong>{LANG.add_time}:</strong> {ORDER.add_time_format}</p>
                    <p style="font-size: 18px;"><strong>{LANG.order_status}:</strong> <span style="background: {ORDER.order_status_bg}; color: #fff; padding: 8px 12px; border-radius: 6px; font-size: 16px;">{ORDER.order_status_text}</span></p>
                    </div>
                    <div style="flex: 1;">
                    <p style="font-size: 18px;"><strong>{LANG.payment_method}:</strong> {ORDER.payment_method}</p>
                    <p style="font-size: 18px;"><strong>{LANG.payment_status}:</strong> <span style="background: {ORDER.payment_status_bg}; color: #fff; padding: 8px 12px; border-radius: 6px; font-size: 16px;">{ORDER.payment_status_text}</span></p>
                        <!-- BEGIN: transaction_id -->
                        <p style=\"font-size: 18px;\"><strong>Mã giao dịch:</strong> {ORDER.transaction_id}</p>
                        <!-- END: transaction_id -->
                    </div>
                </div>
            </div>

            <!-- Order Items -->
            <div style="background: #fff; border: 3px solid #28a745; padding: 25px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
            <h2 style="font-size: 24px; margin-bottom: 20px; color: #333;">{LANG.order_details}</h2>
            <table style="width: 100%; border-collapse: collapse; font-size: 18px;">
                    <thead>
                        <tr style="background: #007bff; color: #fff;">
                            <th style="padding: 15px; font-size: 18px; text-align: left;">{LANG.title}</th>
                            <th style="padding: 15px; font-size: 18px; text-align: center;">{LANG.quantity}</th>
                            <th style="padding: 15px; font-size: 18px; text-align: center;">{LANG.unit_price}</th>
                            <th style="padding: 15px; font-size: 18px; text-align: center;">{LANG.subtotal}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: order_items -->
                        <tr style="background: #f9f9f9; border-bottom: 1px solid #ddd;">
                        <td style="padding: 15px; font-size: 18px;"><strong>{ITEM.book_title}</strong></td>
                        <td style="padding: 15px; font-size: 18px; text-align: center;">{ITEM.quantity}</td>
                        <td style="padding: 15px; font-size: 18px; text-align: center;">{ITEM.price_format}</td>
                        <td style="padding: 15px; font-size: 18px; text-align: center;"><strong>{ITEM.total_format}</strong></td>
                        </tr>
                        <!-- END: order_items -->
                    </tbody>
                    <tfoot>
                        <tr style="background: #f8f9fa;">
                        <td colspan="3" style="padding: 15px; text-align: right; font-size: 18px;"><strong>{LANG.subtotal}:</strong></td>
                        <td style="padding: 15px; text-align: center; font-size: 18px;"><strong>{ORDER.subtotal_format}</strong></td>
                        </tr>
                        <!-- BEGIN: discount_row -->
                        <tr style="background: #f8f9fa;">
                        <td colspan="3" style="padding: 15px; text-align: right; font-size: 18px;"><strong>{LANG.discount} ({ORDER.coupon_code}):</strong></td>
                        <td style="padding: 15px; text-align: center; font-size: 18px; color: #dc3545;"><strong>-{ORDER.discount_amount_format}</strong></td>
                        </tr>
                        <!-- END: discount_row -->
                        <tr style="background: #007bff; color: #fff;">
                        <td colspan="3" style="padding: 15px; text-align: right; font-size: 20px;"><strong>{LANG.total_amount}:</strong></td>
                        <td style="padding: 15px; text-align: center; font-size: 20px;"><strong>{ORDER.total_amount_format}</strong></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- Customer Info -->
        <div style="flex: 1;">
        <div style="background: #fff; border: 3px solid #ffc107; padding: 25px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15); margin-bottom: 25px;">
        <h2 style="font-size: 24px; margin-bottom: 20px; color: #333;">{LANG.customer_info}</h2>
        <p style="font-size: 18px;"><strong>{LANG.customer_name}:</strong> {ORDER.customer_name}</p>
        <p style="font-size: 18px;"><strong>{LANG.customer_email}:</strong> {ORDER.customer_email}</p>
        <p style="font-size: 18px;"><strong>{LANG.customer_phone}:</strong> {ORDER.customer_phone}</p>
        <p style="font-size: 18px;"><strong>{LANG.customer_address}:</strong><br>{ORDER.customer_address}</p>
        <!-- BEGIN: order_note -->
        <p style="font-size: 18px;"><strong>{LANG.order_note}:</strong><br>{ORDER.order_note}</p>
        <!-- END: order_note -->
            </div>

            <!-- Update Status -->
            <div style="background: #fff; border: 3px solid #dc3545; padding: 25px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
            <h2 style="font-size: 24px; margin-bottom: 20px; color: #333;">{LANG.update_order_status}</h2>
                <form method="post" action="">
                    <div style="margin-bottom: 20px;">
                    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.order_status}</label>
                    <select name="order_status" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px;">
                    <option value="0" {ORDER.selected_0}>{LANG.order_pending}</option>
                    <option value="1" {ORDER.selected_1}>{LANG.order_processing}</option>
                    <option value="2" {ORDER.selected_2}>{LANG.order_delivered}</option>
                    <option value="3" {ORDER.selected_3}>{LANG.order_cancelled}</option>
                    </select>
                    </div>
                    <div style="margin-bottom: 20px;">
                    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.payment_status}</label>
                    <select name="payment_status" style="width: 100%; padding: 12px; border: 2px solid #ffc107; border-radius: 8px; font-size: 16px;">
                    <option value="0" {PAYMENT.selected_0}>{LANG.payment_pending}</option>
                    <option value="1" {PAYMENT.selected_1}>{LANG.payment_paid}</option>
                    </select>
                    </div>
                    <button type="submit" name="update_status" style="width: 100%; padding: 15px; background: #28a745; color: #fff; border: 2px solid #28a745; border-radius: 8px; font-size: 18px; font-weight: bold;">{LANG.update}</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
