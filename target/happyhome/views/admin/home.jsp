<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ</title>
    <jsp:include page="/common/admin/css.jsp"></jsp:include>
    <!-- CSS Files -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-datepicker@1.9.0/dist/css/bootstrap-datepicker.min.css">
    <style>
        .active{
            background-color: rgba(255,255,255,.1)!important;
            color: #fff!important;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <!-- Navbar -->
    <jsp:include page="/common/admin/header.jsp"></jsp:include>
    <!-- /.navbar -->

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0" id="result">Bảng thống kế tình hình bán hàng</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="thongke-option" id="radio-thang" checked>
                            <label class="form-check-label" for="radio-thang">Thống kê theo tháng</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="thongke-option" id="radio-ngay" >
                            <label class="form-check-label" for="radio-ngay">Thống kê theo ngày</label>
                        </div>

                    </div>
                </div>

                <div class="col-sm-2" id="datepicker-container-m" style="display: block;">
                    <label for="datepicker">Chọn tháng và năm:</label>
                    <div class="input-group date">
                        <input type="text" id="datepicker-month" class="form-control">
                        <div class="input-group-append">
                            <button id="btn-xem-thang" class="btn btn-primary">Xem</button>
                        </div>
                    </div>
                </div>

                <div id="result-container-m" style="display: none;">
                    <div class="row">
                        <div class="col-sm-12">
                        </div>
                    </div>
                </div>


                <div id="datepicker-container" style="display: none;">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="form-group d-sm-inline-block">
                                <label for="datepicker">Chọn ngày:</label>
                                <div class="input-group date">
                                    <input type="text" id="datepicker" class="form-control">
                                    <div class="input-group-append">
                                        <button id="btn-xem" class="btn btn-primary">Xem</button>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <div id="result-container" style="display: none;">
                    <div class="row">
                        <div class="col-sm-12">

                        </div>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </div>

        <!-- /.content-header -->

        <!-- Main content -->
        <div class="content">
            <h3 class="text-center">Thống kê tổng quan</h3>
            <div class="container-fluid py-4">
                <div class="row">
                    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <h2>Doanh thu</h2>
                                <div class="text-end pt-1">
                                    <h4 class="mb-0" id="doanhthuthang"> </h4>
                                    <p class="text-danger">Tính theo giá trị đơn hàng</p>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0"><span class="text-success text-sm font-weight-bolder">Xem chi tiết</span></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <h2>Số lượng đơn hàng</h2>
                                <div class="text-end pt-1">
                                    <h4 class="mb-0" id="donhangthang"></h4>
                                    <p class="text-danger">Dựa vào số đơn hàng đã đặt</p>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0"><span class="text-success text-sm font-weight-bolder">Xem chi tiết</span></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <h2>Số lượng sản phẩm đã bán</h2>
                                <div class="text-end pt-1">
                                    <h4 class="mb-0" id="sanphamthang"></h4>
                                    <p class="text-danger">Theo số lượng sản phẩm của đơn hàng</p>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0"><span class="text-success text-sm font-weight-bolder">Xem chi tiết</span></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-sm-6">
                        <div class="card">
                            <div class="card-header p-3 pt-2">
                                <h2>Đơn hàng đang vận chuyển</h2>
                                <div class="text-end pt-1">
                                    <h4 class="mb-0" id="vanchuyenthang"></h4>
                                    <p class="text-danger">Theo trạng thái vận chuyển</p>
                                </div>
                            </div>
                            <hr class="dark horizontal my-0">
                            <div class="card-footer p-3">
                                <p class="mb-0"><span class="text-success text-sm font-weight-bolder">Xem chi tiết</span></p>
                            </div>
                        </div>
                    </div>
                </div>
                <h3 class="text-center">Thống kê chi tiết</h3>
                        <div class="row mb-3">
                         <div class="col-lg-8 col-md-6 mb-md-0 mb-4">
                        <div class="card">
                            <div class="card-header pb-0">
                                <div class="row">
                                    <div class="col-lg-6 col-5">
                                        <h5>Đơn hàng gần đây</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="table">
                                <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
                                    <table class="table align-items-center mb-0">
                                        <tr>
                                            <th class="text-uppercase">Mã đơn hàng</th>
                                            <th class="text-uppercase">Tên khách hàng</th>
                                            <th class="text-uppercase">Số điện thoại</th>
                                            <th class="text-uppercase">Ngày đặt</th>
                                            <th class="text-uppercase">Tổng tiền</th>
                                        </tr>
                                        </thead>
                                        <tbody id="orderTableBody">
                                         </tbody>
                            </table>
                        </div>
                    </div>
                         </div>
                        <div class="card">
                        <div class="card-header pb-0">
                            <div class="row">
                                <div class="col-lg-6 col-5">
                                    <h5>Sản phẩm bán chạy</h5>
                                </div>
                            </div>
                        </div>
                            <div class="table">
                                <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
                                    <table class="table align-items-center mb-0">
                                    <thead>
                                    <tr>
                                        <th class="text-uppercase">Tên sản phẩm</th>
                                        <th class="text-uppercase">Giá bán ra</th>
                                        <th class="text-uppercase">Số lượng đã bán</th>
                                        <th class="text-uppercase">Chi tiết</th>
                                    </tr>
                                    </thead>
                                    <tbody id="productTableBody">
                                    <!-- Các sản phẩm sẽ được thêm vào đây -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-80">
                                    <div class="card-header pb-0">
                                        <h5>Tổng sản phẩm đã nhập</h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <div class="table">
                                            <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
                                                <table class="table align-items-center mb-0">
                                                    <thead>
                                                    <tr>
                                                        <th class="text-uppercase">Tên sản phẩm</th>
                                                        <th class="text-uppercase">Số lượng</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody id="importTableBody">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
            </div>
            </div>
        </div>
    </div>
    <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<!-- REQUIRED SCRIPTS -->
<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-datepicker@1.9.0/dist/js/bootstrap-datepicker.min.js"></script>
<script>
    $(document).ready(function() {
        $('input[name="thongke-option"]').change(function() {
            if ($(this).attr('id') === 'radio-ngay') {
                $('#datepicker-container').show();
                $('#result-container').hide();
                // Đặt giá trị mặc định cho result-thang
                var defaultResult = 'Thông tin thống kê ngày';
                var defaultValue = '0';
                $('#result').text(defaultResult);
                $('#doanhthuthang').text(defaultValue);
                $('#sanphamthang').text(defaultValue);
                $('#donhangthang').text(defaultValue);
                $('#vanchuyenthang').text(defaultValue);
                $('#orderTableBody').empty();
                $('#productTableBody').empty();
                $('#importTableBody').empty();
            } else {
                $('#datepicker-container').hide();
                $('#result-container').hide();
            }
        });

        $('#datepicker').datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true,
            todayHighlight: true
        });

        $('#btn-xem').click(function() {
            var selectedDate = $('#datepicker').val();
            // Simulate fetching data from server based on selected date
            var result = 'Thông tin thống kê cho ngày ' + selectedDate;
            $('#result').text(result);
            $('#result-container').show();
            //ajax
            $.ajax({
                type: 'GET',
                url: 'day_analysis',
                data: { selectedDate: selectedDate },
                dataType: 'json',
                success: function(response) {
                    // Xử lý dữ liệu doanh thu
                    var result = response.resultDay;
                    var formattedResult = Number(result).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
                    $('#doanhthuthang').text(formattedResult);
                    //xử lý dữ liệu đơn hàng
                    var order = response.orderNumDay;
                    $('#donhangthang').text(order);
                    //xử lý dữ liệu sản phẩm
                    var product = response.productNumDay;
                    $('#sanphamthang').text(product);
                    //xử lý dữ liệu vận chuyển
                    var ship = response.orderNumShippingDay;
                    $('#vanchuyenthang').text(ship);
                    //xử lý sản phẩm bán chạy
                    var productTableBody = $('#productTableBody');
                    productTableBody.empty();
                    for (var i = 0; i < response.productsDay.length; i++) {
                        var product = response.productsDay[i];
                        var productName = product.name;
                        var productImageSrc = product.image;
                        var productPrice = product.price;
                        var productQuantitySold = product.amountSell;
                        var productRow = $('<tr>');
                        var productImage = $('<img>').attr('src', productImageSrc).addClass('avatar avatar-sm me-3').css({height: '50px', width: '50px', borderRadius: '50%'});
                        var productNameElement = $('<h6>').addClass('mb-xl-0').css('padding-left', '10px').text(productName);
                        var productInfoDiv = $('<div>').addClass('d-flex flex-column justify-content-center').append(productNameElement);
                        var productDetailsDiv = $('<div>').addClass('d-flex px-2 py-1').append($('<div>').append(productImage), productInfoDiv);
                        var productDetailsColumn = $('<td>').append(productDetailsDiv);
                        var productPriceColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productPrice));
                        var productQuantitySoldColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productQuantitySold));
                        var productDetailLinkColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').append($('<i>').addClass('fa fa-eye').attr('aria-hidden', 'true')));
                        productRow.append(productDetailsColumn, productPriceColumn, productQuantitySoldColumn, productDetailLinkColumn);
                        productTableBody.append(productRow);
                    }
                    var orderTableBody = $('#orderTableBody');
                    orderTableBody.empty();
                    for (var j = 0; j < response.ordersDay.length; j++) {
                        var order = response.ordersDay[j];
                        var id = order.id;
                        var name = order.name;
                        var phone = order.phone;
                        var date = order.date;
                        var totalMoney = order.totalMoney;
                        var row = $('<tr>');
                        var idColumn = $('<td>').html('<div class="d-flex"><h6 class="mb-xl-0">' + id + '</h6></div>');
                        var nameColumn = $('<td>').html('<h6 class="mb-xl-0">' + name + '</h6>');
                        var phoneColumn = $('<td>').html('<h6 class="mb-xl-0">' + phone + '</h6>');
                        var dateColumn = $('<td>').html('<h6 class="mb-xl-0">' + date + '</h6>');
                        var totalMoneyColumn = $('<td>').html('<h6 class="mb-xl-0">' + totalMoney + '</h6>');
                        row.append(idColumn);
                        row.append(nameColumn);
                        row.append(phoneColumn);
                        row.append(dateColumn);
                        row.append(totalMoneyColumn);
                        orderTableBody.append(row);
                    }
                    //Xử lý nhập hàng
                    var importTableBody = $('#importTableBody');

                    // Xóa bỏ các sản phẩm hiện có trong <tbody>
                    importTableBody.empty();

                    // Lặp qua danh sách sản phẩm
                    for (var h = 0; h < response.importProductDay.length; h++) {
                        var producti = response.importProductDay[h];
                        var productNamei = producti.name;
                        var productImageSrci = producti.image;
                        var productQuantitySoldi = producti.amountSell;

                        // Tạo các thành phần HTML cho mỗi sản phẩm
                        var productRowi = $('<tr>');
                        var productImagei = $('<img>').attr('src', productImageSrci).addClass('avatar avatar-sm me-3').css({
                            height: '50px',
                            width: '50px',
                            borderRadius: '50%'
                        });
                        var productNameElementi = $('<h6>').addClass('mb-xl-0').css('padding-left', '10px').text(productNamei);
                        var productInfoDivi = $('<div>').addClass('d-flex flex-column justify-content-center').append(productNameElementi);
                        var productDetailsDivi = $('<div>').addClass('d-flex px-2 py-1').append($('<div>').append(productImagei), productInfoDivi);
                        var productDetailsColumni = $('<td>').append(productDetailsDivi);
                        var productQuantitySoldColumni = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productQuantitySoldi));


                        // Thêm các thành phần vào hàng sản phẩm
                        productRowi.append(productDetailsColumni, productQuantitySoldColumni);

                        // Thêm hàng sản phẩm vào <tbody>
                        importTableBody.append(productRowi);

                   }

                },
                error: function(xhr, status, error) {
                    // Xử lý lỗi (nếu có)
                }
            });
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-datepicker@1.9.0/dist/js/bootstrap-datepicker.min.js"></script>
<script>
    $(document).ready(function() {
        $("#datepicker").datepicker({
            format: "dd/mm/yyyy", // Định dạng hiển thị ngày tháng
            autoclose: true, // Tự động đóng datepicker khi chọn ngày
            todayBtn: "linked", // Nút "Today" liên kết với ngày hôm nay
            clearBtn: true, // Hiển thị nút "Clear" để xóa ngày đã chọn
            language: "vi", // Ngôn ngữ hiển thị (có thể thay đổi thành mã ngôn ngữ khác)
            container: "#datepicker-container", // Định vị datepicker trong container có ID "datepicker-container"
        });
    });

