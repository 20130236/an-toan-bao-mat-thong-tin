<%@ page import="model.Report" %>
<%@ page import="model.Introduce" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<% Report report = (Report) request.getAttribute("re");
    Introduce introduce = (Introduce) request.getAttribute("info");
%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết report</title>
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
                        <h1>Chi tiết report</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Chi tiết report</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

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

                                    </h4>
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- info row -->
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
                                <!-- /.col -->
                                <div class="col-sm-4 invoice-col">
                                    Khách hàng:
                                    <address>
                                        <strong><%=report.getFullName(report.getUser_name())%>
                                        </strong><br>
                                        Email: <%=report.getEmail()%> <br>
                                        Điện thoại: <%=report.getPhoneNum()%><br>
                                    </address>
                                </div>
                                <!-- /.col -->
                                <div class="col-sm-4 invoice-col">
                                    <b>ID : </b> <%=report.getReport_id()%><br>
                                    <b>Ngày gửi report : </b> <span id="ngay-report"><%=Report.convertDateTime(report.getDate_report().toString())%></span><br>
                                    <script>
                                        var ngayHienTai = document.getElementById("ngay-report").innerHTML;
                                        var ngayMoi = ngayHienTai.split("-").reverse().join("/");
                                        document.getElementById("ngay-report").innerHTML = ngayMoi;
                                    </script>

                                    <b>Trạng thái report:</b> <%=report.statusReport(report.getStatus())%><br>
                                    <b>Yêu cầu:</b> <%=report.getDetail()%><br>
                                    <b>Ngày gặp vấn đề : </b> <span id="ngay-key"><%=Report.convertDateTime(report.getDate_key().toString())%></span><br>
                                    <script>
                                        var ngayHienTai = document.getElementById("ngay-key").innerHTML;
                                        var ngayMoi = ngayHienTai.split("-").reverse().join("/");
                                        document.getElementById("ngay-key").innerHTML = ngayMoi;
                                    </script>
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.invoice -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<!-- ./wrapper -->

<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>

</script>

</body>
</html>
