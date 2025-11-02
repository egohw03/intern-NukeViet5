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
                    <p style="font-size: 18px;"><strong>{LANG.order_status}:</strong> <span style="background: {ORDER.order_status_bg}; color: #000; padding: 8px 12px; border-radius: 6px; font-size: 16px;">{ORDER.order_status_text}</span></p>
                    </div>
                    <div style="flex: 1;">
                    <p style="font-size: 18px;"><strong>{LANG.payment_method}:</strong> {ORDER.payment_method}</p>
                    <p style="font-size: 18px;"><strong>{LANG.payment_status}:</strong> <span style="background: {ORDER.payment_status_bg}; color: #000; padding: 8px 12px; border-radius: 6px; font-size: 16px;">{ORDER.payment_status_text}</span></p>
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

        </div>
    </div>
</div>
<!-- END: main -->
