<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String)request.getAttribute("error");
    String message = (String)request.getAttribute("message");
%>
<html>

<!-- user-reset-password11:18-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Quên mật khẩu</title>

    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>
    <style>
        .error{
            float: left !important;
            color:#dc3545 !important;

        }
    </style>
</head>

<body class="user-reset-password blog">
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
                                <span>Quên mật khẩu</span>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
        </nav>
    </div>

    <!-- main -->
    <div id="wrapper-site">
        <div class="container">
            <div class="row">
                <div id="content-wrapper" class="onecol">
                    <div id="main">
                        <div class="page-content">
                            <form action="<c:url value="/reset-password"/>" class="forgotten-password" method="post" id="customer-form">
                                <h1 class="text-center title-page">Đặt lại mật khẩu</h1>
                                <div class="form-fields text-center ">
                                    <div class="form-group center-email-fields" style="display: flex;flex-direction: column;">
                                        <% if(error != null) {%>
                                        <div class="alert-danger" style="float: left"><%=error%> </div>
                                        <% } %>
                                        <% if(message != null) {%>
                                        <div class="alert-success" style="float: left"><%=message%> </div>
                                        <% } %>
                                        <div class="username">
                                            <input type="text" name="username" id="username" value="" class="form-control" placeholder="Nhập tài khoản của bạn">
                                            <label id="username-error" class="error" for="username" style="display: inline;"></label>
                                        </div>
                                        <div class="email" style="padding-top: 20px;">
                                            <input type="email" name="email" id="email" value="" class="form-control" placeholder="Nhập địa chỉ Email của bạn">
                                            <label id="email-error" class="error" for="email" style="display: inline;"></label>
                                        </div>
                                        <div>
                                            <button class="form-control-submit btn btn-primary" name="submit" type="submit">
                                                Lấy lại mật khẩu
                                            </button>
                                        </div>
                                    </div>
                                    <a href="<c:url value="/login"></c:url>" class="account-link">
                                        <i class="fa fa-angle-left" aria-hidden="true"></i>
                                        <span class="text-center"><a href="<c:url value="/login"/>">Trở lại đăng nhập</a></span>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/common/web/footer.jsp"></jsp:include>
<!-- Vendor JS -->
<jsp:include page="/common/web/js.jsp"></jsp:include>
<script src="<c:url value="/Template/web/libs/jquery/jquery.validate.js"/>"></script>
<script>
    $.validator.setDefaults({
        errorElement: "label",
        errorClass: "error"
    });

    +(function ($) {
        $("#customer-form").validate({
            rules: {
                username: {
                    required : true
                },
                email: {
                    required : true,
                    email : true
                }
            },
            messages: {
                username: {
                    required : "Phải nhập tên tài khoản",
                },
                email: {
                    required : "Phải nhập email",
                    email : "Email không đúng định dạng"
                }
            }
        });
    })(jQuery);
</script>
</body>
</html>