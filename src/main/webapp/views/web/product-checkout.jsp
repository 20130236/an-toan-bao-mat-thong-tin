<%@ page import="model.UserModel" %>
<% UserModel user = (UserModel) request.getAttribute("user"); %>
<%@ page import="model.Product" %>
<%@ page import="java.util.Collection" %>
<%@ page import="model.ProductInCart" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="cart" class="beans.Cart" scope="session"/>

<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<html lang="en">


<!-- product-checkout07:12-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Thanh toán</title>

    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>

    <style>

        body {
            font-size: 10.5pt !important;
        }

        .step-active {
            display: block !important;
        }

        .check-info .content {
            display: none;
        }

        .ty-payments-list .list_checkbox {
            float: left;
            margin-top: 5px;
        }

        .ty-payments-list__item-group {
            padding-left: 20px;
        }

        .ty-payments-list__item {
            padding-bottom: 10px;
        }

        .clearfix .continue {
            margin-top: 15px !important;
            margin-bottom: 25px !important;
        }

        .content {
            width: 98% !important;
        }

        .cart-summary a {
            color: #fff;
        }

    </style>

</head>

<body class="product-checkout checkout-cart">
<jsp:include page="/common/web/header.jsp"></jsp:include>

<!-- main content -->
<div id="checkout" class="main-content">
    <div class="wrap-banner">
        <!-- breadcrumb -->
        <nav class="breadcrumb-bg">
            <div class="container no-index">
                <div class="breadcrumb">
                    <ol>
                        <li>
                            <a href="#">
                                <span>Trang chủ</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>Thanh toán</span>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
        </nav>

        <!-- main -->
        <div id="wrapper-site">
            <div class="container">
                <div class="row">
                    <div id="content-wrapper" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 onecol">
                        <form action="<c:url value="/add_order_success"/>" method="POST" name="order" id="form_order">
                            <div id="main">
                                <div class="cart-grid row">
                                    <div class="col-md-8 check-info">
                                        <div class="checkout-personal-step ">
                                            <h3 class="step-title h3 info" id="step-title-1">
                                                <span class="step-number">1</span>THÔNG TIN CÁ NHÂN
                                            </h3>
                                        </div>
                                        <div class="content step-active" id="step1">
                                            <ul class="nav nav-inline">
                                                <li class="nav-item">
                                                    <a class="nav-link active" data-toggle="tab"
                                                       href="#checkout-guest-form">
                                                        THÔNG TIN ĐẶT HÀNG
                                                    </a>
                                                </li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane fade in active show" id="checkout-guest-form"
                                                     role="tabpanel">
                                                    <div>
                                                        <input type="hidden" name="id_customer" value="">
                                                        <div class="form-group row">
                                                            <input class="form-control" name="name" type="text"
                                                                   id="name"
                                                                   placeholder="Họ và tên : <%=user.getUserName()%>"
                                                                   disabled="disabled">
                                                        </div>
                                                        <div class="form-group row">
                                                            <input class="form-control" name="email" type="email"
                                                                   id="email"
                                                                   placeholder="Email : <%=user.getEmail()%>"
                                                                   disabled="disabled">
                                                        </div>
                                                        <div class="form-group row">
                                                            <input class="form-control" name="phone" type="text"
                                                                   id="phone"
                                                                   placeholder="Điện thoại : <%=user.getPhoneNum()%>"
                                                                   value="<%=user.getPhoneNum()%>">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="checkout-personal-step">
                                            <h3 class="step-title h3 " id="step-title-2">
                                                <span class="step-number">2</span>Địa chỉ
                                            </h3>
                                        </div>
                                        <div class="content step-active" id="step2">
                                            <ul class="nav nav-inline">
                                                <li class="nav-item">
                                                    <a class="nav-link active" data-toggle="tab" href="#">
                                                        Địa chỉ hoá đơn
                                                    </a>
                                                </li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane fade in active show" role="tabpanel">
                                                    <div>
                                                        <div class="form-group row">
                                                            <label for="province">Chọn tỉnh</label>
                                                            <select class="form-control" id="province" name="province">
                                                                <c:forEach items="${listProvinces}" var="item">
                                                                    <option value="${item.id}">${item.name}</option>
                                                                </c:forEach>
                                                                <!-- Các tùy chọn khác -->
                                                            </select>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div>

                                                <label for="district">Huyện:</label>
                                                <select class="form-control" id="district" name="district">
                                                    <option value="">Chọn huyện</option>
                                                </select>

                                            </div>
                                            <div>

                                                <label for="ward">Xã:</label>
                                                <select class="form-control" id="ward" name="ward">
                                                    <option value="">Chọn xã</option>
                                                </select>
                                                <!-- Thêm input để đưa giá trị của select box vào servlet -->
                                                <input type="hidden" id="province-value" name="province-value">
                                                <input type="hidden" id="district-value" name="district-value">
                                                <input type="hidden" id="ward-value" name="ward-value">
                                                <!-- Thêm input để đưa giá trị của select box vào servlet -->
                                                <input type="hidden" id="province-id" name="province-id">
                                                <input type="hidden" id="district-id" name="district-id">
                                                <input type="hidden" id="ward-id" name="ward-id">
                                            </div>
                                        </div>
                                        <div class="checkout-personal-step">
                                            <h3 class="step-title h3" id="step-title-3">
                                                <span class="step-number">3</span>Thanh toán
                                            </h3>
                                        </div>
                                        <div class="content step-active" id="step3">
                                            <ul class="nav nav-inline">
                                                <li class="nav-item">
                                                    <a class="nav-link active" data-toggle="tab"
                                                       href="#checkout-guest-form">
                                                        PHƯƠNG THỨC THANH TOÁN
                                                    </a>
                                                </li>
                                            </ul>
                                            <div class="tab-content">
                                                <input type="radio" id="paypal" name="paymentMethod"
                                                       value="Giao hàng thu tiền tận nhà">
                                                <label for="paypal">Giao hàng thu tiền tận nhà</label><br>
                                                <div class="ty-payments-list__description">
                                                    Miễn phí các quận nội thành HCM ( Theo quy định của
                                                    HappyHome... vui lòng xem chi tiết chính sách vận
                                                    chuyển)
                                                </div>
                                                <input type="radio" id="credit-card" name="paymentMethod"
                                                       value="Nhận hàng tại cửa hàng">
                                                <label for="credit-card">Nhận hàng tại cửa hàng</label><br>
                                                <div class="ty-payments-list__description">
                                                    Giảm ngay 50.000đ nếu khách hàng nhận hàng tại
                                                    HappyHome ( Áp dụng sản phẩm từ : 1 triệu)
                                                </div>
                                                <input type="radio" id="bank-transfer" name="paymentMethod"
                                                       value="Thanh toán qua ngân hàng">
                                                <label for="bank-transfer">Thanh toán qua ngân hàng</label><br>
                                                <div class="ty-payments-list__description">
                                                    Khách hàng chuyển khoản thanh toán vào các tài khoản
                                                    của HappyHome
                                                </div>
                                                <div class="tab-pane fade in active show" role="tabpanel">
                                                    <div>
                                                        <div class="form-group row">
                                                            <textarea class="form-control" name="message" id="message"
                                                                      placeholder="Để lại lời nhắn cho chúng tôi"
                                                                      rows="3"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix">
                                                    <div class="row">
                                                        <button type="submit"
                                                                class="continue btn btn-primary pull-xs-right"
                                                                style="margin-top: 15px;margin-bottom: 25px">Hoàn tất
                                                            đặt
                                                            hàng
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cart-grid-right col-xs-12 col-lg-4">
                                        <div class="cart-summary">
                                            <div class="cart-detailed-totals">
                                                <div class="cart-summary-products">
                                                    <div class="summary-label">Có ${cart.quantity} sản phẩm trong giỏ
                                                        hàng của bạn
                                                    </div>
                                                </div>
                                                <div class="cart-summary-line" id="cart-subtotal-products">
                                                    <span class="label js-subtotal">
                                                        Tổng Sản phẩm:
                                                    </span>
                                                    <span class="value" id="cart-totalThanhtoan"></span>
                                                </div>
                                                <div class="cart-summary-line" id="cart-subtotal-shipping">

                                                    <span class="label">
                                                        Tổng phí chuyển hàng:
                                                    </span>
                                                    <span class="value"></span>
                                                    <input type="hidden" name="shippingFee" id="shipping-fee-input">

                                                </div>
                                                <div class="cart-summary-line cart-total">
                                                    <span class="label">Tổng:</span>
                                                    <span class="value" id="cart-totalThanhtoan1"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="cart-summary" style="margin-top: 30px">
                                            <div class="cart-detailed-totals">
                                                <div class="cart-summary-products">
                                                    <div class="summary-label">Sản phẩm trong giỏ hàng của bạn :</div>
                                                </div>
                                                <% Collection<ProductInCart> list = cart.getListProductInCart();
                                                    for (ProductInCart p : list) {%>
                                                <div class="cart-summary-line" id="cart-products">
                                                    <span class="label js-subtotal">
                                                      <a href=""><%=p.getProduct().getName()%></a>
                                                    </span>
                                                    <span class="value"><%=p.getQuantity()%> x <%=p.getProduct().formatCurrency(p.getProduct().getPrice_sell())%> =<%=p.getProduct().formatCurrency(p.getQuantity()*p.getProduct().getPrice_sell())%></span>
                                                </div>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<jsp:include page="/common/web/footer.jsp"></jsp:include>
<!-- Vendor JS -->
<jsp:include page="/common/web/js.jsp"></jsp:include>
<script>
    // Lấy giá trị số tiền từ đối tượng cart
    const cartTotal22 = ${cart.total};

    // Chuyển đổi định dạng tiền tệ sang VND
    const formattedCartTotal22 = cartTotal22.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });

    // Hiển thị giá trị đã được định dạng trên trang web
    document.getElementById("cart-totalThanhtoan").innerHTML = formattedCartTotal22 ;
    document.getElementById("cart-totalThanhtoan1").innerHTML = formattedCartTotal22 + " (bao gồm thuế.)";

