<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách đơn hàng cần duyệt</title>
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
                        <h1>Danh sách đơn hàng cần duyệt</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">Danh sách đơn hàng cần duyệt</li>
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
                            <!-- /.card-header -->
                            <div class="card-body">
                                <c:if test="${ messageResponse != null}">
                                    <div class="alert-${alert}" style="width: 36%;">${messageResponse}</div>
                                </c:if>
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Mã đơn hàng</th>
                                        <th>Username</th>
                                        <th>Ngày lập</th>
                                        <th>Tình trạng</th>
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
                                        <td><%=Order.convertDateTime(o.getDate_order().toString())%>
                                        </td>
                                        <td><%=o.statusOrder(o.getStatus())%>
                                        </td>
                                        <td>
                                            <button class="btn btn-info"><a class="check_detail" href="<c:url value="/check_detail?id="></c:url><%=o.getOder_id()%>"
                                                                            style="color:white">Duyệt đơn hàng</a></button>
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
    if (!checkPm) {
        $(".check_detail").attr("href", "#")
    }
    $(".btn-info").click(function (e) {
        if (!checkPm) {
            alert("you dont have permission!")
            e.preventDefault();
        }
    })

</script>
</body>
</html>