<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: datng
  Date: 04/05/2023
  Time: 10:53 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Tải chữ ký điện tử</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
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
                            <h2 class="h4">Chữ ký sẽ được tự động tải xuống !!!</h2>
                            <div class="info">
                                <p>
                                    Nếu không tự động ta xin nhấn vào link phía dưới để tải. </p>
                            </div>
                            <a id="download-signature" class="btn btn-default"
                               download
                               href="<c:url value="${path}"/>">
                                <i class="fa fa-download" aria-hidden="true"></i>
                                <span>Tải chữ ký</span>
                            </a>
                        </div>
                    </div>
                </div>

            </section>
        </div>
    </div>
</div>

<jsp:include page="/common/web/js.jsp"></jsp:include>
<script>

    $(function(){
        $("#download-signature").click();
    })

</script>
</body>

<!-- 40410:56-->
</html>

