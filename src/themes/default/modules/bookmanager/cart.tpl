<!-- BEGIN: main -->
<div style="width: 100%; margin: 0 auto; padding: 40px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6;">
<!-- Header -->
<div style="text-align: center; margin-bottom: 50px;">
<h1 style="font-size: 42px; margin-bottom: 20px; color: #2c3e50; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);">🛒 Giỏ hàng</h1>
<p style="font-size: 18px; color: #6c757d; margin-bottom: 25px;">Xem và quản lý các sản phẩm trong giỏ hàng của bạn</p>
<a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 15px 30px; background: linear-gradient(135deg, #6c757d 0%, #495057 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">⬅️ Tiếp tục mua sắm</a>
</div>

    <!-- BEGIN: cart_items -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #007bff; border-radius: 20px; overflow: hidden; box-shadow: 0 15px 40px rgba(0, 123, 255, 0.2); margin-bottom: 40px;">
    <div style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); padding: 25px; color: white;">
    <h3 style="margin: 0; font-size: 28px; font-weight: 700;">📦 Giỏ hàng của bạn</h3>
    </div>

    <div style="padding: 30px;">
    <form method="post" action="" style="display: grid; gap: 25px;">
    <!-- BEGIN: item -->
    <div style="display: grid; grid-template-columns: auto 1fr auto auto auto; gap: 20px; align-items: center; padding: 20px; background: rgba(255,255,255,0.8); border-radius: 15px; border: 2px solid #e9ecef; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.1)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 15px rgba(0,0,0,0.05)';">
    <!-- Image -->
    <div style="width: 80px; height: 80px; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
    <!-- BEGIN: image -->
    <img src="{ITEM.image_url}" alt="{ITEM.title}" style="width: 100%; height: 100%; object-fit: cover;">
    <!-- END: image -->
    <!-- BEGIN: no_image -->
    <div style="width: 100%; height: 100%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; font-size: 32px; color: white;">📖</div>
    <!-- END: no_image -->
    </div>

    <!-- Product Info -->
    <div>
    <h4 style="margin: 0 0 8px 0; font-size: 20px; font-weight: 700; color: #2c3e50;">{ITEM.title}</h4>
    <p style="margin: 0; font-size: 16px; color: #17a2b8; font-weight: 600;">✍️ {ITEM.author}</p>
    <p style="margin: 5px 0 0 0; font-size: 14px; color: #6c757d;">📦 Còn {ITEM.stock_quantity} cuốn trong kho</p>
    </div>

    <!-- Price -->
    <div style="text-align: center;">
    <span style="font-size: 18px; font-weight: 600; color: #dc3545;">{ITEM.price_format}</span>
    <div style="font-size: 14px; color: #6c757d;">Đơn giá</div>
    </div>

    <!-- Quantity -->
    <div style="display: flex; align-items: center; gap: 8px;">
    <button type="button" onclick="changeQuantity('{ITEM.book_id}', -1)" style="width: 35px; height: 35px; border: 2px solid #007bff; background: white; color: #007bff; border-radius: 8px; cursor: pointer; font-size: 18px; font-weight: 700; transition: all 0.2s ease;" onmouseover="this.style.background='#007bff'; this.style.color='white';" onmouseout="this.style.background='white'; this.style.color='#007bff';">−</button>
    <input type="number" name="quantity[{ITEM.book_id}]" value="{ITEM.quantity}" min="1" max="{ITEM.stock_quantity}" onchange="updateTotal()" style="width: 60px; padding: 8px; border: 2px solid #007bff; border-radius: 6px; text-align: center; font-size: 16px; font-weight: 600;">
    <button type="button" onclick="changeQuantity('{ITEM.book_id}', 1)" style="width: 35px; height: 35px; border: 2px solid #007bff; background: white; color: #007bff; border-radius: 8px; cursor: pointer; font-size: 18px; font-weight: 700; transition: all 0.2s ease;" onmouseover="this.style.background='#007bff'; this.style.color='white';" onmouseout="this.style.background='white'; this.style.color='#007bff';">+</button>
    </div>

    <!-- Subtotal & Remove -->
    <div style="text-align: center;">
    <div style="font-size: 20px; font-weight: 700; color: #28a745; margin-bottom: 8px;">{ITEM.subtotal}</div>
    <a href="{ITEM.remove_link}" onclick="return confirm('Xóa sản phẩm này khỏi giỏ hàng?')" style="display: inline-block; padding: 8px 12px; background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); color: white; text-decoration: none; border-radius: 6px; font-size: 14px; font-weight: 600; box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🗑️ Xóa</a>
    </div>
    </div>
    <!-- END: item -->

                <!-- Cart Actions -->
                <div style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border-top: 3px solid #007bff; padding: 30px; margin-top: 30px;">
                <div style="display: grid; grid-template-columns: 1fr auto; gap: 40px; align-items: center;">
                <div style="display: flex; gap: 15px;">
                <button type="submit" name="update_cart" style="padding: 15px 25px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; border: none; border-radius: 10px; cursor: pointer; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🔄 Cập nhật giỏ hàng</button>
                <button type="submit" name="clear_cart" onclick="return confirm('Bạn có chắc muốn xóa tất cả sản phẩm trong giỏ hàng?')" style="padding: 15px 25px; background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); color: white; border: none; border-radius: 10px; cursor: pointer; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(220, 53, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🗑️ Xóa tất cả</button>
                </div>
                <div style="display: flex; align-items: center; gap: 30px;">
                <div style="text-align: right;">
                <div style="font-size: 16px; color: #6c757d; margin-bottom: 5px;">Tổng cộng</div>
                <div style="font-size: 32px; font-weight: 700; color: #dc3545; text-shadow: 2px 2px 4px rgba(220, 53, 69, 0.2);">{TOTAL}</div>
                </div>
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=checkout"
                       style="display: inline-block; padding: 20px 40px; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; text-decoration: none; border-radius: 15px; font-size: 20px; font-weight: 700; box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">💳 Tiến hành thanh toán</a>
                </div>
                </div>
                </div>
                </form>
                </div>
                </div>
                <!-- END: cart_items -->

    <!-- BEGIN: empty_cart -->
    <div style="text-align: center; padding: 80px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border: 4px solid #6c757d; border-radius: 20px; box-shadow: 0 15px 40px rgba(108, 117, 125, 0.2);">
    <div style="font-size: 96px; margin-bottom: 30px; text-shadow: 4px 4px 8px rgba(0,0,0,0.1);">🛒❌</div>
    <h2 style="margin: 0 0 20px 0; color: #2c3e50; font-size: 32px; font-weight: 700;">Giỏ hàng trống</h2>
    <p style="margin: 0 0 30px 0; color: #6c757d; font-size: 20px; line-height: 1.6;">Bạn chưa có sản phẩm nào trong giỏ hàng. Hãy khám phá và chọn sách yêu thích!</p>
    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 20px 40px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 12px; font-size: 20px; font-weight: 600; box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🛍️ Mua sắm ngay</a>
    </div>
    <!-- END: empty_cart -->
</div>

<!-- Simple JavaScript -->
<script>
function changeQuantity(bookId, change) {
    var input = document.querySelector('input[name="quantity[' + bookId + ']"]');
    var currentValue = parseInt(input.value);
    var newValue = currentValue + change;

    if (newValue >= 1 && newValue <= parseInt(input.max)) {
        input.value = newValue;
    }
}

function updateTotal() {
    // Simple form submission for now
    console.log('Quantity updated');
}
</script>
<!-- END: main -->