</script>
<script>
    $(document).ready(function() {
        // Đặt radio-thang là checked mặc định
        $('#radio-thang').prop('checked', true);
        // Lấy tháng và năm hiện tại
        var currentDate = new Date();
        var currentMonth = currentDate.getMonth() + 1;
        var currentYear = currentDate.getFullYear();

        // Đặt giá trị mặc định cho datepicker
        $('#datepicker-month').val(currentMonth + '/' + currentYear);

        // Đặt giá trị mặc định cho result-thang
        var defaultResult = 'Thông tin thống kê tháng ' + currentMonth + '/' + currentYear;
        $('#result').text(defaultResult);

        $('input[name="thongke-option"]').change(function() {
            if ($(this).attr('id') === 'radio-thang') {
                $('#datepicker-container-m').show();
                $('#result-container-m').hide();
                $('#result').text(defaultResult);
            } else {
                $('#datepicker-container-m').hide();
                $('#result-container-m').hide();
            }
        });

        $('#datepicker-month').datepicker({
            format: 'mm/yyyy',
            autoclose: true,
            minViewMode: 'months'
        });
        // Tạo sự kiện onchange cho select month
        $('#btn-xem-thang').click(function() {
            var selectedMonth = $('#datepicker-month').val();
            $('#result').text('Thông tin thống kê tháng ' + selectedMonth);

            // Gửi giá trị selectedMonth đến servlet bằng Ajax
            $.ajax({
                type: 'GET',
                url: 'month_analysis',
                data: { selectedMonth: selectedMonth },
                dataType: 'json',
                success: function(response) {
                    // Xử lý dữ liệu doanh thu
                    var result = response.result;
                    var formattedResult = Number(result).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
                    $('#doanhthuthang').text(formattedResult);
                    //xử lý dữ liệu đơn hàng
                    var order = response.orderNum;
                    $('#donhangthang').text(order);
                    //xử lý dữ liệu sản phẩm
                    var product = response.productNum;
                    $('#sanphamthang').text(product);
                    //xử lý dữ liệu vận chuyển
                    var ship = response.orderNumShipping;
                    $('#vanchuyenthang').text(ship);
                    //xử lý sản phẩm bán chạy
                    var productTableBody = $('#productTableBody');
                    productTableBody.empty();
                    for (var i = 0; i < response.products.length; i++) {
                        var product = response.products[i];
                        var productName = product.name;
                        var productImageSrc = product.image;
                        var productPrice = product.price;
                        var productQuantitySold = product.amountSell;
                        var productRow = $('<tr>');
                        var productImage = $('<img>').attr('src', productImageSrc).addClass('avatar avatar-sm me-3').css({height: '50px', width: '50px', borderRadius: '50%'});
                        var productNameElement = $('<h6>').addClass('mb-xl-0').css('padding-left', '10px').text(productName);
                        var productInfoDiv = $('<div>').addClass('d-flex flex-column justify-content-center').append(productNameElement);
                        var productDetailsDiv = $('<div>').addClass('d-flex px-2 py-1').append($('<div>').append(productImage), productInfoDiv);
                        var productDetailsColumn = $('<td>').append(productDetailsDiv);
                        var productPriceColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productPrice));
                        var productQuantitySoldColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productQuantitySold));
                        var productDetailLinkColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').append($('<i>').addClass('fa fa-eye').attr('aria-hidden', 'true')));
                        productRow.append(productDetailsColumn, productPriceColumn, productQuantitySoldColumn, productDetailLinkColumn);
                        productTableBody.append(productRow);
                    }
                    var orderTableBody = $('#orderTableBody');
                    orderTableBody.empty();
                    for (var j = 0; j < response.orders.length; j++) {
                        var order = response.orders[j];
                        var id = order.id;
                        var name = order.name;
                        var phone = order.phone;
                        var date = order.date;
                        var totalMoney = order.totalMoney;
                        var row = $('<tr>');
                        var idColumn = $('<td>').html('<div class="d-flex"><h6 class="mb-xl-0">' + id + '</h6></div>');
                        var nameColumn = $('<td>').html('<h6 class="mb-xl-0">' + name + '</h6>');
                        var phoneColumn = $('<td>').html('<h6 class="mb-xl-0">' + phone + '</h6>');
                        var dateColumn = $('<td>').html('<h6 class="mb-xl-0">' + date + '</h6>');
                        var totalMoneyColumn = $('<td>').html('<h6 class="mb-xl-0">' + totalMoney + '</h6>');
                        row.append(idColumn);
                        row.append(nameColumn);
                        row.append(phoneColumn);
                        row.append(dateColumn);
                        row.append(totalMoneyColumn);
                        orderTableBody.append(row);
                    }
                    //Xử lý nhập hàng
                    var importTableBody = $('#importTableBody');

                    // Xóa bỏ các sản phẩm hiện có trong <tbody>
                    importTableBody.empty();

                    // Lặp qua danh sách sản phẩm
                    for (var h = 0; h < response.importProduct.length; h++) {
                        var producti = response.importProduct[h];
                        var productNamei = producti.name;
                        var productImageSrci = producti.image;
                        var productQuantitySoldi = producti.amountSell;

                        // Tạo các thành phần HTML cho mỗi sản phẩm
                        var productRowi = $('<tr>');
                        var productImagei = $('<img>').attr('src', productImageSrci).addClass('avatar avatar-sm me-3').css({
                            height: '50px',
                            width: '50px',
                            borderRadius: '50%'
                        });
                        var productNameElementi = $('<h6>').addClass('mb-xl-0').css('padding-left', '10px').text(productNamei);
                        var productInfoDivi = $('<div>').addClass('d-flex flex-column justify-content-center').append(productNameElementi);
                        var productDetailsDivi = $('<div>').addClass('d-flex px-2 py-1').append($('<div>').append(productImagei), productInfoDivi);
                        var productDetailsColumni = $('<td>').append(productDetailsDivi);
                        var productQuantitySoldColumni = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productQuantitySoldi));


                        // Thêm các thành phần vào hàng sản phẩm
                        productRowi.append(productDetailsColumni, productQuantitySoldColumni);

                        // Thêm hàng sản phẩm vào <tbody>
                        importTableBody.append(productRowi);

                    }

                },
                error: function(xhr, status, error) {
                    // Xử lý lỗi (nếu có)
                }
            });
        });
