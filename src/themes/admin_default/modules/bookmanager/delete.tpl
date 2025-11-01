<!-- BEGIN: main -->
<div style="width: 100%; font-size: 16px; line-height: 1.6;">
<h1 style="font-size: 24px; margin-bottom: 20px; color: #333;">{LANG.confirm_delete}</h1>

<div style="background: #fff; border: 1px solid #ddd; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h2 style="color: #dc3545; margin-bottom: 20px;">{LANG.delete_book}: "{BOOK.title}"</h2>

    <div style="display: flex; margin-bottom: 20px;">
    <div style="flex: 1; text-align: center;">
    <!-- BEGIN: image -->
        <img src="{IMAGE_URL}" alt="{BOOK.title}" style="max-width: 200px; border: 1px solid #ddd; border-radius: 4px;" />
        <!-- END: image -->
    <!-- BEGIN: no_image -->
<div style="width: 200px; height: 200px; background: #f8f9fa; border: 1px solid #ddd; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 48px; color: #6c757d;">📖</div>
<!-- END: no_image -->
</div>
<div style="flex: 2; padding-left: 20px;">
<div style="margin-bottom: 10px;"><strong>{LANG.title}:</strong> {BOOK.title}</div>
<div style="margin-bottom: 10px;"><strong>{LANG.author}:</strong> {BOOK.author}</div>
<div style="margin-bottom: 10px;"><strong>{LANG.category}:</strong> {BOOK.cat_title}</div>
<div style="margin-bottom: 10px;"><strong>{LANG.price}:</strong> {BOOK.price_format}</div>
<div style="margin-bottom: 20px;"><strong>{LANG.stock_quantity}:</strong> {BOOK.stock_quantity} cuốn</div>

<div style="background: #fff3cd; color: #856404; padding: 15px; border: 1px solid #ffeaa7; border-radius: 4px;">
<strong>{LANG.warning}:</strong> {LANG.delete_warning_text}
</div>
</div>
        </div>

<form method="post" action="">
            <div style="text-align: center;">
<button type="submit" name="confirm" value="1" style="padding: 12px 24px; background: #dc3545; color: #fff; border: none; border-radius: 4px; font-size: 18px; font-weight: bold; margin-right: 10px;">{LANG.delete}</button>
<a href="{CANCEL_LINK}" style="padding: 12px 24px; background: #6c757d; color: #fff; text-decoration: none; border-radius: 4px; font-size: 18px; font-weight: bold;">{LANG.cancel}</a>
            </div>
</form>
</div>

<!-- BEGIN: error -->
<div style="background: #f8d7da; color: #721c24; padding: 15px; border: 1px solid #f5c6cb; border-radius: 4px; margin-top: 20px;">{ERROR}</div>
<!-- END: error -->
</div>
<!-- END: main -->
