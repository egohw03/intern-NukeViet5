<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div class="page-header">
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center">
    <h1 class="h3 mb-0">{LANG.dashboard}</h1>
        <small class="text-muted">Tổng quan hệ thống quản lý sách</small>
            </div>
        </div>
    </div>

    <div class="container-fluid">

    <!-- Basic Stats -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <div class="stat-content">
                        <h6 class="stat-title">{LANG.total_books}</h6>
                        <h3 class="stat-value text-primary">{TOTAL_BOOKS}</h3>
                        <div class="stat-desc">Sách trong kho</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <div class="stat-content">
                        <h6 class="stat-title">{LANG.total_categories}</h6>
                        <h3 class="stat-value text-info">{TOTAL_CATEGORIES}</h3>
                        <div class="stat-desc">Danh mục sách</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <div class="stat-content">
                        <h6 class="stat-title">{LANG.total_orders}</h6>
                        <h3 class="stat-value text-warning">{TOTAL_ORDERS}</h3>
                        <div class="stat-desc">Tổng đơn hàng</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <div class="stat-content">
                        <h6 class="stat-title">{LANG.total_reviews}</h6>
                        <h3 class="stat-value text-success">{TOTAL_REVIEWS}</h3>
                        <div class="stat-desc">Đánh giá sách</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Revenue Stats -->
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="stat-content">
                    <h6 class="stat-title">Doanh thu hôm nay</h6>
                    <h3 class="stat-value text-primary">{REVENUE_TODAY}</h3>
                <div class="stat-desc">Từ đơn hàng hoàn thành</div>
    </div>
</div>
</div>
<div class="col-md-4 mb-3">
            <div class="stat-card">
                    <div class="stat-content">
                        <h6 class="stat-title">Doanh thu tuần này</h6>
                        <h3 class="stat-value text-success">{REVENUE_WEEK}</h3>
                    <div class="stat-desc">7 ngày gần nhất</div>
        </div>
</div>
</div>
<div class="col-md-4 mb-3">
    <div class="stat-card">
        <div class="stat-content">
                <h6 class="stat-title">Doanh thu tháng này</h6>
                    <h3 class="stat-value text-info">{REVENUE_MONTH}</h3>
                <div class="stat-desc">Tháng hiện tại</div>
            </div>
    </div>
    </div>
    </div>

        <!-- Order Stats -->
        <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="stat-card">
            <div class="stat-content">
        <h6 class="stat-title">Đơn hàng chờ xử lý</h6>
        <h3 class="stat-value text-warning">{ORDERS_PENDING}</h3>
            <div class="stat-desc">Cần xác nhận</div>
        </div>
            </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <div class="stat-content">
                        <h6 class="stat-title">Đơn hàng hoàn thành</h6>
                <h3 class="stat-value text-success">{ORDERS_COMPLETED}</h3>
                <div class="stat-desc">Đã giao thành công</div>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-3">
                <div class="stat-card">
                <div class="stat-content">
                <h6 class="stat-title">Đơn hàng đã hủy</h6>
                    <h3 class="stat-value text-danger">{ORDERS_CANCELLED}</h3>
                    <div class="stat-desc">Đơn bị hủy bỏ</div>
                    </div>
                </div>
            </div>
        </div>

<!-- Analytics Section -->
<div class="row">
<div class="col-md-6 mb-4">
    <div class="card h-100">
        <div class="card-header">
                <h6 class="mb-0">{LANG.top_selling_books}</h6>
                </div>
                <div class="card-body">
                        <!-- BEGIN: top_book -->
                        <div class="analytics-item d-flex justify-content-between align-items-center py-3 border-bottom">
                            <div class="item-info flex-grow-1">
                                <h6 class="mb-1">{TOP_BOOK.title}</h6>
                                <small class="text-muted">Đã bán: {TOP_BOOK.total_sold} cuốn</small>
                        </div>
                        </div>
                    <!-- END: top_book -->
            <!-- BEGIN: no_top_books -->
        <div class="text-center py-4">
        <p class="text-muted">Chưa có dữ liệu bán hàng</p>
    </div>
        <!-- END: no_top_books -->
        </div>
        </div>
            </div>

    <div class="col-md-6 mb-4">
    <div class="card h-100">
    <div class="card-header">
    <h6 class="mb-0">{LANG.low_stock_alerts}</h6>
</div>
<div class="card-body">
<!-- BEGIN: low_stock -->
<div class="analytics-item d-flex justify-content-between align-items-center py-3 border-bottom">
        <div class="item-info flex-grow-1">
            <h6 class="mb-1">{LOW_STOCK.title}</h6>
        <small class="text-muted">Còn: {LOW_STOCK.stock_quantity} cuốn</small>
    </div>
</div>
<!-- END: low_stock -->
<!-- BEGIN: no_low_stock -->
<div class="text-center py-4">
<p class="text-muted">Không có sách nào sắp hết hàng</p>
</div>
<!-- END: no_low_stock -->
</div>
</div>
</div>
</div>
</div>
</div>
<!-- END: main -->
