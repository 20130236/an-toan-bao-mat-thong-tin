<%@ page import="model.UserModel" %>
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

    <link rel="stylesheet" href="/Template/web/libs/bootstrap/css/bootstrap.min.css"><%--Bootstrap v4.1.0--%>

    <!-- Bootstrap Datetimepicker CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css">

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
                                    <th class="first_item">Tên tài khoản :</th>
                                    <td>
                                        <div class="form-group">
                                            <div>
                                                <input class="form-control" id="user-name" name="user_name" type="text" value="<%=user.getUserName()%>"  required>
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
                                                <input class="form-control" id="email" name="email" type="text" value="<%=user.getEmail()%>" required>
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
                                                <input class="form-control" id="phone_num" name="phone_num" type="number"  value="<%=user.getPhoneNum()==null?"":user.getPhoneNum()%>"  required>
                                                <label id="phone-num-error" class="error" for="phone_num" style="display: inline;"></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th class="first-item">Yêu cầu :</th>
                                    <td>
                                        <div class="form-group">
                                            <select class="form-control" id="message" name="message" required>
                                                <option value="mat-key">Mất key</option>
                                                <option value="lo-key">Lộ key</option>
                                                <option value="cap-lai-key">Cấp lại key</option>
                                            </select>
                                            <label id="message-error" class="error" for="message" style="display: inline;"></label>
                                        </div>
                                    </td>

                                <tr>
                                    <th class="first-item">Ngày gặp vấn đề :</th>
                                    <td>
                                        <div class="form-group">
                                            <input class="form-control datetimepicker" id="date_key" name="date_key" type="text"  required>
                                            <label id="date_key-error" class="error" for="date_key" style="display: inline;"></label>
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

<script src="/Template/web/libs/jquery/jquery.min.js"></script><%--jQuery v3.3.1--%>
<script src="/Template/web/libs/popper/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script><%-- Bootstrap v4.3.1 --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

<script>
    $(document).ready(function(){
        var datetimepickerElement = $('.datetimepicker');
        if (datetimepickerElement.length > 0) {
            console.log("Datetimepicker is found on the page.");
            // Nếu bạn đang sử dụng Bootstrap 4, thêm dòng sau để kích hoạt datetimepicker
            datetimepickerElement.datetimepicker({
                format: 'YYYY-MM-DD HH:mm:ss',
                // Các tùy chọn khác nếu cần
            });
        } else {
            console.log("Datetimepicker is NOT found on the page.");
        }
    });
</script>
</body>
</html>
