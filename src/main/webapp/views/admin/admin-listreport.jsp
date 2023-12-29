<%@ page import="java.util.List" %>
<%@ page import="model.Report" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách Report</title>
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
                        <h1>Danh sách report</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active"><a href="<c:url value="/admin-listreport_controller"/>">Danh sách report</a></li>
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
                                        <th>Mã khách hàng</th>
                                        <th>Khách hàng</th>
                                        <th>Email</th>
                                        <th>Mã report</th>
                                        <th>Ngày gửi report</th>
                                        <th>Nội dung</th>
                                        <th>Trạng thái report</th>
                                        <th>Tác vụ</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% List<Report> list = (List<Report>) request.getAttribute("re");
                                        for (Report r : list) {
                                    %>
                                    <tr>
                                        <td><%=r.getUser_id()%>
                                        </td>
                                        <td><%=r.getUser_name()%>
                                        </td>
                                        <td><%=r.getEmail()%></td>
                                        <td><%=r.getReport_id()%></td>
                                        <td><%=Report.convertDateTime(r.getDate_report().toString())%></td>
                                        <td><%=r.getDetail()%></td>
                                        <td><%=r.statusReport(r.getStatus())%></td>
                                        <td>
                                            <button class="btn btn-info"><a class="report_detail" href="<c:url value="/report_detail?id="></c:url><%=r.getReport_id()%>"
                                                                            style="color:white">Chi tiết</a></button>
                                            <button class="btn btn-success"><a class="check_detail" href="<c:url value="/check_reportdetail?id="></c:url><%=r.getReport_id()%>" style="color:white">Sửa</a></button>
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

    <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<!-- ./wrapper -->

<jsp:include page="/common/admin/js.jsp"></jsp:include>

<script>
    var checkPm = ${checkPm};
    var detailPm = ${detailPm};

    if (!checkPm) {
        $(".report_detail").attr("href", "#")
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

</body>
</html>
