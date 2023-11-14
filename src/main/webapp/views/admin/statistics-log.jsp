<%@ page import="model.LogStatistics" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<LogStatistics> logsToday = (List<LogStatistics>) request.getAttribute("logsToDay");
    List<LogStatistics> logsThisMonth = (List<LogStatistics>) request.getAttribute("logsThisMonth");
    //List<LogStatistics> logsIpAddress = (List<LogStatistics>) request.getAttribute("logsIpAddress");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>thống kê log</title>
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
                        <h1>Thống kê log</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Thống kê log</li>
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
                        <div class="card card-primary">
                            <div class="card-header" style="margin-top: 10px;margin-bottom: -10px"></div>
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="form-group">
                                    <%--<label>Date and time:</label>
                                    <div class="input-group date" id="reservationdatetime" data-target-input="nearest">
                                        <input id="log-date" type="text" class="form-control datetimepicker-input" data-target="#reservationdatetime">
                                        <div class="input-group-append" data-target="#reservationdatetime" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>--%>
                                    <canvas id="LogsDay" style="width:100%;max-width:600px"></canvas>
                                </div>
                                <div class="form-group">
                                   <%-- <label>Date and time range:</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="far fa-clock"></i></span>
                                        </div>
                                        <input id="log-from-to" name="datetime" type="text" class="form-control float-right" id="reservationtime">
                                    </div>--%>
                                    <!-- /.input group -->
                                    <canvas id="LogsFromTo" style="width:100%;max-width:600px"></canvas>
                                </div>
                               <%-- <div class="form-group">
                                    <label>IP mask:</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-laptop"></i></span>
                                        </div>
                                        <input id="log-ip-address" name="ip-address" type="text" class="form-control" data-inputmask="'alias': 'ip'" data-mask="" inputmode="decimal">
                                    </div>
                                    <!-- /.input group -->
                                    <canvas id="LogsIpAddress" style="width:100%;max-width:600px"></canvas>
                                </div>
                                <canvas id="myChart" style="width:100%;max-width:600px"></canvas>--%>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- modal -->
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

    $(function () {

    var toDayXValues = [];
    var toDayYValues = [];
    var barColors = ["red", "green","blue","orange","brown",'gray','pink','grey'];

        <% for (LogStatistics l : logsToday) {%>
                toDayXValues.push('<%=l.getUsername()%>');
                toDayYValues.push('<%=l.getNum0fId()%>');
        <% } %>
            new Chart("LogsDay", {
                type: "pie",
                data: {
                    labels: toDayXValues,
                    datasets: [{
                        backgroundColor: barColors,
                        data: toDayYValues
                    }]
                },
                options: {
                    legend: {display: false},
                    title: {
                        display: true,
                        text: (toDayXValues.length < 1)?"không có dữ liêu":"Tổng số hoạt động của user theo ngày",
                    }
                }
            });

 /*   $("#log-date").change(function(e) {
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var urlAction = "/statistics-log";
        var data = "day=" +  $(this).value;
        $.ajax({
            type: "POST",
            url: urlAction,
            data: data,
            success: function (result) {
                alert("statistics success");
                toDayXValues = [];
                toDayYValues = [];
                //for(let i = 0 ; i < result[''])
                new Chart("LogsDay", {
                    type: "pie",
                    data: {
                        labels: toDayXValues,
                        datasets: [{
                            backgroundColor: barColors,
                            data: toDayYValues
                        }]
                    },
                    options: {
                        legend: {display: false},
                        title: {
                            display: true,
                            text: (toDayXValues.length < 1)?"không có dữ liêu":"Tổng số hoạt động của user theo ngày",
                        }
                    }
                });
            },
            error : function () {
                alert("error");
            }
        });
    });*/

        var fromToXValues = [];
        var fromToYValues = [];

        <% for (LogStatistics l : logsThisMonth) {%>
        fromToXValues.push('<%=l.getUsername()%>');
        fromToYValues.push('<%=l.getNum0fId()%>');
        <% } %>
        new Chart("LogsFromTo", {
            type: "pie",
            data: {
                labels: fromToXValues,
                datasets: [{
                    backgroundColor: barColors,
                    data: fromToYValues
                }]
            },
            options: {
                legend: {display: false},
                title: {
                    display: true,
                    text: (fromToXValues.length < 1)?"không có dữ liêu":"Tổng số hoạt động của user trong 1 tháng",
                }
            }
        });




  /*  $('#reservationdate').datetimepicker({
        format: 'L'
    });

    //Date and time picker
    $('#reservationdatetime').datetimepicker({ icons: { time: 'far fa-clock' } });

    //Date range picker
    $('#reservation').daterangepicker();
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({
        timePicker: true,
        timePickerIncrement: 30,
        locale: {
            format: 'MM/DD/YYYY hh:mm A'
        }
    });

        //Date range as a button
        $('#daterange-btn').daterangepicker(
            {
                ranges  : {
                    'Today'       : [moment(), moment()],
                    'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month'  : [moment().startOf('month'), moment().endOf('month')],
                    'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                startDate: moment().subtract(29, 'days'),
                endDate  : moment()
            },
            function (start, end) {
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
            }
        );

    //Timepicker
    $('#timepicker').datetimepicker({
        format: 'LT'
    });

    $('[data-mask]').inputmask();*/
    });
</script>
</body>
</html>