</script>

<script>
    $(document).ready(function () {
        $('#province').change(function () {
            var provinceId = $(this).val();
            $.ajax({
                url: 'DistrictServlet',
                type: 'POST',
                data: {
                    province: provinceId
                },
                success: function (response) {
                    var districtSelect = $('#district');
                    districtSelect.empty(); // Xóa tất cả các option hiện có trong select box
                    districtSelect.append('<option value="">Chọn huyện</option>'); // Thêm option mặc định
                    response.forEach(function (district) {
                        districtSelect.append('<option value="' + district.DistrictID + '">' + district.DistrictName + '</option>');
                    });
                },
                error: function () {
                    console.log('Lỗi khi tải danh sách huyện');
                }
            });
        });
    });
</script>

<script>
    $(document).ready(function () {
        $('#district').change(function () {
            // Lấy giá trị đã chọn của select box
            var districtId = $(this).val();
            // Gửi yêu cầu Ajax đến Servlet
            $.ajax({
                url: 'WardServlet',
                type: 'POST',
                data: {
                    districtId: districtId
                },
                success: function (response) {
                    var wardSelect = $('#ward');
                    wardSelect.empty(); // Xóa tất cả các option hiện có trong select box
                    wardSelect.append('<option value="">Chọn xã</option>'); // Thêm option mặc định
                    response.forEach(function (ward) {
                        wardSelect.append('<option value="' + ward.WardCode + '">' + ward.WardName + '</option>');
                    });
                },
                error: function () {
                    console.log('Lỗi khi tải danh sách huyện');
                }
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        var province = '';
        var district = '';
        var ward = '';

        // Lấy giá trị của select box Tỉnh
        $('#province').change(function () {
            province = $(this).val();
            $('#district').val('');
            $('#ward').val('');
        });

        // Lấy giá trị của select box Huyện
        $('#district').change(function () {
            district = $(this).val();
            $('#ward').val('');
        });
        // Lưu giá trị ban đầu của cartTotal vào biến tạm thời
        var initialCartTotal = parseInt($('.cart-total .value').text().replace(/[^\d]/g, ''));
        // Lấy giá trị của select box Xã và gửi dữ liệu lên server
        $('#ward').change(function () {
            ward = $(this).val();
            if (province && district && ward && province.trim() !== '' && district.trim() !== '' && ward.trim() !== '') {
                $.ajax({
                    type: "POST",
                    url: "FeeServlet",
                    data: {
                        province: province,
                        district: district,
                        ward: ward
                    },
                    success: function (result) {
                        var shippingFee = parseInt(result);
                        // Tính toán newCartTotal bằng cách cộng giá trị mới của cartTotal với shippingFee
                        var newCartTotal = initialCartTotal + shippingFee;

                        // Set giá trị cho input
                        $('#shipping-fee-input').val(shippingFee);

                        // Hiển thị giá trị trong span
                        $('#cart-subtotal-shipping .value').text(shippingFee.toLocaleString('vi-VN') + '₫');

                        // Hiển thị giá trị mới của tổng
                        $('.cart-total .value').text(newCartTotal.toLocaleString('vi-VN') + ' ₫ (bao gồm thuế.)');
                    },
                    error: function () {
                        alert('Đã có lỗi xảy ra!');
                    }
                });
            }
        });
    });
</script>
<script>
    $(document).ready(function() {
        $('#province').on('change', function() {
            var provinceId = $(this).val();
            $('#province-id').val(provinceId);
            $('#province-value').val($(this).find("option:selected").text());
        });

        $('#district').on('change', function() {
            var districtId = $(this).val();
            $('#district-id').val(districtId);
            $('#district-value').val($(this).find("option:selected").text());
        });

        $('#ward').on('change', function() {
            var wardCode = $(this).val();
            $('#ward-id').val(wardCode);
            $('#ward-value').val($(this).find("option:selected").text());
        });
    });

</script>


</body>
</html>