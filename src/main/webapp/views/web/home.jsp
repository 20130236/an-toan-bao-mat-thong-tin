<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="../../common/taglib.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Product> bSP = (ArrayList<Product>) request.getAttribute("bSP");
    List<Product> newP = (ArrayList<Product>) request.getAttribute("newP");
%>
<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Trang chủ</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Nội thất HappyHome">
    <meta name="author" content="tivatheme">
    <jsp:include page="/common/web/css.jsp"></jsp:include>

</head>

<body id="home">
<jsp:include page="/common/web/header.jsp"></jsp:include>

<!-- main content -->
<div class="main-content">
    <div class="wrap-banner">
        <!-- slide show -->
        <div class="section banner">
            <div class="tiva-slideshow-wrapper">
                <div id="tiva-slideshow" class="nivoSlider">
                    <a href="#">
                        <img class="img-responsive" src="<c:url value="/Template/web/img/home/home1-banner1.jpg"/>" title="#caption1" alt="Slideshow image">
                    </a>
                    <a href="#">
                        <img class="img-responsive" src="<c:url value="/Template/web/img/home/home1-banner2.jpg"/>" title="#caption2" alt="Slideshow image">
                    </a>
                    <a href="#">
                        <img class="img-responsive" src="<c:url value="/Template/web/img/home/home1-banner3.jpg"/>" title="#caption3" alt="Slideshow image">
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- main -->
    <div id="wrapper-site">
        <div id="content-wrapper" class="full-width">
            <div id="main">
                <section class="page-home">
                    <!-- product living room -->
                    <div class="container">

                        <!-- best seller -->
                        <div class="section best-sellers col-lg-12 col-xs-12">
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="groupproductlist">
                                        <div class="row d-flex align-items-center">
                                            <!-- column 4 -->
                                            <div class="flex-4 col-lg-4 flex-4">
                                                <h2 class="title-block">
                                                    <span class="sub-title"></span>Sản phẩm bán chạy
                                                </h2>
                                                <div class="content-text">
                                                    <p>
                                                    </p>
                                                    <div>
                                                        <a href="list_product">Xem toàn bộ</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- column 8 -->
                                            <div class="block-content col-lg-8 flex-8">
                                                <div class="tab-content">
                                                    <div class="tab-pane fade in active show">
                                                        <div class="category-product-index owl-carousel owl-theme owl-loaded owl-drag">
                                                            <div class="item text-center">
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=bSP.get(0).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=bSP.get(0).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=bSP.get(0).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=bSP.get(0).getProduct_id()%>"><%=bSP.get(0).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=bSP.get(0).formatCurrency(bSP.get(0).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=bSP.get(0).formatCurrency(bSP.get(0).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=bSP.get(0).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=bSP.get(0).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=bSP.get(0).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=bSP.get(1).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=bSP.get(1).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=bSP.get(1).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=bSP.get(1).getProduct_id()%>"><%=bSP.get(1).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=bSP.get(1).formatCurrency(bSP.get(1).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=bSP.get(1).formatCurrency(bSP.get(1).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=bSP.get(1).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=bSP.get(1).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=bSP.get(1).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="item text-center">
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=bSP.get(2).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=bSP.get(2).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=bSP.get(2).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=bSP.get(2).getProduct_id()%>"><%=bSP.get(2).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=bSP.get(2).formatCurrency(bSP.get(2).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=bSP.get(2).formatCurrency(bSP.get(2).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=bSP.get(2).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=bSP.get(2).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=bSP.get(2).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=bSP.get(3).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=bSP.get(3).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=bSP.get(3).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=bSP.get(3).getProduct_id()%>"><%=bSP.get(3).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=bSP.get(3).formatCurrency(bSP.get(3).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=bSP.get(3).formatCurrency(bSP.get(3).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=bSP.get(3).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=bSP.get(3).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=bSP.get(3).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="item text-center">
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=bSP.get(4).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=bSP.get(4).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=bSP.get(4).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=bSP.get(4).getProduct_id()%>"><%=bSP.get(4).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=bSP.get(4).formatCurrency(bSP.get(4).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=bSP.get(4).formatCurrency(bSP.get(4).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=bSP.get(4).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=bSP.get(4).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=bSP.get(4).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=bSP.get(5).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=bSP.get(5).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=bSP.get(5).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=bSP.get(5).getProduct_id()%>"><%=bSP.get(5).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=bSP.get(5).formatCurrency(bSP.get(5).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=bSP.get(5).formatCurrency(bSP.get(5).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=bSP.get(5).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=bSP.get(5).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=bSP.get(5).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
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
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- newest -->
                        <div class="section best-sellers col-lg-12 col-xs-12">
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="groupproductlist">
                                        <div class="row d-flex align-items-center">
                                            <!-- column 4 -->
                                            <div class="flex-4 col-lg-4 flex-4">
                                                <h2 class="title-block">
                                                    <span class="sub-title"></span>Sản phẩm mới
                                                </h2>
                                                <div class="content-text">
                                                    <p>
                                                    </p>
                                                    <div>
                                                        <a href="list_product">Xem toàn bộ</a>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- column 8 -->
                                            <div class="block-content col-lg-8 flex-8">
                                                <div class="tab-content">
                                                    <div class="tab-pane fade in active show">
                                                        <div class="category-product-index owl-carousel owl-theme owl-loaded owl-drag">
                                                            <div class="item text-center">
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=newP.get(0).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=newP.get(0).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=newP.get(0).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=newP.get(0).getProduct_id()%>"><%=newP.get(0).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=newP.get(0).formatCurrency(newP.get(0).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=newP.get(0).formatCurrency(newP.get(0).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=newP.get(0).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=newP.get(0).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=newP.get(0).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="/product_detail?pid=<%=newP.get(1).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=newP.get(1).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=newP.get(1).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=newP.get(1).getProduct_id()%>"><%=newP.get(1).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=newP.get(1).formatCurrency(newP.get(1).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=newP.get(1).formatCurrency(newP.get(1).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=newP.get(1).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=newP.get(1).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=newP.get(1).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="item text-center">
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=newP.get(2).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=newP.get(2).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=newP.get(2).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=newP.get(2).getProduct_id()%>"><%=newP.get(2).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=newP.get(2).formatCurrency(newP.get(2).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=newP.get(2).formatCurrency(newP.get(2).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=newP.get(2).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=newP.get(2).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=newP.get(2).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=newP.get(3).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=newP.get(3).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=newP.get(3).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=newP.get(3).getProduct_id()%>"><%=newP.get(3).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=newP.get(3).formatCurrency(newP.get(3).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=newP.get(3).formatCurrency(newP.get(3).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=newP.get(3).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=newP.get(3).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=newP.get(3).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="item text-center">
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=newP.get(4).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=newP.get(4).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=newP.get(4).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=newP.get(4).getProduct_id()%>"><%=newP.get(4).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=newP.get(4).formatCurrency(newP.get(4).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=newP.get(4).formatCurrency(newP.get(4).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=newP.get(4).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=newP.get(4).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=newP.get(4).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="product-miniature js-product-miniature item-one first-item">
                                                                    <div class="thumbnail-container">
                                                                        <a href="product_detail?pid=<%=newP.get(5).getProduct_id()%>">
                                                                            <img class="img-fluid image-cover" src="<%=newP.get(5).getImage(0)%>" alt="img">
                                                                            <img class="img-fluid image-secondary" src="<%=newP.get(5).getImage(1)%>" alt="img">
                                                                        </a>
                                                                        <div class="highlighted-informations">
                                                                            <div class="variant-links">
                                                                                <a href="#" class="color beige" title="Beige"></a>
                                                                                <a href="#" class="color orange" title="Orange"></a>
                                                                                <a href="#" class="color green" title="Green"></a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="product_detail?pid=<%=newP.get(5).getProduct_id()%>"><%=newP.get(5).getName()%></a>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price"><%=newP.get(5).formatCurrency(newP.get(5).getPrice_sell())%></span>
                                                                                    <del class="regular-price"><%=newP.get(5).formatCurrency(newP.get(5).getPrice())%></del>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex justify-content-center">
                                                                            <form action="#" method="post" class="formAddToCart">
                                                                                <input type="hidden" name="id_product" value="1">
                                                                                <a class="add-to-cart" href="cart/add?id=<%=newP.get(5).getProduct_id()%>" data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist" href="favorite/add?id=<%=newP.get(5).getProduct_id()%>" data-rel="1" onclick="">
                                                                                <i class="fa fa-heart" aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="product_detail?pid=<%=newP.get(5).getProduct_id()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                                <i class="fa fa-eye" aria-hidden="true"></i>
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
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- banner -->
                        <div class="container" style="margin-top: 140px">
                            <div class="title-block" style="padding-bottom: 150px;margin-top: -100px">Bộ sưu tập nổi bật</div>
                            <div class="section spacing-10 group-image-special col-lg-12 col-xs-12">
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="effect">
                                            <a href="#">
                                                <img class="img-fluid" src="<c:url value="/Template/web/img/home/effect3.jpg"/>" alt="banner-1" title="banner-1">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="effect">
                                            <a href="#">
                                                <img class="img-fluid" src="<c:url value="/Template/web/img/home/effect4.jpg"/>" alt="banner-2" title="banner-2">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <br><br><br><br>
                            <div class="section spacing-10 group-image-special col-lg-12 col-xs-12">
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="effect">
                                            <a href="#">
                                                <img class="img-fluid" src="<c:url value="/Template/web/img/home/effect1.jpg"/>" alt="banner-1" title="banner-1">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="effect">
                                            <a href="#">
                                                <img class="img-fluid" src="<c:url value="/Template/web/img/home/effect2.jpg"/>" alt="banner-2" title="banner-2">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- testimonial -->
                        </div>

                        <!-- recent post -->
                        <div class="policy-home" >
                            <div class="container">
                                <div class="row">
                                    <div class="col-lg-4 col-md-4">
                                        <div class="block">
                                            <div class="block-content" style="">
                                                <div class="policy-item">
                                                    <div class="policy-content iconpolicy1">
                                                        <img src="<c:url value="/Template/web/img/home/policy-index-removebg.png"/>" alt="img">
                                                        <div class="description">
                                                            <div class="policy-name mb-5">Giao hàng & lắp đặt</div>
                                                            <div class="policy-des">Miễn phí</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tiva-html col-lg-4 col-md-4">
                                        <div class="block">
                                            <div class="block-content">
                                                <div class="policy-item">
                                                    <div class="policy-content iconpolicy2">
                                                        <img src="<c:url value="/Template/web/img/home/1on1-removebg.png"/>" alt="img">
                                                        <div class="description">
                                                            <div class="policy-name mb-5">Đổi trả 1 - 1</div>
                                                            <div class="policy-des">Miễn phí</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tiva-html col-lg-4 col-md-4">
                                        <div class="block">
                                            <div class="block-content">
                                                <div class="policy-item">
                                                    <div class="policy-content iconpolicy3" style="text-align: center">
                                                        <img src="<c:url value="/Template/web/img/home/warranty-removebg.png"/>" alt="img">
                                                        <div class="description">
                                                            <div class="policy-name mb-5">1 năm bảo hành</div>
                                                            <div class="policy-des">Miễn phí</div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</div>

<!-- footer -->



<jsp:include page="/common/web/footer.jsp"></jsp:include>
<jsp:include page="/common/web/js.jsp"></jsp:include>
</body>
</html>
