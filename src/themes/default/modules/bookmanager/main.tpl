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

        <!-- Books Grid -->
        <div class="col-md-12">
            <!-- BEGIN: book_loop -->
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h6 class="card-title">
                            <a href="{BOOK.link}" class="text-decoration-none">{BOOK.title}</a>
                        </h6>
                        <p class="card-text small text-muted">{BOOK.author}</p>
                        <p class="card-text text-primary fw-bold">{BOOK.price_format}</p>
                        <a href="{BOOK.link}" class="btn btn-primary btn-sm">{LANG.view_detail}</a>
                    </div>
                </div>
            </div>
            <!-- END: book_loop -->

            <!-- BEGIN: no_books -->
            <div class="col-12">
                <div class="alert alert-info text-center">
                    <h4>{LANG.no_books}</h4>
                    <p>{LANG.no_books_message}</p>
                </div>
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
</div>
<!-- END: main -->
