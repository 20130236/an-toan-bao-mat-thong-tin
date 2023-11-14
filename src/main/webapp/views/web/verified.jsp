<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<!-- user-login11:10-->
<head>
  <!-- Basic Page Needs -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>xác thực</title>

  <meta name="keywords" content="Furniture, Decor, Interior">
  <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
  <meta name="author" content="tivatheme">

  <!-- Mobile Meta -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <jsp:include page="/common/web/css.jsp"></jsp:include>
  <style>
    .btn-primary:hover{
      background-color: #343434 !important;
      color: #FFFFFF !important;
    }
  </style>
</head>

<body class="user-login blog">
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
                <span>Xác thực</span>
              </a>
            </li>
          </ol>
        </div>
      </div>
    </nav>
  </div>

  <!-- main -->
  <div id="wrapper-site">
    <div id="content-wrapper" class="full-width">
      <div id="main">
        <div class="container">
          <div class="login-form">
            <form id="customer-form" action="<c:url value="/login"/>" method="post" style="text-align: center;">
              <h1 class="text-center title-page">Xác thực thành công</h1>
              <p>Quý khách đã xác thực thành công tài khoản của quý khách.</p>
              <p>Kể từ bây giờ Quý khách đã có thể đăng nhập vào website bằng tài khoản của quý khách.</p>
              <a class="btn btn-primary" href="<c:url value="/login"/>" style="color: #FFFFFF"> Đăng nhập</a>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<jsp:include page="/common/web/footer.jsp"></jsp:include>

<jsp:include page="/common/web/js.jsp"></jsp:include>
<script src="<c:url value="/Template/web/libs/jquery/jquery.validate.js"/>"></script>
<script>

</script>
</body>


<!-- user-login11:10-->
</html>