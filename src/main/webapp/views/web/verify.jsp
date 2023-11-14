<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  String error = (String) request.getAttribute("error");
%>
<html>
<!-- user-login11:10-->
<head>
  <!-- Basic Page Needs -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Xác thực</title>

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
              <h1 class="text-center title-page">Xác thực</h1>
              <h5 style=" padding-bottom: 15px;"><strong>VUI LÒNG XÁC THỰC EMAIL</strong></h5>
              <p>Chúng tôi đã gửi đường link xác thực đã được gửi vào email của quý khách.</p>
              <p>Click vào đường link để xác thực email của quý khách.</p>
              <p><strong>Làm ơn xác thực email việc làm này là bắt buộc!</strong></p>
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