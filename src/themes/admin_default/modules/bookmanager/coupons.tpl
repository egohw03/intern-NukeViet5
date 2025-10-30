<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div class="page-header">
        <div class="container-fluid">
            <div class="header-content">
                <div class="header-title">
                    <i class="fas fa-tags"></i>
                    <div>
                        <h1>{LANG.coupons}</h1>
                        <div class="header-subtitle">Danh sách tất cả mã giảm giá</div>
                    </div>
                </div>
                <div class="header-actions">
                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=add" class="btn btn-light">
                        <i class="fas fa-plus-circle me-2"></i>{LANG.add_coupon}
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">

    

    <!-- Coupons Table -->
    <div class="data-table-container">
    <div class="data-table-header">
    <h5><i class="fas fa-tags me-2"></i>{LANG.coupons}</h5>
    </div>
    <div class="table-responsive">
    <table class="data-table">
    <thead>
            <tr>
                    <th>{LANG.code}</th>
                            <th>{LANG.discount}</th>
                            <th>{LANG.valid_period}</th>
                            <th>{LANG.usage_stats}</th>
                            <th>{LANG.status}</th>
                            <th>{LANG.actions}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: coupon_loop -->
                        <tr class="hover-lift">
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="coupon-icon bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px;">
                                        <i class="fas fa-tag fa-sm"></i>
                                    </div>
                                    <div>
                                        <strong class="text-primary fs-6">{COUPON.code}</strong>
                                        <br>
                                        <small class="text-muted">ID: {COUPON.id}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div>
                                    <strong class="text-success fs-6">{COUPON.value_format}</strong>
                                    <br>
                                    <small class="text-muted">{COUPON.type_text}</small>
                                </div>
                            </td>
                            <td>
                                <div>
                                    <small class="text-muted">
                                        <i class="fas fa-calendar-plus me-1"></i>{COUPON.start_time}
                                    </small>
                                    <br>
                                    <small class="text-muted">
                                        <i class="fas fa-calendar-times me-1"></i>{COUPON.end_time}
                                    </small>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-chart-bar text-info me-2"></i>
                                    <div>
                                        <strong>{COUPON.used_count}</strong>
                                        <small class="text-muted d-block">lần sử dụng</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="status-badge status-{COUPON.status_text}">{COUPON.status_text}</span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=edit&id={COUPON.id}" class="btn btn-outline-primary btn-sm" title="{GLANG.edit}">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=delete&id={COUPON.id}" class="btn btn-outline-danger btn-sm" title="{GLANG.delete}" onclick="return confirm('{LANG.confirm_delete}')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <!-- END: coupon_loop -->
                    </tbody>
                </table>
            </div>

            <!-- No Coupons -->
            <!-- BEGIN: no_coupons -->
            <div class="text-center py-5">
                <i class="fas fa-tags fa-5x text-muted mb-3"></i>
                <h4>{LANG.no_coupons}</h4>
                <p class="text-muted">{LANG.no_coupons_message}</p>
            </div>
            <!-- END: no_coupons -->
        </div>
    </div>

    <!-- Pagination -->
    <!-- BEGIN: pagination -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- BEGIN: page -->
            <li class="page-item {PAGE.current}">
                <a class="page-link" href="{PAGE.link}">{PAGE.num}</a>
            </li>
            <!-- END: page -->
        </ul>
    </nav>
    <!-- END: pagination -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
