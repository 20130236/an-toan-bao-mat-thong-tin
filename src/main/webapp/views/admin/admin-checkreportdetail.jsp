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
<%--        action="<c:url value="/check_reportdetail"/>"--%>
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
                                        <div class="card-body">
                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-6 ">
                                                    <div class="form-group">
                                                        <label>ID </label>
                                                        <div class="input-group date" id="ido"
                                                             data-target-input="nearest">
                                                            <div class="form-control" name ="report_id"><%=report.getReport_id()%>
                                                            </div>
                                                            <input type="hidden" name="report_id"
                                                                   value="<%=report.getReport_id()%>">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 ">
                                                    <label>Tên khách hàng</label>
                                                    <input type="hidden" name="user_name" value="<%=report.getUser_name()%>">
                                                    <div class="form-control" name ="user_name"><%=report.getUser_name()%>
                                                    </div>
                                                </div>
                                            </div>

                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-6 ">
                                                    <div class="form-group">
                                                        <label>Mã khách hàng</label>
                                                        <input type="hidden" name="user_id" value="<%=report.getUser_id()%>">
                                                        <div class="input-group date" id="reservationdate1"
                                                             data-target-input="nearest">
                                                            <div class="form-control" name="user_id"><%=report.getUser_id()%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 ">
                                                    <label>Email:</label>
                                                    <input type="hidden" name="email" value="<%=report.getEmail()%>">
                                                    <div class="form-control" name ="email"><%=report.getEmail()%>
                                                    </div>
                                                </div>
                                            </div>

                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-12 ">
                                                    <div class="form-group">
                                                        <label>Ngày gửi report:</label>
                                                        <input type="hidden" name="date" value="<%=Report.convertDateTime1(report.getDate_report().toString())%>">
                                                        <div class="input-group date" id="reservationdate2"
                                                             data-target-input="nearest">
                                                            <div class="form-control" name = "date"><%=Report.convertDateTime1(report.getDate_report().toString())%>
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
                                                        <input type="hidden" name="detail" value="<%=report.getDetail()%>">
                                                        <div class="input-group date" id="reservationdate"
                                                             data-target-input="nearest">
                                                            <div class="form-control" name="detail"><%=report.getDetail()%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div style="display: flex" class="row">
                                                <div class="form-group col-md-12 ">
                                                    <div class="form-group">
                                                        <label>Ngày gặp vấn đề:</label>
                                                        <input type="hidden" name="date_key" value="<%=Report.convertDateTime1(report.getDate_key().toString())%>">
                                                        <div class="input-group date" id="reservationdate20"
                                                             data-target-input="nearest">
                                                            <div class="form-control" name="date_key"><%=Report.convertDateTime1(report.getDate_key().toString())%>
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
                                        </div>
                                        <!-- /.card-body -->
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
                                                        <option value="0" selected>Chờ phê duyệt</option>
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
                                                    <button type="submit" class="btn btn-primary" id="confirmButton">Xác nhận</button>
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
<script>
    // Khi trang được tải xong
    <%--$(document).ready(function() {--%>
    <%--    // Bắt sự kiện khi nút Xác nhận được nhấn--%>
    <%--    $("#confirmButton").click(function() {--%>
    <%--        // Lấy giá trị của dropdown--%>
    <%--        var reportStatus = "<%= report.getStatus() %>";--%>
    <%--        $('select[name="status"] option[value="' + reportStatus + '"]').prop('selected', true);--%>

    <%--        // Kiểm tra nếu status là 1 (Duyệt yêu cầu)--%>
    <%--        if (reportStatus === "1") {--%>
    <%--            // Gọi hàm xử lý update trạng thái--%>
    <%--            window.location.href = "/admin-access-order";--%>
    <%--        } else {--%>
    <%--            // Nếu status không phải 1, chuyển hướng đến servlet /check_reportdetail--%>
    <%--            window.location.href = "/check_reportdetail";--%>
    <%--        }--%>
    <%--    });--%>

        // Hàm xử lý cập nhật trạng thái
        // function updateLeakKey() {
        //     // Thực hiện AJAX request hoặc gửi dữ liệu đến server theo cách bạn muốn
        //     // Ví dụ: Gửi request đến servlet thông qua AJAX
        //     $.ajax({
        //         type: "POST",
        //         url: "UpdateLeakKeyServlet", // Thay thế bằng URL của servlet của bạn
        //         data: {
        //             user_id: 123,  // Thay thế bằng giá trị thực tế
        //             date_key: "2022-01-01"  // Thay thế bằng giá trị thực tế
        //         },
        //         success: function(response) {
        //             // Xử lý kết quả nếu cần
        //             console.log(response);
        //         },
        //         error: function(error) {
        //             // Xử lý lỗi nếu có
        //             console.error(error);
        //         }
        //     });
        // }
    // });
</script>
</body>
</html>
