<%@ page import="java.util.List" %>
<%@ page import="model.Report" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Danh sách Report</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.datatables.net/v/bs4-4.6.0/jszip-2.5.0/dt-1.13.4/af-2.5.3/b-2.3.6/b-colvis-2.3.6/b-html5-2.3.6/b-print-2.3.6/sb-1.4.2/datatables.min.css" rel="stylesheet"/>
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
<div class="main-content">
    <div class="wrap-banner">

        <!-- breadcrumb -->
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
                            <a href="#">
                                <span>Danh sách report</span>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
        </nav>

        <div class="acount head-acount">
            <div class="container">
                <div id="main">
                    <h1 class="title-page">Danh sách report</h1>
                    <div class="order">
                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                            <tr>
                                <th>Mã report</th>
                                <th>Ngày report</th>
                                <th>Nội dung report</th>
                                <th>Ngày gặp vấn đề</th>
                                <th>Trạng thái report</th>
<%--                                <th>Tác vụ</th>--%>
                            </tr>
                            </thead>
                            <tbody>
                            <% List<Report> list = (List<Report>) request.getAttribute("re");
                                for (Report r: list){
                            %>
                            <tr>
                                <td><%=r.getReport_id()%></td>
                                <td><%=Report.convertDateTime(r.getDate_report().toString())%></td>
                                <td><%=r.getDetail()%></td>
                                <td><%=Report.convertDateTime(r.getDate_key().toString())%></td>
                                <td><%=r.statusReport(r.getStatus())%></td>
<%--                                <td>--%>
<%--                                    <button class="btn btn-info"><a href="user_order?id=<%=r.getReport_id()%>"--%>
<%--                                                                    style="color:white">Chi tiết</a></button>--%>
<%--                                </td>--%>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<!-- footer -->
<jsp:include page="/common/web/footer.jsp"></jsp:include>
<jsp:include page="/common/web/js.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/v/bs4-4.6.0/jszip-2.5.0/dt-1.13.4/af-2.5.3/b-2.3.6/b-colvis-2.3.6/b-html5-2.3.6/b-print-2.3.6/sb-1.4.2/datatables.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
<script>$(document).ready(function() {
    var table = $('#example').DataTable( {
        lengthChange: false,
        buttons: [ 'copy', 'excel', 'pdf', 'colvis' ]
    } );

    table.buttons().container()
        .appendTo( '#example_wrapper .col-md-6:eq(0)' );
} );
</script>
</body>
</html>
