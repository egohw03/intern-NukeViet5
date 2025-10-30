<!-- BEGIN: main -->
<div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <div style="text-align: center; margin-bottom: 30px;">
        <h1 style="font-size: 28px; margin-bottom: 20px;">Gio hang cua ban</h1>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 4px;">
            Quay lai mua sam
        </a>
    </div>

    <!-- BEGIN: cart_items -->
    <form method="post" action="">
        <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px;">
            <div style="padding: 15px 20px; border-bottom: 1px solid #ddd; background: #f8f9fa;">
                <h3 style="margin: 0;">San pham trong gio hang</h3>
            </div>
            <div style="padding: 20px;">
                <table style="width: 100%; border-collapse: collapse;">
                    <thead>
                        <tr style="border-bottom: 2px solid #ddd;">
                            <th style="padding: 10px; text-align: center; width: 80px;">Anh</th>
                            <th style="padding: 10px;">Sach</th>
                            <th style="padding: 10px; text-align: center; width: 120px;">Don gia</th>
                            <th style="padding: 10px; text-align: center; width: 120px;">So luong</th>
                            <th style="padding: 10px; text-align: center; width: 120px;">Thanh tien</th>
                            <th style="padding: 10px; text-align: center; width: 80px;">Xoa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: item -->
                        <tr style="border-bottom: 1px solid #eee;">
                        <td style="padding: 10px; text-align: center;">
                        <!-- BEGIN: image -->
                        <img src="{ITEM.image_url}" alt="{ITEM.title}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                        <!-- END: image -->
                        <!-- BEGIN: no_image -->
                        <div style="width: 50px; height: 50px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; border-radius: 4px;">
                        [S]
                        </div>
                        <!-- END: no_image -->
                        </td>
                        <td style="padding: 10px;">
                        <div style="font-weight: bold;">{ITEM.title}</div>
                        <small style="color: #666;">{ITEM.author}</small>
                        </td>
                        <td style="padding: 10px; text-align: center; font-weight: bold;">{ITEM.price_format}</td>
                        <td style="padding: 10px; text-align: center;">
                        <input type="number" name="quantity[{ITEM.book_id}]" value="{ITEM.quantity}" min="1" max="{ITEM.stock_quantity}" style="width: 80px; padding: 5px; border: 1px solid #ccc; border-radius: 4px; text-align: center;">
                        </td>
                        <td style="padding: 10px; text-align: center; font-weight: bold; color: #007bff;">{ITEM.subtotal}</td>
                        <td style="padding: 10px; text-align: center;">
                        <a href="{ITEM.remove_link}" style="display: inline-block; padding: 5px 10px; background: #dc3545; color: white; text-decoration: none; border-radius: 4px; font-size: 12px;" onclick="return confirm('Ban co chac chan muon xoa sach nay khoi gio hang?')">Xoa</a>
                        </td>
                        </tr>
                        <!-- END: item -->
                    </tbody>
                </table>
            </div>
            <div style="padding: 15px 20px; border-top: 1px solid #ddd; background: #f8f9fa; display: flex; justify-content: space-between; align-items: center;">
            <div>
            <button type="submit" name="update_cart" style="padding: 8px 15px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px;">
                    Cap nhat gio hang
                </button>
                    <button type="submit" name="clear_cart" style="padding: 8px 15px; background: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer;" onclick="return confirm('{LANG.confirm_clear_cart}')">
                    {LANG.clear_cart}
                    </button>
                </div>
                <h3 style="margin: 0; color: #007bff;">Tong tien: {TOTAL}</h3>
            </div>
        </div>

        <!-- BEGIN: checkout -->
        <div style="background: white; padding: 20px; border: 1px solid #ddd; border-radius: 8px; text-align: center;">
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=checkout" style="display: inline-block; padding: 15px 30px; background: #28a745; color: white; text-decoration: none; border-radius: 4px; font-size: 18px;">
                Tien hanh thanh toan
            </a>
        </div>
        <!-- END: checkout -->
    </form>
    <!-- END: cart_items -->

    <!-- BEGIN: empty_cart -->
    <div style="background: white; padding: 50px 20px; border: 1px solid #ddd; border-radius: 8px; text-align: center;">
        <div style="font-size: 64px; color: #6c757d; margin-bottom: 20px;">[GIO]</div>
        <h2 style="margin: 0 0 10px 0; color: #333;">Gio hang trong</h2>
        <p style="margin: 0 0 20px 0; color: #666;">Ban chua them san pham nao vao gio hang.</p>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 4px;">
            Mua sam ngay
        </a>
    </div>
    <!-- END: empty_cart -->
</div>
<!-- END: main -->
