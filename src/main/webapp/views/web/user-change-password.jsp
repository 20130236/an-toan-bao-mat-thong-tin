<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String error = (String)request.getAttribute("error");
%>
<html>

<!-- user-reset-password11:18-->
<head>
  <!-- Basic Page Needs -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Đặt lại mật khẩu</title>
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
                <span>Đặt lại mật khẩu</span>
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
              <form action="<c:url value="/change-password"/>" class="forgotten-password" method="post" id="customer-form">
                <h1 class="text-center title-page">Đặt lại mật khẩu</h1>
                <div class="form-fields text-center ">
                  <div class="form-group center-email-fields">
                    <% if(error != null) {%>
                    <div class="alert-danger" style="float: left"><%=error%> </div>
                    <% } %>
                    <div class="password">
                      <input type="password" name="password" id="password" value="" class="form-control" placeholder="Mật khẩu">
                      <label id="password-error" class="error" for="password" style="display: inline;"></label>
                    </div>
                    <div class="password" style="padding-top: 20px;">
                      <input type="password" name="password2" id="password2" value="" class="form-control" placeholder="Xác nhận mật khẩu">
                      <label id="password2-error" class="error" for="password2" style="display: inline;"></label>
                    </div>
                    <div>
                      <input type="hidden" name="token" value="<%=request.getAttribute("token")%>">
                      <button class="form-control-submit btn btn-primary" name="submit" type="submit">
                        Đổi mật khẩu
                      </button>
                    </div>
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
        password: {
          required : true
        },
        password2: {
          required : true
        }
      },
      messages: {
        password: {
          required : "Phải nhập mật khẩu"
        },
        password2: {
          required : "Phải xác nhận lại mật khẩu"
        }
      }
    });
  })(jQuery);
</script>
</body>
</html>