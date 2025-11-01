<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
        <div>
            <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.add_book}</h1>
            <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Thêm sách mới vào thư viện</p>
        </div>
    </div>

    <!-- BEGIN: error -->
    <div style="background: #f8d7da; color: #721c24; padding: 20px; border: 2px solid #f5c6cb; border-radius: 8px; margin-bottom: 25px; font-size: 18px;">{ERROR}</div>
    <!-- END: error -->

    <form action="{FORM_ACTION}" method="post" enctype="multipart/form-data" style="background: #fff; border: 3px solid #007bff; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.title}</label>
        <input type="text" name="title" value="{BOOK.title}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required />
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.category}</label>
        <select name="cat_id" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required>
        <option value="">{LANG.select_category}</option>
        <!-- BEGIN: cat_option -->
        <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
        <!-- END: cat_option -->
        </select>
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.author}</label>
        <input type="text" name="author" value="{BOOK.author}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required />
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.publisher}</label>
        <input type="text" name="publisher" value="{BOOK.publisher}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" />
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.publish_year}</label>
        <input type="number" name="publish_year" value="{BOOK.publish_year}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" min="1000" max="{CURRENT_YEAR}" />
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.isbn}</label>
        <input type="text" name="isbn" value="{BOOK.isbn}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" />
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.description}</label>
        <textarea name="description" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px; height: 150px;">{BOOK.description}</textarea>
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.image}</label>
        <input type="file" name="image" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" />
        <!-- BEGIN: current_image -->
        <div style="margin-top: 15px;">
        <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.current_image}:</label>
        <img src="{IMAGE_URL}" alt="Current image" style="max-width: 250px; border: 2px solid #ddd; border-radius: 8px;" />
        </div>
        <!-- END: current_image -->
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.price}</label>
        <input type="number" name="price" value="{BOOK.price}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" step="0.01" min="0" />
        </div>

        <div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.stock_quantity}</label>
        <input type="number" name="stock_quantity" value="{BOOK.stock_quantity}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" min="0" />
        </div>

        <div style="margin-bottom: 30px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.status}</label>
        <input type="checkbox" name="status" value="1" {BOOK.status_checked} style="margin-right: 10px; width: 20px; height: 20px;" /> <span style="font-size: 18px; color: #333;">{LANG.active}</span>
        </div>

        <div style="text-align: center;">
        <button type="submit" name="submit" style="padding: 15px 30px; background: #28a745; color: #fff; border: 2px solid #28a745; border-radius: 8px; font-size: 18px; font-weight: bold; margin-right: 15px;">{LANG.save}</button>
        <a href="{BACK_LINK}" style="padding: 15px 30px; background: #6c757d; color: #fff; text-decoration: none; border: 2px solid #6c757d; border-radius: 8px; font-size: 18px; font-weight: bold;">{LANG.cancel}</a>
        </div>
    </form>
</div>
<!-- END: main -->
