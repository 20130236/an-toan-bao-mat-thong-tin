<%@ page import="model.UserModel" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    UserModel user = (UserModel) request.getAttribute("user");
    String success = (String) request.getAttribute("success");
%>
<html>
<!-- user-acount11:10-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Thông tin tài khoản</title>
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
                                <span>Sửa thông tin</span>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
        </nav>

        <div class="acount head-acount">
            <div class="container">
                <div id="main">
                    <h1 class="title-page">Thông tin tài khoản</h1>
                    <form action="<c:url value="/account"/>" id="edit-acc" method="post" novalidate="novalidate">
                        <div class="content" id="block-history">
                            <table class="std table">
                                <tbody>
                                <% if(success != null) { %>
                                <div class="alert-success"><%=success%></div>
                                <% } %>
                                <h5>Thông tin người dùng</h5>
                                <tr>
                                    <th class="first_item">Tên tài khoản :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input style="background-color: #fff;color: #495057;" class="form-control" id="username" disabled name="username" type="text" value="<%=user.getUserName()%>">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="first_item">Email :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="email" name="email" type="text" value="<%=user.getEmail()%>">
                                                <label id="email-error" class="error" for="email" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="first_item">Họ và Tên :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="full-name" name="full_name" type="text" value="<%=user.getFullName()==null?"":user.getFullName()%>">
                                                <label id="full-name-error" class="error" for="full-name" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="first_item">Giới tính</th>
                                    <td>
                                        <div class="form-group" style="display: flex;padding: 5px 0px" id="gender">
                                            <div style="display: flex;align-self: center; margin-left: -25px;">
                                                <input class="form-control" id="radio1" name="gender" type="radio" value="nam">
                                                <span class="design"></span>
                                                <label for="radio2" style="margin-bottom: 0px" >Nam</label>
                                            </div>
                                            <div style="display: flex;align-self: center;">
                                                <input class="form-control" id="radio2" name="gender" type="radio" value="nữ">
                                                <span class="design"></span>
                                                <label for="radio2" style="margin-bottom: 0px">Nữ</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="first_item" >Điện thoại :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="phone_num" name="phone_num" type="number" value="<%=user.getPhoneNum()==null?"":user.getPhoneNum()%>">
                                                <label id="phone-num-error" class="error" for="phone_num" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="first_item">Địa chỉ đầy đủ :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="address" name="address" type="text" value="<%=user.getAddress()==null?"":user.getAddress()%>">
                                                <label id="address-error" class="error" for="address" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="first_item">Chữ ký điện tử:</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="signature" name="signature" type="text" value="<%=user.getSignature()==null?"":user.getSignature()%>">
                                                <label id="signature-error" class="error" for="signature" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <input class="form-control" type="hidden" id="id" name="id" type="text" value="<%=user.getId()%>">
                        <input class="form-control" type="hidden" id="user_name" name="user_name" type="text" value="<%=user.getUserName()%>">
                        <input class="form-control" type="hidden" id="role" name="role" type="text" value="<%=user.getRole()%>">
                        <button class="btn btn-primary" data-link-action="sign-in" type="submit">
                            Lưu Thông Tin
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

<script src="<c:url value="/Template/web/libs/jquery/jquery.validate.js"/>"></script>
<script>

    $('input:radio[name="gender"]').filter('[value="<%=user.getGender()%>"]').attr('checked', true);

    $.validator.setDefaults({
        errorElement: "label",
        errorClass: "error"
    });

    +(function ($) {
        $.validator.setDefaults({
            submitHandler: function () {
                alert( "Cập nhật thông tin thành công" );
            }
        });
        $("#edit-acc").submit(function(e) {
            e.preventDefault(); // avoid to execute the actual submit of the form.
            var form = $(this);
            var actionUrl = form.attr('action');
            $.ajax({
                type: "POST",
                url: actionUrl,
                data: form.serialize()
            });
        });
        $("#edit-acc").validate({
            rules: {
                username: {
                    required : true
                },
                password: {
                    required: true
                },
                password_again: {
                    required: true
                },
                full_name: {
                    required: true
                },
                email: {
                    required : true,
                    email : true
                },
                phone_num: {
                    required : true
                }
            },
            messages: {
                userName: {
                    required : "Phải nhập tên tài khoản",
                },
                password: {
                    required: "Phải nhập mật khẩu",
                },
                password_again: {
                    required: "Phải nhập lại mật khẩu"
                },
                full_name: {
                    required : "Phải nhập họ và tên"
                },
                email: {
                    required : "Phải nhập email",
                    email : "email không đúng định dạng"
                },
                phone_num: {
                    required : "Phải nhập số điện thoại"
                }
            }
        });

    })(jQuery);

</script>
</body>
</html>