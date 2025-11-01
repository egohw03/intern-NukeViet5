<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
        <div>
            <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.reviews_management}</h1>
            <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Quản lý đánh giá sách</p>
        </div>
    </div>

    <div style="background: #fff; border: 3px solid #333; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
    <div style="padding: 25px; background: #f8f9fa; border-bottom: 2px solid #333;">
    <div style="display: flex; justify-content: space-between; align-items: center;">
    <h2 style="font-size: 24px; margin: 0; color: #333;">{LANG.reviews}</h2>
    <p style="font-size: 18px; color: #666; margin: 0;">Hiển thị {TOTAL_REVIEWS} đánh giá</p>
    </div>
    </div>

    <div style="overflow-x: auto;">
    <table style="width: 100%; border-collapse: collapse; font-size: 18px;">
    <thead>
    <tr style="background: #007bff; color: #fff;">
            <th style="padding: 20px; text-align: center; font-size: 20px; width: 80px;">ID</th>
                <th style="padding: 20px; font-size: 20px;">{LANG.title}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.author}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.rating}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.customer_name}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.add_time}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.status}</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 180px;">{LANG.actions}</th>
                    </tr>
                </thead>
            <tbody>
                <!-- BEGIN: review_loop -->
                <tr style="background: #f9f9f9; border-bottom: 1px solid #ddd;">
                <td style="padding: 20px; text-align: center;">{REVIEW.id}</td>
                    <td style="padding: 20px;">
                        <strong>{REVIEW.book_title}</strong>
                        <!-- BEGIN: review_title -->
                        <br><small style="color: #6c757d;">{REVIEW.title}</small>
                        <!-- END: review_title -->
                    </td>
                    <td style="padding: 20px;">{REVIEW.username}</td>
                    <td style="padding: 20px;">
                        <span style="color: #ffc107;">
                            <!-- BEGIN: star -->
                            ★
                            <!-- END: star -->
                        </span>
                        ({REVIEW.rating}/5)
                    </td>
                    <td style="padding: 15px;">{REVIEW.username}</td>
                    <td style="padding: 20px;">{REVIEW.add_time_format}</td>
                    <td style="padding: 20px;">
                    <span style="background: {REVIEW.status_bg}; color: #fff; padding: 5px 10px; border-radius: 4px;">{REVIEW.status_text}</span>
                    </td>
                    <td style="padding: 20px; text-align: center;">
                        <!-- BEGIN: approve -->
                        <a href="{APPROVE_URL}" style="padding: 8px 16px; background: #28a745; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px; margin-right: 10px;" title="{LANG.approve}">✓</a>
                        <!-- END: approve -->
                        <!-- BEGIN: unapprove -->
                        <a href="{UNAPPROVE_URL}" style="padding: 8px 16px; background: #ffc107; color: #333; text-decoration: none; border-radius: 6px; font-size: 16px; margin-right: 10px;" title="{LANG.pending}">
                        <i class="fas fa-times"></i>
                        </a>
                        <!-- END: unapprove -->
                        <a href="{DELETE_URL}" onclick="return confirm('{GLANG.confirm_delete}');" style="padding: 8px 16px; background: #dc3545; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px;" title="{GLANG.delete}">🗑</a>
                    </td>
                </tr>
                <!-- BEGIN: review_content -->
                <tr>
                    <td colspan="8" style="padding: 15px; background: #f8f9fa;">
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
    <div style="text-align: center; padding: 50px 0;">
        <div style="font-size: 48px; color: #6c757d; margin-bottom: 20px;">⭐</div>
        <h5 style="color: #333;">{LANG.no_reviews}</h5>
        <p style="color: #6c757d;">{LANG.no_reviews_message}</p>
    </div>
    <!-- END: no_reviews -->

    <!-- BEGIN: pagination -->
    <div style="margin-top: 20px; text-align: center;">
        <nav aria-label="Page navigation">
            <ul style="list-style: none; display: inline-flex; gap: 5px;">
                <!-- BEGIN: page -->
                <li style="{PAGE.current_style}">
                    <a href="{PAGE.url}" style="padding: 8px 12px; text-decoration: none; border: 1px solid #ddd; border-radius: 4px; color: {PAGE.color};">{PAGE.num}</a>
                </li>
                <!-- END: page -->
            </ul>
        </nav>
    </div>
    <!-- END: pagination -->
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
