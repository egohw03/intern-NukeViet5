<!-- BEGIN: main -->
<style>
.wraper { width: 100% !important; max-width: 100% !important; }
.container { width: 100% !important; max-width: 100% !important; }
.col-md-24 { width: 100% !important; padding-left: 0 !important; padding-right: 0 !important; }
.row { margin-left: 0 !important; margin-right: 0 !important; padding-left: 0 !important; padding-right: 0 !important; }
</style>
<div style="width: 100%; margin: 0 auto; padding: 40px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 50px;">
<h1 style="margin: 0; font-size: 42px; color: #2c3e50; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);">📋 Đơn hàng của tôi</h1>
<a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 15px 30px; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🛍️ Tiếp tục mua sắm</a>
</div>

<!-- Statistics Section -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); padding: 25px; border: 3px solid #17a2b8; border-radius: 15px; margin-bottom: 30px; box-shadow: 0 8px 25px rgba(23, 162, 184, 0.2);">
        <h3 style="margin-top: 0; margin-bottom: 20px; color: #17a2b8; font-size: 22px; font-weight: 700; text-align: center;">📊 Thống kê đơn hàng</h3>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; text-align: center;">
            <div style="background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%); padding: 20px; border-radius: 12px; border: 2px solid #2196f3;">
                <div style="font-size: 28px; font-weight: 700; color: #1976d2; margin-bottom: 5px;">{STATS.total_orders}</div>
                <div style="font-size: 14px; color: #424242; font-weight: 600;">{LANG.total_orders}</div>
                </div>
                <div style="background: linear-gradient(135deg, #f3e5f5 0%, #ce93d8 100%); padding: 20px; border-radius: 12px; border: 2px solid #9c27b0;">
                <div style="font-size: 28px; font-weight: 700; color: #7b1fa2; margin-bottom: 5px;">{STATS.filtered_orders}</div>
                <div style="font-size: 14px; color: #424242; font-weight: 600;">{LANG.filtered_orders}</div>
                </div>
                <div style="background: linear-gradient(135deg, #e8f5e8 0%, #a5d6a7 100%); padding: 20px; border-radius: 12px; border: 2px solid #4caf50;">
                <div style="font-size: 24px; font-weight: 700; color: #2e7d32; margin-bottom: 5px;">{STATS.total_amount_format}</div>
                <div style="font-size: 14px; color: #424242; font-weight: 600;">{LANG.total_amount}</div>
                </div>
                <div style="background: linear-gradient(135deg, #fff3e0 0%, #ffcc80 100%); padding: 20px; border-radius: 12px; border: 2px solid #ff9800;">
                <div style="font-size: 24px; font-weight: 700; color: #f57c00; margin-bottom: 5px;">{STATS.paid_amount_format}</div>
                <div style="font-size: 14px; color: #424242; font-weight: 600;">{LANG.paid_amount}</div>
                </div>
                <div style="background: linear-gradient(135deg, #ffebee 0%, #ef9a9a 100%); padding: 20px; border-radius: 12px; border: 2px solid #f44336;">
                <div style="font-size: 24px; font-weight: 700; color: #d32f2f; margin-bottom: 5px;">{STATS.pending_amount_format}</div>
                <div style="font-size: 14px; color: #424242; font-weight: 600;">{LANG.pending_amount}</div>
            </div>
        </div>
    </div>

    <!-- Search and Filter Form -->
    <div style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); padding: 30px; border: 3px solid #007bff; border-radius: 15px; margin-bottom: 40px; box-shadow: 0 10px 30px rgba(0, 123, 255, 0.15);">
        <h3 style="margin-top: 0; margin-bottom: 20px; color: #007bff; font-size: 24px; font-weight: 700; text-align: center;">🔍 Tìm kiếm & Lọc đơn hàng</h3>
        <form method="get" action="{NV_BASE_SITEURL}index.php" style="display: flex; flex-wrap: wrap; gap: 20px; align-items: end; justify-content: center;">
            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
            <input type="hidden" name="{NV_OP_VARIABLE}" value="orders" />

            <div style="flex: 1; min-width: 200px; max-width: 300px;">
                <label style="display: block; margin-bottom: 8px; font-weight: 700; color: #495057; font-size: 16px;">🔢 Mã đơn hàng</label>
                <input type="text" name="order_code" value="{SEARCH.order_code}" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px;" placeholder="Nhập mã đơn hàng..." />
            </div>

            <div style="flex: 1; min-width: 200px; max-width: 300px;">
                <label style="display: block; margin-bottom: 8px; font-weight: 700; color: #495057; font-size: 16px;">👤 Tên khách hàng</label>
                <input type="text" name="customer_name" value="{SEARCH.customer_name}" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px;" placeholder="Nhập tên khách hàng..." />
            </div>

            <div style="min-width: 180px; max-width: 200px;">
                <label style="display: block; margin-bottom: 8px; font-weight: 700; color: #495057; font-size: 16px;">📊 Trạng thái</label>
                <select name="order_status" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px; background: white;">
                    <option value="">Tất cả trạng thái</option>
                    <option value="0" {SEARCH.order_status_0}>{LANG.order_pending}</option>
                    <option value="1" {SEARCH.order_status_1}>{LANG.order_processing}</option>
                    <option value="2" {SEARCH.order_status_2}>{LANG.order_delivered}</option>
                    <option value="3" {SEARCH.order_status_3}>{LANG.order_cancelled}</option>
                </select>
            </div>

            <div style="min-width: 180px; max-width: 200px;">
                <label style="display: block; margin-bottom: 8px; font-weight: 700; color: #495057; font-size: 16px;">💳 Thanh toán</label>
                <select name="payment_status" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px; background: white;">
                    <option value="">Tất cả</option>
                    <option value="0" {SEARCH.payment_status_0}>{LANG.payment_pending}</option>
                    <option value="1" {SEARCH.payment_status_1}>{LANG.payment_paid}</option>
                </select>
            </div>

            <div style="flex: 1; min-width: 150px; max-width: 180px;">
            <label style="display: block; margin-bottom: 8px; font-weight: 700; color: #495057; font-size: 16px;">📅 {LANG.date_from}</label>
            <input type="text" name="date_from" value="{SEARCH.date_from}" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px;" placeholder="dd/mm/yyyy" />
            </div>

            <div style="flex: 1; min-width: 150px; max-width: 180px;">
            <label style="display: block; margin-bottom: 8px; font-weight: 700; color: #495057; font-size: 16px;">📅 {LANG.date_to}</label>
            <input type="text" name="date_to" value="{SEARCH.date_to}" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px;" placeholder="dd/mm/yyyy" />
            </div>

            <div style="display: flex; gap: 10px; align-items: end;">
                <button type="submit" style="padding: 12px 25px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; border: none; border-radius: 8px; cursor: pointer; font-size: 16px; font-weight: 600; box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);">🔍 Tìm kiếm</button>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="padding: 12px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: 600; box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);">🗑️ Xóa lọc</a>
            </div>
        </form>
    </div>

    <!-- Search Results Info -->
    <!-- BEGIN: search_results -->
    <div style=\"background: linear-gradient(135deg, #e8f5e8 0%, #a5d6a7 100%); color: #2e7d32; padding: 15px; border: 2px solid #4caf50; border-radius: 10px; margin-bottom: 30px; text-align: center; font-size: 16px; font-weight: 600; box-shadow: 0 4px 15px rgba(76, 175, 80, 0.2);\">
        ✅ Tìm thấy <strong>{STATS.filtered_orders}</strong> đơn hàng phù hợp với tiêu chí tìm kiếm
    </div>
    <!-- END: search_results -->

    <!-- BEGIN: order_loop -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #007bff; border-radius: 20px; margin-bottom: 30px; box-shadow: 0 15px 40px rgba(0, 123, 255, 0.2); overflow: hidden; transition: all 0.4s ease;" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 20px 50px rgba(0, 123, 255, 0.3)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 15px 40px rgba(0, 123, 255, 0.2)';">
    <div style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); padding: 25px; color: white;">
    <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 20px; flex-wrap: wrap;">
    <div style="flex: 1; min-width: 0;">
    <h4 style="margin: 0 0 8px 0; font-size: 24px; font-weight: 700; word-break: break-all; overflow-wrap: break-word;">📦 Đơn hàng #{ORDER.order_code}</h4>
    <p style="margin: 0; font-size: 16px; opacity: 0.9;">🕒 Ngày đặt: {ORDER.add_time}</p>
    </div>
    <div style="display: flex; gap: 10px; flex-shrink: 0; flex-wrap: wrap;">
    <span style="background: #{ORDER.status_class}; color: white; padding: 8px 16px; border-radius: 20px; font-size: 14px; font-weight: 600; box-shadow: 0 4px 15px rgba(0,0,0,0.2); white-space: nowrap;">{ORDER.order_status_text}</span>
    <span style="background: #{ORDER.payment_class}; color: white; padding: 8px 16px; border-radius: 20px; font-size: 14px; font-weight: 600; box-shadow: 0 4px 15px rgba(0,0,0,0.2); white-space: nowrap;">{ORDER.payment_status_text}</span>
    </div>
    </div>
    </div>
    <div style="padding: 30px;">
    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 40px;">
    <div style="background: rgba(255,255,255,0.8); padding: 20px; border-radius: 15px; border: 2px solid #e9ecef;">
    <h5 style="margin: 0 0 15px 0; color: #2c3e50; font-size: 20px; font-weight: 700; border-bottom: 2px solid #007bff; padding-bottom: 8px;">👤 Thông tin người nhận</h5>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #17a2b8; width: 80px; flex-shrink: 0; margin-right: 10px;">👨‍💼 Tên:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_name}</span></p>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #28a745; width: 80px; flex-shrink: 0; margin-right: 10px;">📧 Email:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_email}</span></p>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #ffc107; width: 80px; flex-shrink: 0; margin-right: 10px;">📱 SĐT:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_phone}</span></p>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #dc3545; width: 80px; flex-shrink: 0; margin-right: 10px;">🏠 Địa chỉ:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_address}</span></p>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #6c757d; width: 80px; flex-shrink: 0; margin-right: 10px;">💳 PT TT:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.payment_method}</span></p>
    </div>
    <div style="text-align: center; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); padding: 25px; border-radius: 15px; border: 3px solid #007bff;">
    <div style="margin-bottom: 15px;">
        <div style="font-size: 14px; color: #6c757d; margin-bottom: 5px;">Tổng tiền</div>
        <div style="font-size: 32px; font-weight: 700; color: #dc3545; text-shadow: 2px 2px 4px rgba(220, 53, 69, 0.2);">{ORDER.total_amount_format}</div>
    </div>
    <!-- BEGIN: view_detail -->
    <div>
            <a href="{ORDER.view_detail_link}" style="display: inline-block; padding: 15px 25px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">👀 Xem chi tiết</a>
            </div>
                <!-- END: view_detail -->
                </div>
            </div>
        </div>
    </div>
    <!-- END: order_loop -->

    <!-- BEGIN: no_orders -->
    <div style="text-align: center; padding: 80px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border: 4px solid #6c757d; border-radius: 20px; box-shadow: 0 15px 40px rgba(108, 117, 125, 0.2);">
    <div style="font-size: 96px; margin-bottom: 30px; text-shadow: 4px 4px 8px rgba(0,0,0,0.1);">📋❌</div>
    <h2 style="margin: 0 0 20px 0; color: #2c3e50; font-size: 32px; font-weight: 700;">{LANG.no_orders_title}</h2>
    <p style="margin: 0 0 30px 0; color: #6c757d; font-size: 20px; line-height: 1.6;">{LANG.no_orders_description}</p>
    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 20px 40px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 12px; font-size: 20px; font-weight: 600; box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🛍️ {LANG.shop_now}</a>
    </div>
    <!-- END: no_orders -->
</div>
<!-- END: main -->
