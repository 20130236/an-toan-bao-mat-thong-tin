<%@ page import="model.UserModel" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.Introduce" %>
<%@ page import="model.Order_detail" %>
<%@ page import="service.API_LOGISTIC.Transport" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    UserModel user = (UserModel) request.getAttribute("user");
    Order order = (Order) request.getAttribute("order");
    Introduce introduce = (Introduce) request.getAttribute("info");
    ArrayList<Order_detail> order_details = (ArrayList<Order_detail>) request.getAttribute("orderDetails");
    Transport transport = (Transport) request.getAttribute("transport");

%>
<html>
<!-- user-acount11:10-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Chi tiết đơn hàng</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <jsp:include page="/common/web/css.jsp"></jsp:include>
    <style>
        .error{
            float: left !important;
            color:#dc3545 !important;
        }
        input[type="radio"]{
            opacity: 0;
            left: 28px;
            position: relative;
            cursor: pointer;
        }

        input[type="radio"]:checked~.design {
            background: #434343;
        }
        .design {
            width: 29px;
            height: 11px;
            border-radius: 50%;
            outline-offset: 3px;
            outline: 2px solid #888888;
            margin-right: 10px;
            margin-top: 5px;
        }

    </style>

</head>

<body class="user-acount">
<jsp:include page="/common/web/header.jsp"></jsp:include>

<!-- main content -->
<div class="wrapper">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <nav class="breadcrumb-bg">
            <div class="container no-index">
                <div class="breadcrumb">
                    <ol>
                        <li>
                            <a href="home">
                                <span>Trang chủ</span>
                            </a>
                        </li>
                        <li>
                            <a href="list_order">
                                <span>Danh sách đơn hàng</span>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
        </nav>
        <!-- Content Header (Page header) -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <!-- Main content -->
                        <div class="invoice p-3 mb-3">
                            <!-- title row -->
                            <div class="row">
                                <div class="col-12">
                                    <h4>
                                      Chi tiết đơn hàng <%=order.getOder_id()%>
                                    </h4>
                                </div>
                            </div>
                            <div class="row invoice-info">
                                <div class="col-sm-4 invoice-col">
                                    Cửa hàng:
                                    <address>
                                        <strong><%=introduce.getName()%>
                                        </strong><br>
                                        Địa chỉ: <%=introduce.getAddress()%> <br>
                                        Điện thoại: <%=introduce.getPhone()%><br>
                                        Email: <%=introduce.getEmail()%>
                                    </address>
                                </div>
                                <div class="col-sm-4 invoice-col">
                                    Khách hàng:
                                    <address>
                                        <strong><%=order.getFullName(order.getUser_name())%>
                                        </strong><br>
                                        Địa chỉ: <%=order.getAddress()%> <br>
                                        Điện thoại: <%=order.getPhoneNum()%><br>
                                    </address>
                                </div>
                                <div class="col-sm-4 invoice-col">
                                    <b>ID hoá đơn : </b> <%=order.getOder_id()%><br>
                                    <b>Ngày lập hoá đơn : </b> <span id="ngay-hoa-don"><%=order.convertDateTime(order.getDate_order().toString())%></span><br>
                                    <script>
                                        var ngayHienTai = document.getElementById("ngay-hoa-don").innerHTML;
                                        var ngayMoi = ngayHienTai.split("-").reverse().join("/");
                                        document.getElementById("ngay-hoa-don").innerHTML = ngayMoi;
                                    </script>
                                    <b>Trạng thái đơn hàng:</b> <%=order.statusOrder(order.getStatus())%><br>
                                    <h5><b>Thông tin vận chuyển</b></h5>
                                    <b>Mã vận chuyển:</b> <%=transport.getId()%><br>
                                    <b>Ngày đăng ký vận chuyển:</b> <%=transport.getCreated_at()%><br>
                                    <b>Ngày giao hàng:</b> <%=transport.getLeadTime()%><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Mã sản phẩm</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <% for (Order_detail o : order_details) { %>
                                        <tr>
                                            <td><%=o.getId_product()%>
                                            </td>
                                            <td><%=o.getName(o.getId_product())%>
                                            </td>
                                            <td><%=o.formatCurrency(o.getPrice())%></td>
                                            <td><%=o.getAmount()%></td>
                                            <td><%=o.formatCurrency(o.getTotal())%></td>
                                        </tr>
                                        <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <!-- accepted payments column -->
                                <div class="col-6">
                                    <p class="lead">Phương thức thanh toán:</p>
                                    <p><%=order.getPayment()%></p>
                                    <p>Hỗ trợ thanh toán qua :</p>
                                    <img src="<c:url value="/Template/admin/dist/img/credit/visa.png"/>" alt="Visa">
                                    <img src=" <c:url value="/Template/admin/dist/img/credit/mastercard.png"/>"
                                         alt="Mastercard">
                                    <img src=" <c:url value="/Template/admin/dist/img/credit/american-express.png"/>"
                                         alt="American Express">
                                    <img src=" <c:url value="/Template/admin/dist/img/credit/paypal2.png"/>"
                                         alt="Paypal">
                                    <div style="background-color: #0000000d;padding: 5px 10px;margin-top: 10px">
                                        <div style="margin-top: 15px;color: red"><strong>Ghi chú của khách hàng
                                            hàng:</strong></div>
                                        <p class="" style="color:black">
                                            <%=order.getNote()%>
                                        </p>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <p class="lead">Thành tiền</p>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <tr>
                                                <th style="width:50%">Tổng tiền sản phẩm:</th>
                                                <td>
                                                    <%=order.formatCurrency(order.getTotal_money())%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Thuế(0%)</th>
                                                <td>0đ</td>
                                            </tr>
                                            <tr>
                                                <th>Phí giao hàng:</th>
                                                <td>
                                                    <%=order.formatCurrency(order.getFee())%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Tổng tiền:</th>
                                                <td>
                                                    <%=order.formatCurrency(order.getTotal_money() + order.getFee())%>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <p class="lead">Chữ ký hoá đơn</p>

                                    <div class="table-responsive">
                                        <table class="table">
                                            <tr>
                                                <th style="width:50%">Chữ ký xác nhận :</th>
                                                <td>
                                                    <%=order.getDigitalSignature()%>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="row no-print">
            <div class="col-12">
                <a href="#" rel="noopener" target="_blank" class="btn btn-default" onclick="printInvoice()"><i class="fas fa-print"></i> In hoá đơn</a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/web/footer.jsp"></jsp:include>
<jsp:include page="/common/web/js.jsp"></jsp:include>
<script>
    function printInvoice() {
        var divContents = document.querySelector(".content").innerHTML;
        var a = window.open('', '', 'height=500, width=500');
        a.document.write('<html>');
        a.document.write('<body > ');
        a.document.write(divContents);
        a.document.write('</body></html>');
        a.document.close();
        a.print();
    }
</script>

</body>
</html>