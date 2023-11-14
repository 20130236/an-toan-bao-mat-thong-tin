<%@ page import="model.Favorite" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<html lang="en">


<!-- user-wishlist11:10-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Dach sách yêu thích</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>

    <style>
        .wishlist_delete a{
            background: #343434;
            color: #ffff;
        }

        .menu-top a{
            height: 60px;
        }

    </style>
</head>

<body class="user-wishlist blog">
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
                                <a href="favorite">
                                    <span>Sản phẩm yêu thích</span>
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
                                <div id="mywishlist">
                                    <h1 class="title-page">Danh sách sản phẩm yêu thích</h1>
                                    <div id="block-history" class="block-center">
                                        <table class="std table">
                                            <thead>
                                                <tr>

                                                    <th class="first_item">Tên sản phẩm</th>

                                                    <th class="last_item mywishlist_first">Tác vụ</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${listProduct}" var="item">
                                                <tr id="wishlist_1">
                                                    <td><img src="${item.getImage(0)}" width="40" height="40"> &ensp;
                                                        ${item.getName()}
                                                    </td>

                                                    <td class="wishlist_delete">
                                                        <a href="product_detail?pid=${item.getProduct_id()}" class="btn btn-default" >Xem sản phẩm</a>
                                                        <a href="favorite/del?id=${item.getProduct_id()}"  class="btn btn-default" >Xoá</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="page-home">
                                        <a class="btn btn-default" href="list_product">
                                            <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                                            <span>Tiếp tục mua hàng</span>
                                        </a>
                                    </div>
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
</body>
</html>