// Tự động truyền giá trị ban đầu của select month khi trang được tải
        $(document).ready(function() {
            var selectedMonth = $('#datepicker-month').val();
            $('#result').text('Thông tin thống kê tháng ' + selectedMonth);

            // Gửi giá trị selectedMonth đến servlet bằng Ajax
            $.ajax({
                type: 'GET',
                url: 'month_analysis',
                data: { selectedMonth: selectedMonth },
                dataType: 'json',
                success: function(response) {
                    // Xử lý dữ liệu doanh thu
                    var result = response.result;
                    var formattedResult = Number(result).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
                    $('#doanhthuthang').text(formattedResult);
                    //xử lý dữ liệu đơn hàng
                    var order = response.orderNum;
                    $('#donhangthang').text(order);
                    //xử lý dữ liệu sản phẩm
                    var product = response.productNum;
                    $('#sanphamthang').text(product);
                    //xử lý dữ liệu vận chuyển
                    var ship = response.orderNumShipping;
                    $('#vanchuyenthang').text(ship);
                    //xử lý sản phẩm bán chạy
                    var productTableBody = $('#productTableBody');
                    productTableBody.empty();
                    for (var i = 0; i < response.products.length; i++) {
                        var product = response.products[i];
                        var productName = product.name;
                        var productImageSrc = product.image;
                        var productPrice = product.price;
                        var productQuantitySold = product.amountSell;
                        var productURL = product.url;
                        var productRow = $('<tr>');
                        var productImage = $('<img>').attr('src', productImageSrc).addClass('avatar avatar-sm me-3').css({height: '50px', width: '50px', borderRadius: '50%'});
                        var productNameElement = $('<h6>').addClass('mb-xl-0').css('padding-left', '10px').text(productName);
                        var productInfoDiv = $('<div>').addClass('d-flex flex-column justify-content-center').append(productNameElement);
                        var productDetailsDiv = $('<div>').addClass('d-flex px-2 py-1').append($('<div>').append(productImage), productInfoDiv);
                        var productDetailsColumn = $('<td>').append(productDetailsDiv);
                        var productPriceColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productPrice));
                        var productQuantitySoldColumn = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productQuantitySold));
                        var productDetailLinkColumn = $('<td>').addClass('align-middle text-sm').append(
                            $('<h6>').addClass('mb-xl-0').append(
                                $('<a>').attr('href', productURL).append(
                                    $('<i>').addClass('fa fa-eye').attr('aria-hidden', 'true')
                                )
                            )
                        );
                        productRow.append(productDetailsColumn, productPriceColumn, productQuantitySoldColumn, productDetailLinkColumn);
                        productTableBody.append(productRow);
                    }
                    // Xử lý đơn hàng
                    var orderTableBody = $('#orderTableBody');
                    orderTableBody.empty();
                    for (var j = 0; j < response.orders.length; j++) {
                        var order = response.orders[j];
                        var id = order.id;
                        var name = order.name;
                        var phone = order.phone;
                        var date = order.date;
                        var totalMoney = order.totalMoney;
                        var row = $('<tr>');
                        var idColumn = $('<td>').html('<div class="d-flex"><h6 class="mb-xl-0">' + id + '</h6></div>');
                        var nameColumn = $('<td>').html('<h6 class="mb-xl-0">' + name + '</h6>');
                        var phoneColumn = $('<td>').html('<h6 class="mb-xl-0">' + phone + '</h6>');
                        var dateColumn = $('<td>').html('<h6 class="mb-xl-0">' + date + '</h6>');
                        var totalMoneyColumn = $('<td>').html('<h6 class="mb-xl-0">' + totalMoney + '</h6>');
                        row.append(idColumn);
                        row.append(nameColumn);
                        row.append(phoneColumn);
                        row.append(dateColumn);
                        row.append(totalMoneyColumn);
                        orderTableBody.append(row);
                    }
                    //Xử lý nhập hàng
                    var importTableBody = $('#importTableBody');
                    importTableBody.empty();
                    for (var h = 0; h < response.importProduct.length; h++) {
                        var producti = response.importProduct[h];
                        var productNamei = producti.name;
                        var productImageSrci = producti.image;
                        var productQuantitySoldi = producti.amountSell;
                        var productRowi = $('<tr>');
                        var productImagei = $('<img>').attr('src', productImageSrci).addClass('avatar avatar-sm me-3').css({height: '50px', width: '50px', borderRadius: '50%'});
                        var productNameElementi = $('<h6>').addClass('mb-xl-0').css('padding-left', '10px').text(productNamei);
                        var productInfoDivi = $('<div>').addClass('d-flex flex-column justify-content-center').append(productNameElementi);
                        var productDetailsDivi = $('<div>').addClass('d-flex px-2 py-1').append($('<div>').append(productImagei), productInfoDivi);
                        var productDetailsColumni = $('<td>').append(productDetailsDivi);
                        var productQuantitySoldColumni = $('<td>').addClass('align-middle text-sm').append($('<h6>').addClass('mb-xl-0').text(productQuantitySoldi));
                        productRowi.append(productDetailsColumni, productQuantitySoldColumni);
                        importTableBody.append(productRowi);
                    }
                },
                error: function(xhr, status, error) {
                    // Xử lý lỗi (nếu có)
                }
            });
        });


    });

</script>
</body>
</html>

