<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
    <h1 style="font-size: 32px; margin-bottom: 35px; color: #333; text-align: center; font-weight: bold;">{LANG.dashboard}</h1>

    <!-- Basic Stats -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 25px; margin-bottom: 45px;">
        <div style="background: #fff; border: 3px solid #007bff; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2); text-align: center;">
            <h3 style="font-size: 22px; color: #007bff; margin-bottom: 15px;">{LANG.total_books}</h3>
            <p style="font-size: 36px; font-weight: bold; color: #28a745;">{TOTAL_BOOKS}</p>
            <p style="font-size: 18px; color: #666;">Sách trong kho</p>
        </div>

        <div style="background: #fff; border: 3px solid #28a745; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2); text-align: center;">
            <h3 style="font-size: 22px; color: #28a745; margin-bottom: 15px;">{LANG.total_categories}</h3>
            <p style="font-size: 36px; font-weight: bold; color: #007bff;">{TOTAL_CATEGORIES}</p>
            <p style="font-size: 18px; color: #666;">Danh mục sách</p>
        </div>

        <div style="background: #fff; border: 3px solid #ffc107; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2); text-align: center;">
            <h3 style="font-size: 22px; color: #ffc107; margin-bottom: 15px;">{LANG.total_orders}</h3>
            <p style="font-size: 36px; font-weight: bold; color: #dc3545;">{TOTAL_ORDERS}</p>
            <p style="font-size: 18px; color: #666;">Tổng đơn hàng</p>
        </div>

        <div style="background: #fff; border: 3px solid #dc3545; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2); text-align: center;">
            <h3 style="font-size: 22px; color: #dc3545; margin-bottom: 15px;">{LANG.total_reviews}</h3>
            <p style="font-size: 36px; font-weight: bold; color: #6c757d;">{TOTAL_REVIEWS}</p>
            <p style="font-size: 18px; color: #666;">Đánh giá sách</p>
        </div>
    </div>

    <!-- Revenue and Order Stats -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 25px; margin-bottom: 45px;">
        <div style="background: #fff; border: 3px solid #17a2b8; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2); text-align: center;">
            <h3 style="font-size: 22px; color: #17a2b8; margin-bottom: 15px;">Doanh thu hôm nay</h3>
            <p style="font-size: 36px; font-weight: bold; color: #e83e8c;">{REVENUE_TODAY}</p>
            <p style="font-size: 18px; color: #666;">Từ đơn hàng hoàn thành</p>
        </div>

        <div style="background: #fff; border: 3px solid #6c757d; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2); text-align: center;">
            <h3 style="font-size: 22px; color: #6c757d; margin-bottom: 15px;">Đơn hàng chờ xử lý</h3>
            <p style="font-size: 36px; font-weight: bold; color: #ffc107;">{ORDERS_PENDING}</p>
            <p style="font-size: 18px; color: #666;">Cần xác nhận</p>
        </div>

        <div style="background: #fff; border: 3px solid #28a745; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2); text-align: center;">
            <h3 style="font-size: 22px; color: #28a745; margin-bottom: 15px;">Đơn hàng hoàn thành</h3>
            <p style="font-size: 36px; font-weight: bold; color: #007bff;">{ORDERS_COMPLETED}</p>
            <p style="font-size: 18px; color: #666;">Đã giao thành công</p>
        </div>
    </div>

    <!-- Analytics Section -->
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px;">
        <div style="background: #fff; border: 3px solid #333; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2);">
            <h3 style="font-size: 24px; margin-bottom: 20px; color: #333;">{LANG.top_selling_books}</h3>
            <!-- BEGIN: top_book -->
            <div style="border-bottom: 1px solid #ddd; padding: 15px 0; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h4 style="font-size: 20px; margin: 0; color: #007bff;">{TOP_BOOK.title}</h4>
                    <p style="font-size: 18px; color: #666; margin: 5px 0;">Đã bán: {TOP_BOOK.total_sold} cuốn</p>
                </div>
            </div>
            <!-- END: top_book -->
            <!-- BEGIN: no_top_books -->
            <p style="font-size: 18px; color: #666; text-align: center; padding: 20px;">Chưa có dữ liệu bán hàng</p>
            <!-- END: no_top_books -->
        </div>

        <div style="background: #fff; border: 3px solid #dc3545; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.2);">
            <h3 style="font-size: 24px; margin-bottom: 20px; color: #dc3545;">{LANG.low_stock_alerts}</h3>
            <!-- BEGIN: low_stock -->
            <div style="border-bottom: 1px solid #ddd; padding: 15px 0; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h4 style="font-size: 20px; margin: 0; color: #dc3545;">{LOW_STOCK.title}</h4>
                    <p style="font-size: 18px; color: #666; margin: 5px 0;">Còn: {LOW_STOCK.stock_quantity} cuốn</p>
                </div>
            </div>
            <!-- END: low_stock -->
            <!-- BEGIN: no_low_stock -->
            <p style="font-size: 18px; color: #666; text-align: center; padding: 20px;">Không có sách nào sắp hết hàng</p>
            <!-- END: no_low_stock -->
        </div>
    </div>
</div>
<!-- END: main -->
