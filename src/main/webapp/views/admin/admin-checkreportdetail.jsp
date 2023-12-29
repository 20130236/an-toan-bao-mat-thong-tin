<%@ page import="model.Report" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<% Report report = (Report) request.getAttribute("re");
%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Duyệt report</title>
    <jsp:include page="/common/admin/css.jsp"></jsp:include>
    <style>
        #loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9999;
        }

        .spinner {
            position: absolute;
            top: 50%;
            left: 50%;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 2s linear infinite;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
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
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Duyệt report</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Duyệt report</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
        <form action="<c:url value="/check_reportdetail"/>" method="POST" name="check" id="form_check">
            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">Thông tin report</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse"
                                                title="Collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body" style="display: block; padding:0px ;">
                                    <form>
                                        <div class="card-body">
                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-6 ">
                                                    <div class="form-group">
                                                        <label>ID </label>
                                                        <div class="input-group date" id="ido"
                                                             data-target-input="nearest">
                                                            <div class="form-control"><%=report.getReport_id()%>
                                                            </div>
                                                            <input type="hidden" name="order_id"
                                                                   value="<%=report.getReport_id()%>">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 ">
                                                    <label>Tên khách hàng</label>
                                                    <div class="form-control"><%=report.getFullName(report.getUser_name())%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-6 ">
                                                    <div class="form-group">
                                                        <label>Số điện thoại</label>
                                                        <div class="input-group date" id="reservationdate1"
                                                             data-target-input="nearest">
                                                            <div class="form-control"><%=report.getPhoneNum()%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 ">
                                                    <label>Email:</label>
                                                    <div class="form-control"><%=report.getEmail()%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-12 ">
                                                    <div class="form-group">
                                                        <label>Ngày gửi report:</label>
                                                        <div class="input-group date" id="reservationdate2"
                                                             data-target-input="nearest">
                                                            <div class="form-control"><%=Report.convertDateTime(report.getDate_report().toString())%>
                                                            </div>
                                                            <div class="input-group-append"
                                                                 data-target="#reservationdate"
                                                                 data-toggle="datetimepicker">
                                                                <div class="input-group-text"><i
                                                                        class="fa fa-calendar"></i></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-12 ">
                                                    <div class="form-group">
                                                        <label>Nội dung:</label>
                                                        <div class="input-group date" id="reservationdate"
                                                             data-target-input="nearest">
                                                            <div class="form-control"><%=report.getDetail()%>
                                                            </div>
                                                        </div>s
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <!-- /.card-body -->
                                    </form>
                                </div>
                                <!-- /.card-body -->
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card card-success ">
                                <div class="card-header">
                                    <h3 class="card-title">

                                    </h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body">
                                    <div style="display: flex" class="row">
                                        <div class="form-group col-md-6 ">
                                            <div class="form-group">
                                                <label>Duyệt yêu cầu report</label>
                                                <div class="input-group date" id="reservationdate12"
                                                     data-target-input="nearest">
                                                    <select class="form-control" name="status">
                                                        <option value="" selected>Chọn trạng thái</option>
                                                        <option value="1">Duyệt yêu cầu</option>
                                                        <option value="2">Từ chối yêu cầu</option>
                                                        <option value="4">Đã xử lý</option>
                                                        <option value="3">Đang xử lý</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group col-md-6 ">
                                            <div class="form-group">
                                                <label>&nbsp</label>
                                                <div class="input-group date" id="reservationdate13"
                                                     data-target-input="nearest">
                                                    <button type="submit" class="btn btn-primary">Xác nhận</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.row -->

                </div><!-- /.container-fluid -->

            </section>
        </form>

        <div id="loading-overlay">
            <div class="spinner"></div>
        </div>
        <!-- /.content -->
    </div>
    <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>
    document.getElementById("form_check").addEventListener("submit", function () {
        // Hiển thị lớp phủ
        document.getElementById("loading-overlay").style.display = "block";
    });
</script>
<script>
    $(document).ready(function () {
        var reportStatus = "<%= report.getStatus() %>";
        $('select[name="status"] option[value="' + reportStatus + '"]').prop('selected', true);

        if (!reportStatus == 2) {
            $('select[name="status"] option[value="3"]').hide();
            $('select[name="status"] option[value="1"]').hide();
            $('select[name="status"] option[value="2"]').hide();
            $('select[name="status"] option[value="4"]').hide();
        } else if (reportStatus == 0) {
            $('select[name="status"] option[value="3"]').hide();
            $('select[name="status"] option[value="4"]').hide();

        } else if (reportStatus == 1) {

            $('select[name="status"] option[value="2"]').hide();
            $('select[name="status"] option[value="1"]').hide();
        } else if (reportStatus == 2) {
            $('select[name="status"] option[value="3"]').hide();
            $('select[name="status"] option[value="1"]').hide();
            $('select[name="status"] option[value="2"]').hide();
            $('select[name="status"] option[value="4"]').hide();
        } else if (reportStatus == 4) {
            $('select[name="status"] option[value="3"]').hide();
            $('select[name="status"] option[value="1"]').hide();
            $('select[name="status"] option[value="2"]').hide();
            $('select[name="status"] option[value="4"]').hide();
        }
    });
</script>
</body>
</html>
