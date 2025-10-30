<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
<div class="page-header">
        <div class="container-fluid">
            <div class="header-content">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="h3 mb-0">{LANG.categories} ({CATEGORIES_COUNT})</h1>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add_cat" class="btn btn-primary">
                    {LANG.add_cat}
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

<!-- Categories List -->
        <div class="card">
        <div class="card-header">
            <h5 class="mb-0">{LANG.categories}</h5>
        </div>
        <div class="card-body p-0">
        <div class="table-responsive">
                <table class="table table-hover mb-0">
            <thead>
            <tr>
            <th class="text-center" style="width: 60px;">ID</th>
                <th>{LANG.title}</th>
                <th class="text-center" style="width: 100px;">{LANG.books}</th>
            <th class="text-center" style="width: 80px;">{LANG.weight}</th>
            <th class="text-center" style="width: 100px;">{LANG.status}</th>
            <th class="text-center" style="width: 140px;">{LANG.actions}</th>
            </tr>
            </thead>
                    <tbody>
                        <!-- BEGIN: category_loop -->
                        <tr>
                        <td class="text-center">
                        <strong class="text-primary">{CAT.id}</strong>
                        </td>
                        <td>
                        <strong class="text-dark">{CAT.title}</strong>
                        <!-- BEGIN: has_subcats -->
                        <br><small class="text-muted">({CAT.subcat_count} thể loại con)</small>
                        <!-- END: has_subcats -->
                        </td>
                        <td class="text-center">
                        <strong class="text-primary">{CAT.book_count}</strong>
                        </td>
                        <td class="text-center">
                        {CAT.weight}
                        </td>
                        <td class="text-center">
                            <span class="badge bg-{CAT.status_class}">{CAT.status_text}</span>
                        </td>
                        <td class="text-center">
                        <div class="d-flex gap-1 justify-content-center">
                                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=edit_cat&id={CAT.id}" class="btn btn-outline-primary btn-sm" title="{LANG.edit_cat}">
                                    {LANG.edit}
                                </a>
                                <!-- BEGIN: delete_allowed -->
                                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=del_cat&id={CAT.id}" class="btn btn-outline-danger btn-sm" title="{LANG.del_cat}" onclick="return confirm('{LANG.confirm_delete}')">
                                    {LANG.delete}
                                </a>
                                <!-- END: delete_allowed -->
                            <!-- BEGIN: delete_disabled -->
                                <button class="btn btn-outline-secondary btn-sm" title="Không thể xóa" disabled title="Có sách - không thể xóa">
                                    {LANG.delete}
                            </button>
                            <!-- END: delete_disabled -->
                        </div>
                        </td>
                        </tr>
                        <!-- END: category_loop -->
                    </tbody>
                </table>
            </div>

            <!-- BEGIN: no_categories -->
            <div class="text-center py-4">
            <p class="text-muted mb-2">{LANG.no_categories}</p>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add_cat" class="btn btn-primary btn-sm">
            {LANG.add_first_category}
            </a>
            </div>
            <!-- END: no_categories -->
                </div>
        </div>
    </div>

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
