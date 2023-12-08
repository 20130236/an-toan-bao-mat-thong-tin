<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="digitalsignature.CheckOrders" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách đơn hàng</title>
    <jsp:include page="/common/admin/css.jsp"></jsp:include>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <!-- Navbar -->
    <jsp:include page="/common/admin/header.jsp"></jsp:include>
    <!-- /.navbar -->

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Kiểm tra đơn hàng hợp lệ</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">Kiểm tra đơn hàng hợp lệ</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <button id="duyet-btn" class="btn btn-info" style="float: right; margin-right: 10px" onclick="redirectToServlet1()">Duyệt đơn hàng</button>
                            </div>

                            <!-- /.card-header -->
                            <div class="card-body">
                                <c:if test="${ messageResponse != null}">
                                    <div class="alert-${alert}" style="width: 36%;">${messageResponse}</div>
                                </c:if>
                                <table id="example1" class="table table-bordered table-striped">

                                    <thead>
                                    <tr>
                                        <th>Mã đơn hàng</th>
                                        <th>Khách hàng</th>
                                        <th>Ngày tạo đơn hàng</th>
                                        <th>Tổng tiền</th>
                                        <th>Hình thức thanh toán</th>
                                        <th>Đơn hàng hợp lệ</th>
                                        <th>Trạng thái đơn hàng</th>
                                        <th>Tác vụ</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% List<Order> list = (List<Order>) request.getAttribute("listOrders");
                                        for (Order o : list) {
                                    %>
                                    <tr>
                                        <td><%=o.getOder_id()%>
                                        </td>
                                        <td><%=o.getUser_name()%>
                                        </td>
                                        <td><%=Order.convertDateTime(o.getDate_order().toString())%></td>
                                        <td><%=o.formatCurrency(o.getTotal_money())%></td>
                                        <td><%=o.getPayment()%></td>
                                        <td>
                                            <% if (CheckOrders.checkOrderIsNotChange(o.getOder_id())) { %>
                                            <span class="badge badge-primary">Đơn hàng không bị chỉnh sửa</span>
                                            <% } else{ %>

                                            <span class="badge badge-warning">Đơn hàng bị chỉnh sửa</span>
                                            <% } %>
                                        </td>
                                        <td><%=o.statusOrder(o.getStatus())%></td>
                                        <td>
                                            <button class="btn btn-info"><a class="order_detail" href="<c:url value="/order_detail?id="></c:url><%=o.getOder_id()%>"
                                                                            style="color:white">Chi tiết</a></button>
                                            <button class="btn btn-success"><a class="check_detail" href="<c:url value="/check_detail?id="></c:url><%=o.getOder_id()%>" style="color:white">Sửa</a></button>
                                            <button class="btn btn-danger">Xoá</button>
                                        </td>
                                            <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<!-- ./wrapper -->

<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>
    var checkPm = ${checkPm};
    var detailPm = ${detailPm};

    if (!checkPm) {
        $(".order_detail").attr("href", "#")
    }
    if (!detailPm) {
        $(".check_detail").attr("href", "#")
    }

    $(".btn-success").click(function (e) {
        if (!checkPm) {
            alert("you dont have permission!")
            e.preventDefault();
        }
    })

    $(".btn-info").click(function (e) {
        if (!detailPm) {
            alert("you dont have permission!")
            e.preventDefault();
        }
    })
</script>
<script>
    function redirectToServlet1() {
        // Lấy URL được tạo bởi JSTL
        var servletUrl = '<c:url value="/admin-check_order"/>';

        // Chuyển hướng đến servlet khi nút được nhấn
        window.location.href = servletUrl;
    }
</script>
</body>
</html>