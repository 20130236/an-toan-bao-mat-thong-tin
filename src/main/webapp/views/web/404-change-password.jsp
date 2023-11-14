<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/1/2023
  Time: 9:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<html lang="en">


<!-- 40410:55-->
<head>
  <!-- Basic Page Needs -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Trang không tồn tại</title>
  <link rel="icon" type="image/x-icon" href="/img/home/Logo-happyhome-removebg-preview.png">
  <meta name="keywords" content="Furniture, Decor, Interior">
  <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
  <meta name="author" content="tivatheme">


  <!-- Mobile Meta -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <jsp:include page="/common/web/css.jsp"></jsp:include>
</head>

<body id="page-404" class="blog">

<!-- main content -->
<div class="main-content">
  <div id="wrapper-site">
    <div id="content-wrapper">
      <section class="page-home">
        <div class="container">
          <div class="row center">
            <div class="content-404 col-lg-6 col-sm-6 text-center">
              <div class="image">
                <img class="img-fluid" src="<c:url value="/Template/web/img/other/image-404.png"/>" alt="Image 404">
              </div>
              <h2 class="h4">RẤT TIẾC, TRANG BẠN ĐANG TÌM KIẾM KHÔNG TỒN TẠI !!!</h2>
              <div class="info">
                <p>
                  Nếu lỗi vẫn tiếp diễn vui lòng liên hệ với Quản trị viên của trang web này và báo cáo lỗi bên trên. </p>
              </div>
              <a class="btn btn-default" href="<c:url value="/home"/>">
                <i class="fa fa-home" aria-hidden="true"></i>
                <span>Trở lại trang chủ</span>
              </a>
            </div>
            <div class="content-right-404 col-lg-6 col-sm-6 text-center">
              <a href="#">
                <img class="img-fluid" src="<c:url value="/Template/web/img/other/background.jpg"/>" alt="image 404 right">
              </a>
            </div>
          </div>
        </div>

      </section>
    </div>
  </div>
</div>
<jsp:include page="/common/web/js.jsp"></jsp:include>
</body>


<!-- 40410:56-->
</html>
