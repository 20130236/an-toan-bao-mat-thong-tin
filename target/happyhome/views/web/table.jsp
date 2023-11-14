<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="controller.web.ListProduct" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product_type" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<html lang="en">

<!-- product-grid-sidebar-left10:54-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Danh sách sản phẩm</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>
</head>

<body id="product-sidebar-left" class="product-grid-sidebar-left">
<jsp:include page="/common/web/header.jsp"></jsp:include>

<!-- main content -->
<div class="main-content">
    <div id="wrapper-site">
        <div id="content-wrapper" class="full-width">
            <div id="main">
                <div class="page-home">
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
                                        <a href="list_product">
                                            <span>Danh mục sản phẩm</span>
                                        </a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </nav>

                    <div class="container">
                        <div class="content">
                            <div class="row">
                                <div class="sidebar-3 sidebar-collection col-lg-3 col-md-4 col-sm-4">

                                    <!-- category menu -->

                                    <div class="sidebar-block">

                                        <div class="title-block">Thể loại</div>
                                        <c:forEach items="${listType}" var="type">
                                            <c:url var="uri" value="/productCate">
                                                <c:param name="cid" value="${type.type_id}"/>
                                            </c:url>
                                            <div class="block-content">
                                                <div class="cateTitle hasSubCategory open level1">
                                                    <a href="${uri}">${type.type_name}</a>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                </div>

                                <div class="col-sm-8 col-lg-9 col-md-8 product-container">
                                    <% Product_type t = (Product_type) request.getAttribute("typeName"); %>
                                    <h1><%=t.getType_name()%>
                                    </h1>

                                    <div class="js-product-list-top firt nav-top">
                                        <div class="d-flex justify-content-around row">
                                            <div class="col col-xs-12">
                                                <ul class="nav nav-tabs">
                                                    <li>
                                                        <a href="#grid" data-toggle="tab"
                                                           class="active show fa fa-th-large"></a>
                                                    </li>
                                                    <li>
                                                        <a href="#list" data-toggle="tab" class="fa fa-list-ul"></a>
                                                    </li>
                                                </ul>
                                                <div class="hidden-sm-down total-products">
                                                    <p>Có ${num} sản phẩm.</p>
                                                </div>
                                            </div>
                                            <div class="col col-xs-12">
                                                <div class="d-flex sort-by-row justify-content-lg-end justify-content-md-end">

                                                    <div class="products-sort-order dropdown">
                                                        <select class="select-title">
                                                            <option value="">Sắp xếp theo</option>
                                                            <option value="">Tên, A đến Z</option>
                                                            <option value="">Tên, Z đến A</option>
                                                            <option value="">Giá, thấp đến cao</option>
                                                            <option value="">Giá, cao đến thấp</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-content product-items">

                                        <div id="grid" class="related tab-pane fade in active show">

                                            <div class="row" id="data-product-row">
                                                <c:forEach items="${list}" var="product">
                                                    <c:url var="urlProduct" value="/product_detail">
                                                        <c:param name="pid" value="${product.product_id}"/>
                                                    </c:url>
                                                    <c:url var="urlCart" value="/cart/add">
                                                        <c:param name="id" value="${product.product_id}"/>
                                                    </c:url>
                                                    <c:url var="urlFavorite" value="/favorite/add">
                                                        <c:param name="id" value="${product.product_id}"/>
                                                    </c:url>

                                                    <div class="item text-center col-md-4">

                                                        <div class="product-miniature js-product-miniature item-one first-item">
                                                            <div class="thumbnail-container border">
                                                                <a href="${urlProduct}">
                                                                    <img class="img-fluid image-cover"
                                                                         src="${product.getImage(0)}" alt="img">
                                                                    <img class="img-fluid image-secondary"
                                                                         src="${product.getImage(1)}" alt="img">
                                                                </a>
                                                                <div class="highlighted-informations">
                                                                    <div class="variant-links">
                                                                        <a href="#" class="color beige"
                                                                           title="Beige"></a>
                                                                        <a href="#" class="color orange"
                                                                           title="Orange"></a>
                                                                        <a href="#" class="color green"
                                                                           title="Green"></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="product-description">
                                                                <div class="product-groups">
                                                                    <div class="product-title">
                                                                        <a href="${urlProduct}">${product.name}</a>
                                                                    </div>
                                                                    <div class="rating">
                                                                        <div class="star-content">
                                                                            <div class="star"></div>
                                                                            <div class="star"></div>
                                                                            <div class="star"></div>
                                                                            <div class="star"></div>
                                                                            <div class="star"></div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-group-price">
                                                                        <div class="product-price-and-shipping">
                                                                            <span class="price"> ${product.formatCurrency(product.getPrice_sell())}</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="product-buttons d-flex justify-content-center">
                                                                    <form action="#" method="post"
                                                                          class="formAddToCart">
                                                                        <input type="hidden" name="id_product"
                                                                               value="1">

                                                                        <a class="add-to-cart" href="${urlCart}"
                                                                           data-button-action="add-to-cart">
                                                                            <i class="fa fa-shopping-cart"
                                                                               aria-hidden="true"></i>
                                                                        </a>
                                                                    </form>
                                                                    <a class="addToWishlist" href="${urlFavorite}"
                                                                       data-rel="1" onclick="">
                                                                        <i class="fa fa-heart" aria-hidden="true"></i>
                                                                    </a>
                                                                    <a href="${urlProduct}"
                                                                       class="quick-view hidden-sm-down"
                                                                       data-link-action="quickview">
                                                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </c:forEach>
                                            </div>

                                        </div>

                                        <div id="list" class="related tab-pane fade">
                                            <div class="row" id="data-product-row-list">
                                                <div class="item col-md-12">
                                                    <div class="product-miniature item-one first-item">
                                                        <div class="row">
                                                            <c:forEach var="p" items="${list}">
                                                                <c:url var="urlProp" value="/product_detail">
                                                                    <c:param name="pid" value="${p.product_id}"/>
                                                                </c:url>
                                                                <c:url var="urlCartp" value="/cart/add">
                                                                    <c:param name="id" value="${p.product_id}"/>
                                                                </c:url>
                                                                <c:url var="urlFavoritep" value="/favorite/add">
                                                                    <c:param name="id" value="${p.product_id}"/>
                                                                </c:url>
                                                                <div class="col-md-4">
                                                                    <div class="thumbnail-container border">
                                                                        <a href="${urlProp}">
                                                                            <img class="img-fluid image-cover"
                                                                                 src="${p.getImage(0)}" alt="img">
                                                                            <img class="img-fluid image-secondary"
                                                                                 src="${p.getImage(1)}" alt="img">
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="product-description">
                                                                        <div class="product-groups">
                                                                            <div class="product-title">
                                                                                <a href="${urlProp}">${p.getName()}</a>
                                                                                <c:set var="result" value="Còn hàng"/>
                                                                                <c:if test="${p.status == 0}">
                                                                                    <c:set var="result"
                                                                                           value="Hết hàng"/>
                                                                                </c:if>
                                                                                <span class="info-stock">
                                                                     <i class="fa fa-check-square-o"
                                                                        aria-hidden="true"></i>
                                                                         ${result}
                                                                            </span>
                                                                            </div>
                                                                            <div class="rating">
                                                                                <div class="star-content">
                                                                                    <c:forEach begin="1" end="5">
                                                                                        <div class="star"></div>
                                                                                    </c:forEach>
                                                                                </div>
                                                                            </div>
                                                                            <div class="product-group-price">
                                                                                <div class="product-price-and-shipping">
                                                                                    <span class="price">${p.formatCurrency(p.getPrice_sell())} vnđ</span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="discription">
                                                                                    ${p.getInfo()}
                                                                            </div>
                                                                        </div>
                                                                        <div class="product-buttons d-flex">
                                                                            <form action="#" method="post"
                                                                                  class="formAddToCart">
                                                                                <a class="add-to-cart"
                                                                                   href="<c:url value='/cart/add?id=${p.product_id}' />"
                                                                                   data-button-action="add-to-cart">
                                                                                    <i class="fa fa-shopping-cart"
                                                                                       aria-hidden="true"></i>Thêm vào
                                                                                    giỏ hàng
                                                                                </a>
                                                                            </form>
                                                                            <a class="addToWishlist"
                                                                               href="<c:url value='/favorite/add?id=${p.product_id}' />"
                                                                               data-rel="1" onclick="">
                                                                                <i class="fa fa-heart"
                                                                                   aria-hidden="true"></i>
                                                                            </a>
                                                                            <a href="<c:url value='/product_detail?pid=${p.product_id}' />"
                                                                               class="quick-view hidden-sm-down"
                                                                               data-link-action="quickview">
                                                                                <i class="fa fa-eye"
                                                                                   aria-hidden="true"></i>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <!-- pagination -->
                                    <div class="pagination" id="pagination">
                                        <div class="js-product-list-top ">
                                            <div class="d-flex justify-content-around row">
                                                <div class="showing col col-xs-12">
                                                    <span>HIỂN THỊ ${indexPage} TRONG ${endP} MỤC</span>
                                                </div>
                                                <div class="page-list col col-xs-12">
                                                    <ul>
                                                        <c:forEach var="i" begin="1" end="${endP}">
                                                            <li class="${tag == i?"current active" :""}">
                                                                <a rel="nofollow" href="<c:url value='/list_product?index=${i}' />"
                                                                   class="disabled js-search-link">
                                                                        ${i}
                                                                </a>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end col-md-9-1 -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- footer -->
    <jsp:include page="/common/web/footer.jsp"></jsp:include>

    <!-- Vendor JS -->
    <jsp:include page="/common/web/js.jsp"></jsp:include>

</div>
</body>

<!-- product-grid-sidebar-left10:55-->
</html>