<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
<div class="page-header">
        <div class="container-fluid">
            <div class="header-content">
            <div class="header-title">
            <i class="fas fa-folder-open"></i>
            <div>
            <h1>{LANG.categories} ({CATEGORIES_COUNT})</h1>
            <div class="header-subtitle">Danh sách tất cả thể loại sách</div>
            </div>
            </div>
            <div class="header-actions">
                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add_cat" class="btn btn-light">
                        <i class="fas fa-plus-circle me-2"></i>{LANG.add_cat}
                </a>
                </div>
            </div>
        </div>
    </div>

<div class="container-fluid">

    <!-- BEGIN: error -->
    <div class="alert alert-danger">
        {ERROR}
    </div>
    <!-- END: error -->

    <div class="card">
        <div class="card-body">
            <!-- BEGIN: category_loop -->
            <div class="category-item border rounded p-3 mb-3 {CAT.bg_class} hover-shadow">
            <div class="row align-items-center">
            <div class="col-md-1 text-center">
            <div class="category-icon bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
            <i class="fas fa-folder"></i>
            </div>
            </div>
            <div class="col-md-5">
            <div class="d-flex align-items-center">
            <!-- BEGIN: indent -->
            <span class="ms-3"></span>
            <!-- END: indent -->
            <div>
            <h5 class="mb-1 fw-bold">
                <span class="badge bg-secondary me-2">#{CAT.id}</span>
                {CAT.title}
                <small class="text-muted fw-normal">(Thứ tự: {CAT.weight})</small>
            </h5>
            <p class="mb-1 text-muted small">{CAT.description}</p>
            <div class="d-flex align-items-center">
            <i class="fas fa-book text-info me-1"></i>
                <strong class="text-primary">{CAT.book_count}</strong>
                    <span class="text-muted ms-1">cuốn sách</span>
                    </div>
                    </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                    <div class="mb-2">
                        <span class="badge bg-{CAT.status_class} fs-6">{CAT.status_text}</span>
                    </div>
                    <!-- BEGIN: has_books_warning -->
                        <div class="alert alert-warning py-1 px-2 mb-0 small">
                            <i class="fas fa-exclamation-triangle"></i> Có sách - không thể xóa
                        </div>
                        <!-- END: has_books_warning -->
                        <!-- BEGIN: parent_info -->
                        <small class="text-muted">Thuộc: {CAT.parent_title}</small>
                        <!-- END: parent_info -->
                    </div>
                    <div class="col-md-3 text-end">
                    <div class="btn-group" role="group">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=edit_cat&id={CAT.id}" class="btn btn-sm btn-outline-primary me-1" title="{LANG.edit_cat}">
                                <i class="fas fa-edit"></i> {LANG.edit}
                            </a>
                            <!-- BEGIN: delete_allowed -->
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=del_cat&id={CAT.id}" class="btn btn-sm btn-outline-danger" title="{LANG.del_cat}" onclick="return confirm('{LANG.confirm_delete}')">
                                <i class="fas fa-trash"></i> {LANG.delete}
                            </a>
                            <!-- END: delete_allowed -->
                            <!-- BEGIN: delete_disabled -->
                            <button class="btn btn-sm btn-outline-secondary" title="Không thể xóa (còn sách)" disabled>
                                <i class="fas fa-lock"></i> {LANG.delete}
                            </button>
                            <!-- END: delete_disabled -->
                        </div>
                </div>
            </div>
            <!-- END: category_loop -->

            <!-- BEGIN: no_categories -->
            <div class="text-center py-5">
                <i class="fas fa-folder-open fa-5x text-muted mb-3"></i>
                <h4>{LANG.no_categories}</h4>
                <p class="text-muted">{LANG.no_categories_message}</p>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add_cat" class="btn btn-primary">
                    {LANG.add_first_category}
                </a>
            </div>
            <!-- END: no_categories -->
        </div>
    </div>

    

        <!-- Categories List -->
        <div class="data-table-container">
            <div class="data-table-header">
                <h5><i class="fas fa-folder me-2"></i>{LANG.categories}</h5>
            </div>
            <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                <th>{LANG.title}</th>
                <th>{LANG.description}</th>
                    <th>{LANG.books}</th>
                        <th>{LANG.weight}</th>
                            <th>{LANG.status}</th>
                            <th>{LANG.actions}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: category_loop -->
                        <tr class="hover-lift">
                            <td>
                                <strong class="text-primary">#{CAT.id}</strong>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="category-icon bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 35px; height: 35px;">
                                        <i class="fas fa-folder fa-sm"></i>
                                    </div>
                                    <div>
                                        <strong class="text-dark">{CAT.title}</strong>
                                        <!-- BEGIN: has_subcats -->
                                        <br><small class="text-muted">({CAT.subcat_count} thể loại con)</small>
                                        <!-- END: has_subcats -->
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="text-truncate-2 text-muted small">
                                    {CAT.description}
                                </div>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-book text-info me-2"></i>
                                    <strong class="text-primary">{CAT.book_count}</strong>
                                    <span class="text-muted ms-1 small">cuốn</span>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark">{CAT.weight}</span>
                            </td>
                            <td>
                                <span class="status-badge status-{CAT.status_text}">{CAT.status_text}</span>
                                <!-- BEGIN: has_books_warning -->
                                <div class="mt-1">
                                    <small class="text-warning">
                                        <i class="fas fa-exclamation-triangle"></i> Có sách
                                    </small>
                                </div>
                                <!-- END: has_books_warning -->
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=edit_cat&id={CAT.id}" class="btn btn-outline-primary btn-sm" title="{LANG.edit_cat}">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <!-- BEGIN: delete_allowed -->
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=del_cat&id={CAT.id}" class="btn btn-outline-danger btn-sm" title="{LANG.del_cat}" onclick="return confirm('{LANG.confirm_delete}')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                    <!-- END: delete_allowed -->
                                    <!-- BEGIN: delete_disabled -->
                                    <button class="btn btn-outline-secondary btn-sm" title="Không thể xóa (còn sách)" disabled>
                                        <i class="fas fa-lock"></i>
                                    </button>
                                    <!-- END: delete_disabled -->
                                </div>
                            </td>
                        </tr>
                        <!-- END: category_loop -->
                    </tbody>
                </table>
            </div>

            <!-- No Categories -->
            <!-- BEGIN: no_categories -->
            <div class="text-center py-5">
                <i class="fas fa-folder-open fa-5x text-muted mb-3"></i>
                <h4>{LANG.no_categories}</h4>
                <p class="text-muted">{LANG.no_categories_message}</p>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add_cat" class="btn btn-primary">
                    {LANG.add_first_category}
                </a>
            </div>
            <!-- END: no_categories -->
        </div>
    </div>

    <script>
    // Add fade-in animation
    document.addEventListener('DOMContentLoaded', function() {
        const statCards = document.querySelectorAll('.stat-card');
        statCards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
            card.classList.add('fade-in');
        });
    });
    </script>

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
