<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div class="page-header">
        <div class="container-fluid">
            <div class="header-content">
                <div class="header-title">
                    <i class="fas fa-star"></i>
                    <div>
                        <h1>{LANG.reviews} ({TOTAL_COUNT})</h1>
                        <div class="header-subtitle">Danh sách tất cả đánh giá</div>
                    </div>
                </div>
                <div class="header-actions">
                    <!-- BEGIN: bulk_actions -->
                    <button class="btn btn-light" onclick="toggleBulkActions()">
                        <i class="fas fa-tasks me-2"></i>Thao tác hàng loạt
                    </button>
                    <!-- END: bulk_actions -->
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">

    

        <!-- Filter Tabs -->
        <div class="data-table-container mb-4">
            <div class="data-table-header">
                <h5><i class="fas fa-filter me-2"></i>Lọc đánh giá</h5>
            </div>
            <div class="p-3">
                <ul class="nav nav-pills">
                    <li class="nav-item">
                        <a class="nav-link {PENDING_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=reviews&status=0">
                            <i class="fas fa-clock me-1"></i>{LANG.pending}
                            <span class="badge bg-warning ms-1">{PENDING_COUNT}</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {APPROVED_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=reviews&status=1">
                            <i class="fas fa-check-circle me-1"></i>{LANG.approved}
                            <span class="badge bg-success ms-1">{APPROVED_COUNT}</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {ALL_ACTIVE}" href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=reviews">
                            <i class="fas fa-list me-1"></i>{LANG.all}
                            <span class="badge bg-secondary ms-1">{TOTAL_COUNT}</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

    <!-- Reviews Table -->
        <div class="data-table-container">
            <div class="data-table-header">
            <h5><i class="fas fa-star me-2"></i>{LANG.reviews}</h5>
    </div>
    <div class="table-responsive">
    <table class="data-table">
            <thead>
                <tr>
                        <th>Người đánh giá</th>
                        <th>Sản phẩm</th>
                    <th>Đánh giá</th>
                <th>Nội dung</th>
            <th>Thời gian</th>
        <th>Trạng thái</th>
            <th>Thao tác</th>
            </tr>
        </thead>
    <tbody>
        <!-- BEGIN: review_loop -->
        <tr class="hover-lift">
            <td>
                    <div class="d-flex align-items-center">
                        <div class="customer-avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px;">
                        <i class="fas fa-user fa-sm"></i>
                    </div>
                <div>
                        <strong class="text-dark">{REVIEW.username}</strong>
                    </div>
            </div>
            </td>
            <td>
                    <div>
                            <strong class="text-primary">{REVIEW.book_title}</strong>
                            </div>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="me-2">
                                        <!-- BEGIN: star_{REVIEW.rating} -->
                                        <i class="fas fa-star text-warning"></i>
                                        <!-- END: star_{REVIEW.rating} -->
                                    </span>
                                    <strong>{REVIEW.rating}/5</strong>
                                </div>
                            </td>
                            <td>
                                <div>
                                    <!-- BEGIN: review_title -->
                                    <strong class="text-dark">{REVIEW.title}</strong>
                                    <br>
                                    <!-- END: review_title -->
                                    <div class="text-truncate-2 text-muted small">
                                        {REVIEW.content}
                                    </div>
                                </div>
                            </td>
                            <td>
                                <small class="text-muted">{REVIEW.add_time}</small>
                            </td>
                            <td>
                                <span class="status-badge status-{REVIEW.status_text}">{REVIEW.status_text}</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <!-- BEGIN: pending_actions -->
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=reviews&action=approve&id={REVIEW.id}" class="btn btn-outline-success btn-sm" title="{LANG.approve}">
                                        <i class="fas fa-check"></i>
                                    </a>
                                    <!-- END: pending_actions -->
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=reviews&action=delete&id={REVIEW.id}" class="btn btn-outline-danger btn-sm" title="{LANG.delete}" onclick="return confirm('{LANG.confirm_delete}')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <!-- END: review_loop -->
                    </tbody>
                </table>
            </div>

    <!-- No Reviews -->
    <!-- BEGIN: no_reviews -->
    <div class="text-center py-5">
        <i class="fas fa-comments fa-5x text-muted mb-3"></i>
        <h4>{LANG.no_reviews}</h4>
    </div>
    <!-- END: no_reviews -->

    <!-- Pagination -->
    <!-- BEGIN: pagination -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <!-- BEGIN: page -->
            <li class="page-item {PAGE.current}">
                <a class="page-link" href="{PAGE.link}">{PAGE.num}</a>
            </li>
            <!-- END: page -->
        </ul>
    </nav>
    <!-- END: pagination -->
</div>

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
