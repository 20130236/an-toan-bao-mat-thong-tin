<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String exist_user = (String) request.getAttribute("message");
%>
<html>
<!-- user-register11:10-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Đăng ký</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
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

<body class="user-register blog">
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
                                <span>Đăng ký</span>
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
                <div id="content-wrapper" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 onecol">
                    <div id="main">
                        <div id="content" class="page-content">
                            <div class="register-form text-center">
                                <h1 class="text-center title-page">Tạo Tài Khoản</h1>
                                <form action="<c:url value="/register"/>" id="customer-form" class="js-customer-form" method="post">
                                    <div style="display: flex;flex-direction: column;">
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="full_name" name="full_name" type="text" placeholder="Họ và tên" value="<%=request.getParameter("full_name")==null?"":request.getParameter("full_name")%>">
                                                <label id="full_name-error" class="error" for="full_name" style="display: inline;"></label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="username" name="username" type="text" placeholder="Tên người dùng" value="<%=request.getParameter("username")==null?"":request.getParameter("username")%>">
                                                <label id="username-error" class="error" for="username" style="display: inline;"></label>
                                                <% if(exist_user != null) {%>
                                                <div class="error"><%=exist_user%></div>
                                                <% } %>
                                            </div>
                                        </div>
                                        <div class="form-group" style="display: flex;padding: 5px 0px" id="gender">
                                            <div style="display: flex;align-self: center; margin-left: -25px;">
                                                <input class="form-control" id="radio1" name="gender" type="radio" value="nam" checked>
                                                <span class="design"></span>
                                                <label for="radio2" style="margin-bottom: 0px" >Nam</label>
                                            </div>
                                            <div style="display: flex;align-self: center;">
                                                <input class="form-control" id="radio2" name="gender" type="radio" value="nữ">
                                                <span class="design"></span>
                                                <label for="radio2" style="margin-bottom: 0px">Nữ</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="email" name="email" type="email" placeholder="Email" value="<%=request.getParameter("email")==null?"":request.getParameter("email")%>">
                                                <label id="email-error" class="error" for="email" style="display: inline;"></label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control js-child-focus js-visible-password password" id="password" name="password" type="password" placeholder="Mật khẩu" value="<%=request.getParameter("password")==null?"":request.getParameter("password")%>">
                                                <label id="password-error" class="error" for="password" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <div>
                                            <button class="btn btn-primary" data-link-action="sign-in" type="submit">
                                                ĐĂNG KÝ
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
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
    $.validator.addMethod('lowercase_pass', function(value) {
        return value.match(/[a-z]/);
    }, 'Mật khẩu phải có bao gồm chữ cái thường');

    $.validator.addMethod('uppercase_pass', function(value) {
        return value.match(/[A-Z]/);
    }, 'Mật khẩu phải có bao gồm chữ cái in hoa');

    $.validator.addMethod('special_pass', function(value) {
        return value.match(/[^a-zA-Z\d]/);
    }, 'Mật khẩu phải có bao gồm kí tự đặc biệt');

    $.validator.addMethod('number_pass', function(value) {
        return value.match(/\d/);
    }, 'Mật khẩu phải có bao gồm số');

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
                password: {
                    minlength : 5,
                    required: true,
                    uppercase_pass : true,
                    lowercase_pass : true,
                    number_pass : true,
                    special_pass : true
                },
                email: {
                    required : true,
                    email : true
                },
                full_name: {
                    required : true
                }
            },
            messages: {
                username: {
                    required : "Phải nhập tên tài khoản",
                },
                password: {
                    minlength : "Mật khẩu phải có ít nhất 5 kí tự",
                    required: "Phải nhập mật khẩu",
                },
                email: {
                    required : "Phải nhập email",
                    email : "email không đúng định dạng"
                },
                full_name: {
                    required : "Phải nhập họ và tên"
                }
            }
        });
    })(jQuery);

</script>
</body>

<!-- user-register11:10-->
</html>