<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="model.ProductSearchModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    List<ProductSearchModel> listPro = (List<ProductSearchModel>)request.getAttribute("listPro");
    DecimalFormat formatter = new DecimalFormat("###,###,###");
    int pageNum = (int) request.getAttribute("page");
    int totalPage = (int) request.getAttribute("totalPage");
    String display = (String)request.getAttribute("display");
    String orderBy = (String)request.getAttribute("orderBy");
    String sortBy = (String)request.getAttribute("sortBy");
%>
<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<html lang="en">
<!-- product-list-sidebar-left10:55-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Kết quả tìm kiếm  "${textSearch}"</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">


    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>
    <style>

        #pagination{
            padding-left: 25%;
        }
        .pagination .page-link:hover{
            background-color: #0a0e14;
        }
        .page-link{
            border-radius: 0.25rem !important;
            margin-left: 3px!important;
        }
        .pagination .page-link{
            color: white;!important;
            background-color: #c4c4c4;
        }

        .page-item.disabled .page-link{
            opacity: 0;
        }

        .page-item.active .page-link{
            background: #343434;
            border-color : #FFFFFF;
        }

        .next .page-link{
            background: #343434!important;
            border-color : #FFFFFF!important;
        }

        .prev .page-link{
            background: #343434!important;
            border-color : #FFFFFF!important;
        }

        .first .page-link{
            display: none;
        }

        .last .page-link{
            display: none;

        }
        .page-link i{
            font-size: 13px;
        }

        a[class="page-link"]{
            height: 100% !important;
        }
        a[class="dropdown-item"]{
            width: 100% !important;
            border: none !important;
            height: 37px !important;
            padding-top: 2px !important;
            text-align: left !important;
        }

        .dropdown-menu li:hover a[class="dropdown-item"]{
            background-color: #0a0e14 !important;
            color: #FFFFFF !important;
        }

        .dropdown-menu .dropdown-item {
            color: black !important;
            background-color: #FFFFFF !important;
        }

        .dropdown-toggle{
            font-size: 12px;
            color: black !important;
            background-color: #ffff !important;
            border: 1px solid #ececec !important;
            border-radius: 4px !important;
            margin-left: 11px;
        }

        .products-sort-order{
            padding-top: 0px !important;
        }

    </style>
