<!-- BEGIN: main -->
<div class="card">
    <div class="card-header">
        <h5 class="mb-0">{LANG.reviews_management}</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th width="50">ID</th>
                        <th>{LANG.title}</th>
                        <th>{LANG.author}</th>
                        <th>{LANG.rating}</th>
                        <th>{LANG.customer_name}</th>
                        <th>{LANG.add_time}</th>
                        <th>{LANG.status}</th>
                        <th width="150">{LANG.function}</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: review_loop -->
                    <tr>
                        <td>{REVIEW.id}</td>
                        <td>
                            <strong>{REVIEW.book_title}</strong>
                            <!-- BEGIN: review_title -->
                            <br><small class="text-muted">{REVIEW.title}</small>
                            <!-- END: review_title -->
                        </td>
                        <td>{REVIEW.username}</td>
                        <td>
                            <span class="text-warning">
                                <!-- BEGIN: star -->
                                ★
                                <!-- END: star -->
                            </span>
                            ({REVIEW.rating}/5)
                        </td>
                        <td>{REVIEW.username}</td>
                        <td>{REVIEW.add_time_format}</td>
                        <td>
                            <span class="badge bg-{REVIEW.status_class}">{REVIEW.status_text}</span>
                        </td>
                        <td>
                            <!-- BEGIN: approve -->
                            <a href="{APPROVE_URL}" class="btn btn-sm btn-success" title="{LANG.approve}">
                                <i class="fas fa-check"></i>
                            </a>
                            <!-- END: approve -->
                            <!-- BEGIN: unapprove -->
                            <a href="{UNAPPROVE_URL}" class="btn btn-sm btn-warning" title="{LANG.pending}">
                                <i class="fas fa-times"></i>
                            </a>
                            <!-- END: unapprove -->
                            <a href="{DELETE_URL}" class="btn btn-sm btn-danger" onclick="return confirm('{GLANG.confirm_delete}');" title="{GLANG.delete}">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <!-- BEGIN: review_content -->
                    <tr>
                        <td colspan="8" class="bg-light">
                            <strong>{LANG.review_content}:</strong><br>
                            {REVIEW.content}
                        </td>
                    </tr>
                    <!-- END: review_content -->
                    <!-- END: review_loop -->
                </tbody>
            </table>
        </div>

        <!-- BEGIN: no_reviews -->
        <div class="text-center py-5">
            <i class="fas fa-star-half-alt fa-3x text-muted mb-3"></i>
            <h5>{LANG.no_reviews}</h5>
            <p class="text-muted">{LANG.no_reviews_message}</p>
        </div>
        <!-- END: no_reviews -->

        <!-- Pagination -->
        <!-- BEGIN: pagination -->
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
                <!-- BEGIN: page -->
                <li class="page-item {PAGE.current}">
                    <a class="page-link" href="{PAGE.url}">{PAGE.num}</a>
                </li>
                <!-- END: page -->
            </ul>
        </nav>
        <!-- END: pagination -->
    </div>
</div>

<script>
// Toggle review content visibility
$(document).ready(function() {
    $('.review-toggle').click(function() {
        $(this).next('.review-content').slideToggle();
    });
});
</script>
<!-- END: main -->
