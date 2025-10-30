<!-- BEGIN: main -->
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
                    <div class="bg-light rounded d-flex align-items-center justify-content-center mx-auto" style="width: 50px; height: 50px;">
                        <i class="fas fa-book text-muted"></i>
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
                        <i class="fas fa-eye me-1"></i>{LANG.view_detail}
                    </a>
                    <!-- BEGIN: can_add_cart -->
                    <button type="button" class="btn btn-success btn-sm ms-1" onclick="addToCart({BOOK.id})">
                        <i class="fas fa-cart-plus me-1"></i>{LANG.add_to_cart}
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
    <i class="fas fa-book-open fa-4x text-muted mb-3"></i>
    <h4 class="text-muted">{LANG.no_books}</h4>
    <p class="text-muted">{LANG.no_books_message}</p>
</div>
<!-- END: no_books -->

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
<!-- END: main -->
