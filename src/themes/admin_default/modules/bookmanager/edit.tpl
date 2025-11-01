<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
        <div>
            <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.edit_book}: {BOOK.title}</h1>
            <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Chỉnh sửa thông tin sách</p>
        </div>
    </div>

    <!-- BEGIN: error -->
    <div style="background: #f8d7da; color: #721c24; padding: 20px; border: 2px solid #f5c6cb; border-radius: 8px; margin-bottom: 25px; font-size: 18px;">{ERROR}</div>
    <!-- END: error -->

    <form action="{FORM_ACTION}" method="post" enctype="multipart/form-data" style="background: #fff; border: 3px solid #007bff; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.title}</label>
    <input type="text" name="title" value="{BOOK.title}" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" required />
    </div>

    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.category}</label>
    <select name="cat_id" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" required>
    <option value="">{LANG.select_category}</option>
    <!-- BEGIN: cat_option -->
    <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
    <!-- END: cat_option -->
    </select>
    </div>

    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.author}</label>
    <input type="text" name="author" value="{BOOK.author}" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" required />
    </div>

    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.publisher}</label>
    <input type="text" name="publisher" value="{BOOK.publisher}" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" />
    </div>

    <div style="margin-bottom: 20px;">
            <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.publish_year}</label>
    <input type="number" name="publish_year" value="{BOOK.publish_year}" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" min="1000" max="{CURRENT_YEAR}" />
    </div>

    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.isbn}</label>
    <input type="text" name="isbn" value="{BOOK.isbn}" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" />
    </div>

    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.description}</label>
    <textarea name="description" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px; height: 120px;">{BOOK.description}</textarea>
    </div>

    <div style="margin-bottom: 20px;">
            <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.image}</label>
    <input type="file" name="image" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" />
    <!-- BEGIN: current_image -->
    <div style="margin-top: 10px;">
    <label style="display: block; font-size: 16px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.current_image}:</label>
    <img src="{IMAGE_URL}" alt="Current image" style="max-width: 200px; border: 1px solid #ddd; border-radius: 4px;" />
    </div>
    <!-- END: current_image -->
    </div>

    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.price}</label>
    <input type="number" name="price" value="{BOOK.price}" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" step="0.01" min="0" />
    </div>

    <div style="margin-bottom: 20px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.stock_quantity}</label>
    <input type="number" name="stock_quantity" value="{BOOK.stock_quantity}" style="width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;" min="0" />
    </div>

    <div style="margin-bottom: 30px;">
    <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 5px; color: #333;">{LANG.status}</label>
    <div style="display: flex; gap: 20px; align-items: center;">
    <label style="font-size: 16px; color: #333;">
    <input type="radio" name="status" value="1" {BOOK.status_active_checked} style="margin-right: 8px;" /> {LANG.active}
    </label>
    <label style="font-size: 16px; color: #333;">
    <input type="radio" name="status" value="0" {BOOK.status_inactive_checked} style="margin-right: 8px;" /> {LANG.inactive}
    </label>
    </div>
    </div>

    <div style="text-align: center;">
            <button type="submit" name="submit" style="padding: 12px 24px; background: #28a745; color: #fff; border: none; border-radius: 4px; font-size: 18px; font-weight: bold; margin-right: 10px;">{LANG.update}</button>
    <a href="{BACK_LINK}" style="padding: 12px 24px; background: #6c757d; color: #fff; text-decoration: none; border-radius: 4px; font-size: 18px; font-weight: bold;">{LANG.cancel}</a>
    </div>
    </form>
</div>
<!-- END: main -->
