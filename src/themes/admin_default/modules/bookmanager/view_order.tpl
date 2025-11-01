<!-- BEGIN: main -->
<div style="width: 100%; font-size: 16px; line-height: 1.6;">
    <h1 style="font-size: 24px; margin-bottom: 20px; color: #333;">{LANG.view_order}: {ORDER.order_code}</h1>

    <div style="display: flex; gap: 20px;">
        <!-- Order Info -->
        <div style="flex: 2;">
            <div style="background: #fff; border: 1px solid #ddd; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 20px;">
                <h2 style="font-size: 20px; margin-bottom: 15px; color: #333;">{LANG.order_info}</h2>
                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                        <p><strong>{LANG.order_code}:</strong> {ORDER.order_code}</p>
                        <p><strong>{LANG.add_time}:</strong> {ORDER.add_time_format}</p>
                        <p><strong>{LANG.order_status}:</strong> <span style="background: {ORDER.order_status_bg}; color: #fff; padding: 5px 10px; border-radius: 4px;">{ORDER.order_status_text}</span></p>
                    </div>
                    <div style="flex: 1;">
                        <p><strong>{LANG.payment_method}:</strong> {ORDER.payment_method}</p>
                        <p><strong>{LANG.payment_status}:</strong> <span style="background: {ORDER.payment_status_bg}; color: #fff; padding: 5px 10px; border-radius: 4px;">{ORDER.payment_status_text}</span></p>
                        <!-- BEGIN: transaction_id -->
                        <p><strong>Mã giao dịch:</strong> {ORDER.transaction_id}</p>
                        <!-- END: transaction_id -->
                    </div>
                </div>
            </div>

            <!-- Order Items -->
            <div style="background: #fff; border: 1px solid #ddd; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h2 style="font-size: 20px; margin-bottom: 15px; color: #333;">{LANG.order_details}</h2>
                <table style="width: 100%; border-collapse: collapse; font-size: 16px;">
                    <thead>
                        <tr style="background: #007bff; color: #fff;">
                            <th style="padding: 10px; border: 1px solid #ddd;">{LANG.title}</th>
                            <th style="padding: 10px; border: 1px solid #ddd; text-align: center;">{LANG.quantity}</th>
                            <th style="padding: 10px; border: 1px solid #ddd; text-align: right;">{LANG.unit_price}</th>
                            <th style="padding: 10px; border: 1px solid #ddd; text-align: right;">{LANG.subtotal}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: order_items -->
                        <tr>
                            <td style="padding: 10px; border: 1px solid #ddd;"><strong>{ITEM.book_title}</strong></td>
                            <td style="padding: 10px; border: 1px solid #ddd; text-align: center;">{ITEM.quantity}</td>
                            <td style="padding: 10px; border: 1px solid #ddd; text-align: right;">{ITEM.price_format}</td>
                            <td style="padding: 10px; border: 1px solid #ddd; text-align: right;"><strong>{ITEM.total_format}</strong></td>
                        </tr>
                        <!-- END: order_items -->
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" style="padding: 10px; border: 1px solid #ddd; text-align: right;"><strong>{LANG.subtotal}:</strong></td>
                            <td style="padding: 10px; border: 1px solid #ddd; text-align: right;"><strong>{ORDER.subtotal_format}</strong></td>
                        </tr>
                        <!-- BEGIN: discount_row -->
                        <tr>
                            <td colspan="3" style="padding: 10px; border: 1px solid #ddd; text-align: right;"><strong>{LANG.discount} ({ORDER.coupon_code}):</strong></td>
                            <td style="padding: 10px; border: 1px solid #ddd; text-align: right; color: #dc3545;"><strong>-{ORDER.discount_amount_format}</strong></td>
                        </tr>
                        <!-- END: discount_row -->
                        <tr style="background: #e9ecef;">
                            <td colspan="3" style="padding: 10px; border: 1px solid #ddd; text-align: right;"><strong>{LANG.total_amount}:</strong></td>
                            <td style="padding: 10px; border: 1px solid #ddd; text-align: right;"><strong style="color: #007bff; font-size: 18px;">{ORDER.total_amount_format}</strong></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- Customer Info -->
        <div style="flex: 1;">
            <div style="background: #fff; border: 1px solid #ddd; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 20px;">
                <h2 style="font-size: 20px; margin-bottom: 15px; color: #333;">{LANG.customer_info}</h2>
                <p><strong>{LANG.customer_name}:</strong> {ORDER.customer_name}</p>
                <p><strong>{LANG.customer_email}:</strong> {ORDER.customer_email}</p>
                <p><strong>{LANG.customer_phone}:</strong> {ORDER.customer_phone}</p>
                <p><strong>{LANG.customer_address}:</strong><br>{ORDER.customer_address}</p>
                <!-- BEGIN: order_note -->
                <p><strong>{LANG.order_note}:</strong><br>{ORDER.order_note}</p>
                <!-- END: order_note -->
            </div>

            <!-- Update Status -->
            <div style="background: #fff; border: 1px solid #ddd; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                <h2 style="font-size: 20px; margin-bottom: 15px; color: #333;">{LANG.update_order_status}</h2>
                <form method="post" action="">
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; font-size: 16px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.order_status}</label>
                        <select name="order_status" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
                            <option value="0" {ORDER.selected_0}>{LANG.order_pending}</option>
                            <option value="1" {ORDER.selected_1}>{LANG.order_processing}</option>
                            <option value="2" {ORDER.selected_2}>{LANG.order_delivered}</option>
                            <option value="3" {ORDER.selected_3}>{LANG.order_cancelled}</option>
                        </select>
                    </div>
                    <div style="margin-bottom: 15px;">
                        <label style="display: block; font-size: 16px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.payment_status}</label>
                        <select name="payment_status" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
                            <option value="0" {PAYMENT.selected_0}>{LANG.payment_pending}</option>
                            <option value="1" {PAYMENT.selected_1}>{LANG.payment_paid}</option>
                        </select>
                    </div>
                    <button type="submit" name="update_status" style="width: 100%; padding: 10px; background: #28a745; color: #fff; border: none; border-radius: 4px; font-size: 16px; font-weight: bold;">{LANG.update}</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
