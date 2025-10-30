<!-- BEGIN: main -->
<div class="dashboard">
    <h1 class="mb-4">{LANG.dashboard}</h1>

    <!-- Revenue Stats -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">{LANG.revenue_today}</h5>
                    <h3 class="mb-0">{REVENUE_TODAY}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">{LANG.revenue_week}</h5>
                    <h3 class="mb-0">{REVENUE_WEEK}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">{LANG.revenue_month}</h5>
                    <h3 class="mb-0">{REVENUE_MONTH}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Stats -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <h5>{LANG.orders_pending}</h5>
                    <h2 class="text-warning">{ORDERS_PENDING}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <h5>{LANG.orders_completed}</h5>
                    <h2 class="text-success">{ORDERS_COMPLETED}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body text-center">
                    <h5>{LANG.orders_cancelled}</h5>
                    <h2 class="text-danger">{ORDERS_CANCELLED}</h2>
                </div>
            </div>
        </div>
    </div>

    <!-- Top Selling Books -->
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.top_selling_books}</h5>
                </div>
                <div class="card-body">
                    <!-- BEGIN: top_book -->
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span>{TOP_BOOK.title}</span>
                        <span class="badge bg-primary">{TOP_BOOK.total_sold} {LANG.total_sold}</span>
                    </div>
                    <!-- END: top_book -->
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.low_stock_alerts}</h5>
                </div>
                <div class="card-body">
                    <!-- BEGIN: low_stock -->
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span>{LOW_STOCK.title}</span>
                        <span class="badge bg-warning">{LOW_STOCK.stock_quantity} còn lại</span>
                    </div>
                    <!-- END: low_stock -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
