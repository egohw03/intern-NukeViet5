<!-- BEGIN: main -->
<div class="book-search">
    <h1 class="mb-4">{LANG.search_results}</h1>

    <!-- Advanced Search Form -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="get" action="{NV_BASE_SITEURL}index.php">
                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
                <input type="hidden" name="{NV_OP_VARIABLE}" value="search" />

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">{LANG.search}</label>
                        <input type="text" name="q" value="{SEARCH_QUERY}" class="form-control" placeholder="{LANG.search_placeholder}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">{LANG.author}</label>
                        <input type="text" name="author" value="{AUTHOR}" class="form-control" placeholder="{LANG.author}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">{LANG.publisher}</label>
                        <input type="text" name="publisher" value="{PUBLISHER}" class="form-control" placeholder="{LANG.publisher}">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">{LANG.category}</label>
                        <select name="cat" class="form-select">
                            <option value="0">{LANG.all_categories}</option>
                            <!-- BEGIN: cat_filter -->
                            <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
                            <!-- END: cat_filter -->
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search"></i> {LANG.search}
                        </button>
                    </div>
                </div>

                <!-- Advanced Filters Row -->
                <div class="row g-3 mt-2">
                    <div class="col-md-2">
                        <label class="form-label">{LANG.min_price}</label>
                        <input type="number" name="min_price" value="{MIN_PRICE}" class="form-control" placeholder="0" min="0">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">{LANG.max_price}</label>
                        <input type="number" name="max_price" value="{MAX_PRICE}" class="form-control" placeholder="0" min="0">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">{LANG.sort}</label>
                        <select name="sort" class="form-select">
                            <option value="add_time" {SORT_BY.add_time_selected}>{LANG.sort_by_date}</option>
                            <option value="price_asc" {SORT_BY.price_asc_selected}>{LANG.sort_by_price_asc}</option>
                            <option value="price_desc" {SORT_BY.price_desc_selected}>{LANG.sort_by_price_desc}</option>
                            <option value="rating" {SORT_BY.rating_selected}>{LANG.sort_by_rating}</option>
                        </select>
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <div class="form-check me-3">
                            <input class="form-check-input" type="checkbox" id="advanced_search" onclick="toggleAdvancedSearch()">
                            <label class="form-check-label" for="advanced_search">
                                {LANG.advanced_search}
                            </label>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Search Results -->
    <div class="row">
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

        <!-- No Results -->
        <!-- BEGIN: no_books -->
        <div class="col-12">
            <div class="alert alert-info text-center py-5">
                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                <h4>{LANG.no_search_results}</h4>
                <p>{LANG.no_search_results_message}</p>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary">
                    {LANG.back_to_home}
                </a>
            </div>
        </div>
        <!-- END: no_books -->
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
