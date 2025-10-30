<!-- BEGIN: main -->
<div class="bookmanager-main">
    <div class="row">
        <!-- Filters -->
        <div class="col-md-12 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.books}</h5>
                </div>
                <div class="card-body">
                    <form method="get" action="{NV_BASE_SITEURL}index.php">
                        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                        <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
                        <input type="hidden" name="{NV_OP_VARIABLE}" value="" />

                        <div class="row">
                            <div class="col-md-4">
                                <select name="cat_id" class="form-select" onchange="this.form.submit()">
                                    <option value="0">{LANG.all_categories}</option>
                                    <!-- BEGIN: cat_filter -->
                                    <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
                                    <!-- END: cat_filter -->
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select name="sort" class="form-select" onchange="this.form.submit()">
                                    <option value="add_time" {SORT.add_time}>{LANG.sort_newest}</option>
                                    <option value="title" {SORT.title}>{LANG.sort_title}</option>
                                    <option value="price" {SORT.price}>{LANG.sort_price}</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <select name="order" class="form-select" onchange="this.form.submit()">
                                    <option value="desc" {ORDER.desc}>{LANG.sort_desc}</option>
                                    <option value="asc" {ORDER.asc}>{LANG.sort_asc}</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Books Table -->
        <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">{LANG.book_list}</h5>
                </div>
        <div class="card-body p-0">
        <div class="table-responsive">
        <table class="table table-hover table-striped mb-0">
            <thead class="table-dark">
                <tr>
                    <th class="text-center" style="width: 80px;">{LANG.image}</th>
                        <th>{LANG.title}</th>
                            <th style="width: 150px;">{LANG.author}</th>
                                <th class="text-center" style="width: 120px;">{LANG.price}</th>
                                <th class="text-center" style="width: 100px;">{LANG.stock_status}</th>
                                    <th class="text-center" style="width: 120px;">{LANG.actions}</th>
                            </tr>
                        </thead>
                    <tbody>
                    <!-- BEGIN: book_loop -->
                    <tr>
                    <td class="text-center" data-label="{LANG.image}">
                    <!-- BEGIN: image -->
                    <img src="{BOOK.image_url}" alt="{BOOK.title}" class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                    <!-- END: image -->
                    <!-- BEGIN: no_image -->
                    <div class="bg-light rounded d-flex align-items-center justify-content-center mx-auto" style="width: 50px; height: 50px; font-size: 24px; font-weight: bold; color: #6c757d;">
                    ?
                    </div>
                    <!-- END: no_image -->
                    </td>
                    <td data-label="{LANG.title}">
                    <div>
                    <h6 class="mb-1">
                    <a href="{BOOK.link}" class="text-decoration-none text-dark">{BOOK.title}</a>
                    </h6>
                    <small class="text-muted">{LANG.category}: {BOOK.category_title}</small>
                    </div>
                    </td>
                    <td data-label="{LANG.author}">
                    <span class="fw-medium">{BOOK.author}</span>
                    </td>
                    <td class="text-center" data-label="{LANG.price}">
                    <span class="fw-bold text-primary fs-6">{BOOK.price_format}</span>
                    </td>
                    <td class="text-center" data-label="{LANG.stock_status}">
                    <!-- BEGIN: in_stock -->
                    <span class="badge bg-success">{LANG.in_stock} ({BOOK.stock_quantity})</span>
                    <!-- END: in_stock -->
                    <!-- BEGIN: out_of_stock -->
                    <span class="badge bg-danger">{LANG.out_of_stock}</span>
                    <!-- END: out_of_stock -->
                    </td>
                    <td class="text-center" data-label="{LANG.actions}">
                    <a href="{BOOK.link}" class="btn btn-primary btn-sm">
                    {LANG.view_detail}
                    </a>
                    <!-- BEGIN: can_add_cart -->
                    <button type="button" class="btn btn-success btn-sm ms-1" onclick="addToCart({BOOK.id})">
                    {LANG.add_to_cart}
                    </button>
                    <!-- END: can_add_cart -->
                    </td>
                    </tr>
                                <!-- END: book_loop -->
                            </tbody>
                        </table>
                    </div>

                    <!-- BEGIN: no_books -->
                    <div class="text-center py-5">
                    <h4 class="text-muted">{LANG.no_books}</h4>
                    <p class="text-muted">{LANG.no_books_message}</p>
                    </div>
                    <!-- END: no_books -->
                </div>
            </div>
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
</div>
<!-- END: main -->
