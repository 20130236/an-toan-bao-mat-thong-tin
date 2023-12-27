<%@ page import="model.UserModel" %><%--
  Created by IntelliJ IDEA.
  User: win10pro
  Date: 12/14/2023
  Time: 2:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    UserModel user = (UserModel) request.getAttribute("user");
    String success = (String) request.getAttribute("success");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Report</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>
</head>
<body class="user-acount">
<jsp:include page="/common/web/header.jsp"></jsp:include>

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
                                <span>Report</span>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
        </nav>

        <div class="acount head-acount">
            <div class="container">
                <div id="main">
                    <form action="<c:url value="/user_report"/>" method="post">
                        <div class="content" id="block-history">
                            <table class="std table">
                                <tbody>
                                <% if(success != null) { %>
                                <div class="alert-success"><%=success%></div>
                                <% } %>
                                <tr>
                                    <th class="first_item">Họ và Tên :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="user-name" name="user_name" type="text"  required>
                                                <label id="user-name-error" class="error" for="user-name" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th class="first_item">Email :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="email" name="email" type="text"  required>
                                                <label id="email-error" class="error" for="email" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th class="first_item" >Điện thoại :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="phone_num" name="phone_num" type="number"  required>
                                                <label id="phone-num-error" class="error" for="phone_num" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th class="first-item">Yêu cầu :</th>
                                    <td>
                                        <div class="form-group">
                                            <input class="form-control" id="message" name="message" type="text"  required>
                                            <label id="message-error" class="error" for="message" style="display: inline;"></label>
                                        </div>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                        <button class="btn btn-primary" data-link-action="sign-in" type="submit">
                            Gửi yêu cầu
                        </button>
                    </form>
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