</head>
<body id="product-sidebar-left">
<jsp:include page="/common/web/header.jsp"></jsp:include>
<!-- main content -->
<div class="main-content">

    <div id="wrapper-site">
        <div id="content-wrapper">
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
                                        <a href="#">
                                            <span>Tìm kiếm</span>
                                        </a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </nav>
                    <% if(listPro == null) {%>
                    <div class="container">
                        <div class="content">
                            <div class="col" style="text-align: center">
                                <h2><strong>Không tìm thấy nội dung bạn yêu cầu</strong></h2>
                                <div class="subtext">
                                    <span>Không tìm thấy <strong>${textSearch}</strong>. </span>
                                    <span>Vui lòng kiểm tra chính tả, sử dụng các từ tổng quát hơn và thử lại!</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} else {%>
                    <div class="container">
                        <div class="content">
                            <div class="row">
                                <div class="col-sm-8 col-lg-12 col-md-8 product-container">
                                    <h1>Kết quả tìm kiếm "${textSearch}"</h1>
                                    <div class="js-product-list-top firt nav-top">
                                        <div class="d-flex justify-content-around row">
                                            <div class="col col-xs-12 ">
                                                <%if(display.equals("grid")){%>
                                                <ul class="nav nav-tabs">
                                                    <li>
                                                        <a href="search?search=${textSearch}&page<%=pageNum%>&display=grid&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>" class="fa fa-th-large active show"></a>
                                                    </li>
                                                    <li>
                                                        <a href="search?search=${textSearch}&page=<%=pageNum%>&display=list&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>" class="fa fa-list-ul"></a>
                                                    </li>
                                                </ul>
                                                <%} else if(display.equals("list")){%>
                                                <ul class="nav nav-tabs">
                                                    <li>
                                                        <a href="search?search=${textSearch}&page=<%=pageNum%>&display=grid&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>" data-toggle="tab-content" data-ca-target-class="tab-content" class="fa fa-th-large"></a>
                                                    </li>
                                                    <li>
                                                        <a href="search?search=${textSearch}&page=<%=pageNum%>&display=list&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>" data-toggle="tab-content" data-ca-target-class="tab-content" class="fa fa-list-ul active show"></a>
                                                    </li>
                                                </ul>
                                                <%}%>
                                                <div class="hidden-sm-down total-products">
                                                    <p>có ${totalItem} sản phẩm</p>
                                                </div>
                                            </div>
                                            <div class="col col-xs-12">
                                                <div class="d-flex sort-by-row justify-content-end">
                                                    <div class="products-sort-order dropdown">
                                                        <%if(orderBy.equals("name") && sortBy.equals("asc")){%>
                                                        <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            Theo ký tự, A to Z
                                                        </button>
                                                        <%} else if(orderBy.equals("name") && sortBy.equals("desc")){%>
                                                        <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            Theo ký tự, Z to A
                                                        </button>
                                                        <%} else if(orderBy.equals("price_sell") && sortBy.equals("asc")){%>
                                                        <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            Theo giá , từ thấp tới cao
                                                        </button>
                                                        <%} else if(orderBy.equals("price_sell") && sortBy.equals("desc")){%>
                                                        <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            Theo giá , từ cao tới thấp
                                                        </button>
                                                        <%}else if(orderBy.equals("onsale")){%>
                                                        <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            Có giảm giá
                                                        </button>
                                                        <%} else {%>
                                                        <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                            Mặc định
                                                        </button>
                                                        <%}%>
                                                        <ul class="dropdown-menu" style="width: 200px;height: 230px;top:36px;border-radius: 4px">
                                                            <li><a class="dropdown-item" href="search?search=${textSearch}&page=<%=pageNum%>&display=<%=display%>">Mặc định</a></li>
                                                            <%--<li><a class="dropdown-item" href="living-room?page=<%=pageNum%>&display=<%=display%>&orderBy=">Sản phẩm mới</a></li>--%>
                                                            <li><a class="dropdown-item" href="search?search=${textSearch}&page=<%=pageNum%>&display=<%=display%>&orderBy=name&sortBy=asc">Theo ký tự, A to Z</a></li>
                                                            <li><a class="dropdown-item" href="search?search=${textSearch}&page=<%=pageNum%>&display=<%=display%>&orderBy=name&sortBy=desc"> Theo ký tự, Z to A</a></li>
                                                            <li><a class="dropdown-item" href="search?search=${textSearch}&page=<%=pageNum%>&display=<%=display%>&orderBy=price_sell&sortBy=asc">Theo giá , từ thấp tới cao</a></li>
                                                            <li><a class="dropdown-item" href="search?search=${textSearch}&page=<%=pageNum%>&display=<%=display%>&orderBy=price_sell&sortBy=desc"> Theo giá , từ cao tới thấp</a></li>
                                                            <%--<li><a class="dropdown-item" href="javascript:;">Sản phẩm bán chạy</a></li>--%>
                                                            <li><a class="dropdown-item" href="search?search=${textSearch}&page=<%=pageNum%>&display=<%=display%>&orderBy=onsale">Có giảm giá</a></li>
                                                        </ul>
                                                        <%-- <input type="hidden" value="" name="orderBy">
                                                         <input type="hidden" value="" name="sortBy">--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-content product-items">
                                        <% if (display.equals("grid")){%>
                                        <div id="grid" class="related tab-pane fade active show">
                                            <div class="row">
                                                <% for(ProductSearchModel pro : listPro) {%>
                                                <div class="item text-center col-md-3" >
                                                    <div class="product-miniature js-product-miniature item-one first-item" >
                                                        <div class="thumbnail-container border" >
                                                            <a href="product_detail?pid=<%=pro.getId()%>">
                                                                <img class="img-fluid image-cover" src="<%=pro.getListImg().get(0).getUrl()%>" alt="img" >
                                                                <img class="img-fluid image-secondary" src="<%=pro.getListImg().get(1).getUrl()%>" alt="img" >
                                                            </a >
                                                            <div class="highlighted-informations" >
                                                                <div class="variant-links" >
                                                                    <a href = "#" class="color beige" title = "Beige" ></a >
                                                                    <a href = "#" class="color orange" title = "Orange" ></a >
                                                                    <a href = "#" class="color green" title = "Green" ></a >
                                                                </div >
                                                            </div >
                                                        </div >
                                                        <div class="product-description" >
                                                            <div class="product-groups" >
                                                                <div class="product-title" >
                                                                    <a href="product_detail?pid=<%=pro.getId()%>"><%=pro.getName()%></a >
                                                                </div >
                                                                <div class="rating" >
                                                                    <div class="star-content" >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                    </div >
                                                                </div >
                                                                <div class="product-group-price" >
                                                                    <%if(pro.getPrice_sell() < pro.getPrice()){%>
                                                                    <div class="product-price-and-shipping" >
                                                                        <span class="price" style="font-size: 12px;text-decoration: line-through;color:#939393;padding-bottom: 8px;"> <%=formatter.format(pro.getPrice())%> vnđ</span>
                                                                        <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                    </div>
                                                                    <% } else {%>

                                                                    <div class="product-price-and-shipping" style="display: flex; flex-direction: column;">
                                                                        <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                    </div>
                                                                    <% }%>
                                                                </div>
                                                            </div >
                                                            <div class="product-buttons d-flex justify-content-center" >
                                                                <form action = "#" method = "post" class="formAddToCart" >
                                                                    <input type = "hidden" name = "id_product" value = "1" >
                                                                    <a class="add-to-cart" href="cart/add?id=<%=pro.getId()%>" data-button-action = "add-to-cart" >
                                                                        <i class="fa fa-shopping-cart" aria-hidden = "true" ></i >
                                                                    </a >
                                                                </form >
                                                                <a class="addToWishlist" href="favorite/add?id=<%=pro.getId()%>" data-rel = "1" onclick = "" >
                                                                    <i class="fa fa-heart" aria-hidden = "true" ></i >
                                                                </a>
                                                                <a href="product_detail?pid=<%=pro.getId()%>" class="quick-view hidden-sm-down" data-link-action = "quickview" >
                                                                    <i class="fa fa-eye" aria-hidden = "true" ></i >
                                                                </a >
                                                            </div >
                                                        </div >
                                                    </div >
                                                </div >
                                                <%}%>
                                            </div>
                                        </div>
                                        <div id="list" class="related tab-pane fade in ">
                                            <div class="row">
                                                <% for(ProductSearchModel pro : listPro) { %>
                                                <div class="item col-md-12">
                                                    <div class="product-miniature item-one first-item">
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <div class="thumbnail-container border">
                                                                    <a href="product_detail?pid=<%=pro.getId()%>">
                                                                        <img class="img-fluid image-cover" src="<%=pro.getListImg().get(0).getUrl()%>" alt="img" >
                                                                        <img class="img-fluid image-secondary" src="<%=pro.getListImg().get(1).getUrl()%>" alt="img" >
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-9">
                                                                <div class="product-description">
                                                                    <div class="product-groups">
                                                                        <div class="product-title">
                                                                            <a href="product_detail?pid=<%=pro.getId()%>"><%=pro.getName()%></a>
                                                                            <%--   <% if (pro.getQuantity() > 0) { %>
                                                                               <span class="info-stock">
                                               <i class="fa fa-check-square-o" aria-hidden="true"></i>
                                                     Còn hàng
                                              </span>
                                                                               <% } else { %>
                                                                               <span class="info-stock" style="color:#f44336;">
                                                 <i class="fa-solid fa-xmark" aria-hidden="true"></i>
                                                       hết hàng
                                                  </span>
                                                                               <%}%>--%>
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
                                                                            <%if(pro.getPrice_sell() < pro.getPrice()){%>
                                                                            <div class="product-price-and-shipping">
                                                                                <span class="price" style="font-size: 12px;text-decoration: line-through;color:#939393;"> <%=formatter.format(pro.getPrice())%> vnđ</span>
                                                                                <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                            </div>
                                                                            <% } else {%>
                                                                            <div class="product-price-and-shipping">
                                                                                <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                            </div>
                                                                            <% }%>
                                                                        </div>
                                                                        <div class="discription">
                                                                            <%=pro.getInfo().substring(0,20)%>...
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-buttons d-flex">
                                                                        <form action="#" method="post" class="formAddToCart">
                                                                            <a class="add-to-cart" href="cart/add?id=<%=pro.getId()%>" data-button-action="add-to-cart">
                                                                                <i class="fa fa-shopping-cart" aria-hidden="true"></i>Thêm vào giỏ hàng
                                                                            </a>
                                                                        </form>
                                                                        <a class="addToWishlist" href="favorite/add?id=<%=pro.getId()%>" data-rel="1" onclick="">
                                                                            <i class="fa fa-heart" aria-hidden="true"></i>
                                                                        </a>
                                                                        <a href="product_detail?pid=<%=pro.getId()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%}%>
                                            </div>
                                        </div>
                                        <%} else if(display.equals("list")) { %>
                                        <div id="grid" class="related tab-pane fade ">
                                            <div class="row">
                                                <% for(ProductSearchModel pro : listPro) {%>
                                                <div class="item text-center col-md-3" >
                                                    <div class="product-miniature js-product-miniature item-one first-item" >
                                                        <div class="thumbnail-container border" >
                                                            <a href="product_detail?pid=<%=pro.getId()%>">
                                                                <img class="img-fluid image-cover" src="<%=pro.getListImg().get(0).getUrl()%>" alt="img" >
                                                                <img class="img-fluid image-secondary" src="<%=pro.getListImg().get(1).getUrl()%>" alt="img" >
                                                            </a >
                                                            <div class="highlighted-informations" >
                                                                <div class="variant-links" >
                                                                    <a href = "#" class="color beige" title = "Beige" ></a >
                                                                    <a href = "#" class="color orange" title = "Orange" ></a >
                                                                    <a href = "#" class="color green" title = "Green" ></a >
                                                                </div >
                                                            </div >
                                                        </div >
                                                        <div class="product-description" >
                                                            <div class="product-groups" >
                                                                <div class="product-title" >
                                                                    <a href="product_detail?pid=<%=pro.getId()%>"><%=pro.getName()%></a >
                                                                </div >
                                                                <div class="rating" >
                                                                    <div class="star-content" >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                        <div class="star" ></div >
                                                                    </div >
                                                                </div >
                                                                <div class="product-group-price" >
                                                                    <%if (pro.getPrice_sell() < pro.getPrice()){%>
                                                                    <div class="product-price-and-shipping" style="display: flex; flex-direction: column;">
                                                                        <span class="price" style="font-size: 12px;text-decoration: line-through;color:#939393;padding-bottom: 8px;"> <%=formatter.format(pro.getPrice())%> vnđ</span>
                                                                        <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                    </div>
                                                                    <% } else {%>
                                                                    <div class="product-price-and-shipping">
                                                                        <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                    </div>
                                                                    <% }%>
                                                                </div>
                                                            </div >
                                                            <div class="product-buttons d-flex justify-content-center" >
                                                                <form action = "#" method = "post" class="formAddToCart" >
                                                                    <input type = "hidden" name = "id_product" value = "1" >
                                                                    <a class="add-to-cart" href="cart/add?id=<%=pro.getId()%>" data-button-action = "add-to-cart" >
                                                                        <i class="fa fa-shopping-cart" aria-hidden = "true" ></i >
                                                                    </a >
                                                                </form >
                                                                <a class="addToWishlist" href="favorite/add?id=<%=pro.getId()%>" data-rel = "1" onclick = "" >
                                                                    <i class="fa fa-heart" aria-hidden = "true" ></i >
                                                                </a>
                                                                <a href="product_detail?pid=<%=pro.getId()%>" class="quick-view hidden-sm-down" data-link-action = "quickview" >
                                                                    <i class="fa fa-eye" aria-hidden = "true" ></i >
                                                                </a >
                                                            </div >
                                                        </div >
                                                    </div >
                                                </div >
                                                <%}%>
                                            </div>
                                        </div>
                                        <div id="list" class="related tab-pane fade in  active show ">
                                            <div class="row">
                                                <% for(ProductSearchModel pro : listPro) {%>
                                                <div class="item col-md-12">
                                                    <div class="product-miniature item-one first-item">
                                                        <div class="row">
                                                            <div class="col-md-3">
                                                                <div class="thumbnail-container border">
                                                                    <a href="product_detail?pid=<%=pro.getId()%>">
                                                                        <img class="img-fluid image-cover" src="<%=pro.getListImg().get(0).getUrl()%>" alt="img" >
                                                                        <img class="img-fluid image-secondary" src="<%=pro.getListImg().get(1).getUrl()%>" alt="img" >
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-9">
                                                                <div class="product-description">
                                                                    <div class="product-groups">
                                                                        <div class="product-title">
                                                                            <a href="product_detail?pid=<%=pro.getId()%>"><%=pro.getName()%></a>
                                                                            <%-- <% if (pro.getQuantity() > 0) { %>
                                                                             <span class="info-stock">
                                             <i class="fa fa-check-square-o" aria-hidden="true"></i>
                                                   Còn hàng
                                            </span>
                                                                             <% } else { %>
                                                                             <span class="info-stock" style="color:#f44336;">
                                               <i class="fa-solid fa-xmark" aria-hidden="true"></i>
                                                     hết hàng
                                                </span>
                                                                             <%}%>--%>
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
                                                                            <%if(pro.getPrice_sell() < pro.getPrice()){%>
                                                                            <div class="product-price-and-shipping">
                                                                                <span class="price" style="font-size: 12px;text-decoration: line-through;color:#939393;"> <%=formatter.format(pro.getPrice())%> vnđ</span>
                                                                                <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                            </div>
                                                                            <% } else {%>
                                                                            <div class="product-price-and-shipping">
                                                                                <span class="price"><%=formatter.format(pro.getPrice_sell())%> vnđ</span>
                                                                            </div>
                                                                            <% }%>
                                                                        </div>
                                                                        <div class="discription">
                                                                            <%=pro.getInfo().substring(0,100)%>...
                                                                        </div>
                                                                    </div>
                                                                    <div class="product-buttons d-flex">
                                                                        <form action="#" method="post" class="formAddToCart">
                                                                            <a class="add-to-cart" href="cart/add?id=<%=pro.getId()%>" data-button-action="add-to-cart">
                                                                                <i class="fa fa-shopping-cart" aria-hidden="true"></i>Thêm vào giỏ hàng
                                                                            </a>
                                                                        </form>
                                                                        <a class="addToWishlist" href="favorite/add?id=<%=pro.getId()%>" data-rel="1" onclick="">
                                                                            <i class="fa fa-heart" aria-hidden="true"></i>
                                                                        </a>
                                                                        <a href="product_detail?pid=<%=pro.getId()%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%}%>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <!-- pagination -->
                                    <%--<div class="pagination">
                                      <div class="js-product-list-top">
                                        <div class="d-flex justify-content-around row">
                                          <div class="showing col col-xs-12">
                                            <span>HIỂN THỊ 1-3 TRONG 3 MỤC</span>
                                          </div>
                                          <div class="page-list col col-xs-12">
                                            <ul>
                                              <li>
                                                <a rel="prev" href="#" class="previous disabled js-search-link">
                                                  Trước
                                                </a>
                                              </li>
                                              <li class="current active">
                                                <a rel="nofollow" href="#" class="disabled js-search-link">
                                                  1
                                                </a>
                                              </li>
                                              <li>
                                                <a rel="nofollow" href="#" class="disabled js-search-link">
                                                  2
                                                </a>
                                              </li>
                                              <li>
                                                <a rel="nofollow" href="#" class="disabled js-search-link">
                                                  3
                                                </a>
                                              </li>

                                              <li>
                                                <a rel="next" href="#" class="next disabled js-search-link">
                                                  Tiếp theo
                                                </a>
                                              </li>
                                            </ul>
                                          </div>
                                        </div>
                                      </div>
                                    </div>--%>
                                    <ul class="pagination" style="max-width: 250px;margin-left: auto;margin-right: auto">
                                        <%if(pageNum != 1) {%>
                                        <li class="page-item">
                                            <a class="page-link" href="search?${textSearch}&page=<%=pageNum- 1 %>&display=<%=display%>&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                        </li>
                                        <%}%>
                                        <%for (int i = 1 ; i <= totalPage; i++){%>
                                        <%if(pageNum == i) {%>
                                        <li class="page-item active">
                                            <a class="page-link" href="search?${textSearch}&page=<%=i%>&display=<%=display%>&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>">
                                                <%=i%>
                                            </a>
                                        </li>
                                        <%} else {%>
                                        <li class="page-item" >
                                            <a class="page-link" href="search?${textSearch}&page=<%=i%>&display=<%=display%>&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>">
                                                <%=i%>
                                            </a>
                                        </li>
                                        <%} }%>
                                        <%if( pageNum < totalPage) {%>
                                        <li class="page-item">
                                            <a class="page-link" href="search?${textSearch}&page=<%=pageNum + 1 %>&display=<%=display%>&orderBy=<%=orderBy%>&sortBy=<%=sortBy%>" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </li>
                                        <%}%>
                                    </ul>
                                    <%--<ul id="pagination" class="pagination">
                                     <li class="page-item prev"><a href="#" class="page-link"><i class="fa-solid fa-arrow-left"></i></a></li><li class="page-item"><a href="#" class="page-link">2</a></li><li class="page-item active"><a href="#" class="page-link">3</a></li><li class="page-item"><a href="#" class="page-link">4</a></li><li class="page-item"><a href="#" class="page-link">5</a></li><li class="page-item next"><a href="#" class="page-link"><i class="fa-solid fa-arrow-left"></i></a></li></ul>--%>
                                </div>
                                <!-- end col-md-9-1 -->
                            </div>
                        </div>
                    </div>
                    <%} %>
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
            </div>
        </div>
    </div>
</div>

<!-- footer -->
<jsp:include page="/common/web/footer.jsp"></jsp:include>

<!-- Vendor JS -->
<jsp:include page="/common/web/js.jsp"></jsp:include>

<script>

</script>
</body>
</html>