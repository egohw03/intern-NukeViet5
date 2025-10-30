<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div class="page-header">
        <div class="container-fluid">
            <div class="header-content">
                <div class="header-title">
                    <i class="fas fa-book"></i>
                    <div>
                        <h1>{LANG.book_list} ({TOTAL_BOOKS})</h1>
                        <div class="header-subtitle">Danh sách tất cả sách trong hệ thống</div>
                    </div>
                </div>
                <div class="header-actions">
                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add" class="btn btn-light">
                        <i class="fas fa-plus-circle me-2"></i>{LANG.add_book}
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">

    



    <!-- Filters -->
        <div class="data-table-container mb-4">
        <div class="data-table-header">
        <h5><i class="fas fa-filter me-2"></i>{LANG.filters}</h5>
        </div>
        <div class="p-3">
        <form method="get" action="{NV_BASE_ADMINURL}index.php">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
        <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />

        <div class="row g-3">
        <div class="col-md-3">
        <label class="form-label">{LANG.category}</label>
        <select name="cat_id" class="form-select">
        <option value="0">{LANG.all_categories}</option>
        <!-- BEGIN: cat_filter -->
        <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
        <!-- END: cat_filter -->
        </select>
        </div>
        <div class="col-md-3">
        <label class="form-label">{LANG.status}</label>
        <select name="status" class="form-select">
        <option value="-1" {STATUS_ALL}>{LANG.all}</option>
        <option value="1" {STATUS_ACTIVE}>{LANG.active}</option>
        <option value="0" {STATUS_INACTIVE}>{LANG.inactive}</option>
        </select>
        </div>
        <div class="col-md-4">
        <label class="form-label">{LANG.search}</label>
        <input type="text" name="q" value="{SEARCH_QUERY}" class="form-control" placeholder="{LANG.search_placeholder}">
        </div>
        <div class="col-md-2">
        <label class="form-label">&nbsp;</label>
        <button type="submit" class="btn btn-primary w-100">
        <i class="fas fa-search me-2"></i>{LANG.search}
    </button>
    </div>
    </div>
    </form>
    </div>
    </div>

    <!-- Books Table -->
        <div class="data-table-container">
        <div class="data-table-header">
        <h5><i class="fas fa-book me-2"></i>{LANG.book_list}</h5>
    </div>
    <div class="table-responsive">
    <table class="data-table">
    <thead>
    <tr>
    <th>{LANG.image}</th>
    <th>{LANG.title}</th>
    <th>{LANG.category}</th>
    <th>{LANG.price}</th>
    <th>{LANG.stock_quantity}</th>
    <th>{LANG.status}</th>
        <th>{LANG.add_time}</th>
            <th>{LANG.actions}</th>
        </tr>
    </thead>
    <tbody>
    <!-- BEGIN: book_loop -->
    <tr>
    <td>
    <!-- BEGIN: image -->
    <div class="text-center">
        <img src="{BOOK.image_url}" alt="{BOOK.title}" class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
    </div>
    <!-- END: image -->
    <!-- BEGIN: no_image -->
        <div class="text-center">
            <div class="bg-light rounded d-flex align-items-center justify-content-center mx-auto" style="width: 50px; height: 50px;">
            <i class="fas fa-book text-muted"></i>
        </div>
    </div>
        <!-- END: no_image -->
    </td>
    <td>
        <div>
        <strong class="text-dark">{BOOK.title}</strong>
            <br>
            <small class="text-muted"><i class="fas fa-user me-1"></i>{BOOK.author}</small>
    </div>
    </td>
    <td>
    <span class="badge bg-light text-dark">{BOOK.cat_title}</span>
    </td>
    <td>
    <strong class="text-primary fs-6">{BOOK.price_format}</strong>
    </td>
    <td>
    <span class="badge bg-{BOOK.stock_class}">{BOOK.stock_quantity}</span>
    </td>
    <td>
    <span class="status-badge status-{BOOK.status_text}">{BOOK.status_text}</span>
    </td>
    <td>
    <small class="text-muted">{BOOK.add_time}</small>
    <!-- BEGIN: edit_time -->
        <div class="mt-1">
                <small class="text-success"><i class="fas fa-edit me-1"></i>{BOOK.edit_time}</small>
            </div>
                <!-- END: edit_time -->
                </td>
                    <td>
                                <div class="action-buttons">
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=edit&id={BOOK.id}" class="btn btn-outline-primary btn-sm" title="{LANG.edit}">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=delete&id={BOOK.id}" class="btn btn-outline-danger btn-sm" title="{LANG.delete}" onclick="return confirm('{LANG.confirm_delete}')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <!-- END: book_loop -->
                    </tbody>
                </table>
            </div>

            <!-- No Books -->
            <!-- BEGIN: no_books -->
            <div class="text-center py-5">
                <i class="fas fa-book-open fa-5x text-muted mb-3"></i>
                <h4>{LANG.no_books}</h4>
                <p class="text-muted">{LANG.no_books_message}</p>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add" class="btn btn-primary">
                    {LANG.add_first_book}
                </a>
            </div>
            <!-- END: no_books -->
        </div>
    </div>

    <!-- Pagination -->
    <!-- BEGIN: generate_page -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- BEGIN: prev -->
            <li class="page-item {PREV.disabled}">
                <a class="page-link" href="{PREV.link}" {PREV.attr}>{LANG.prev}</a>
            </li>
            <!-- END: prev -->

            <!-- BEGIN: page -->
            <li class="page-item {PAGE.current}">
                <a class="page-link" href="{PAGE.link}">{PAGE.num}</a>
            </li>
            <!-- END: page -->

            <!-- BEGIN: next -->
            <li class="page-item {NEXT.disabled}">
                <a class="page-link" href="{NEXT.link}" {NEXT.attr}>{LANG.next}</a>
            </li>
            <!-- END: next -->
        </ul>
    </nav>
    <!-- END: generate_page -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
