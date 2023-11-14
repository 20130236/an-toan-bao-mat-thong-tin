<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Collection.Collectionss" %>
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
  <title>Bộ sưu tập</title>
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
                      <span>Bộ sưu tập </span>
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

                    <div class="title-block">Bộ sưu tập</div>
                    <% List<Collectionss> list0 = (List<Collectionss>) request.getAttribute("collectionssList");
                      for (Collectionss pty: list0
                      ) {%>
                    <div class="block-content">
                      <div class="cateTitle hasSubCategory open level1">
                        <a class="cateItem" href="collection?cid=<%=pty.getId()%>"><%= pty.getName()%></a>
                      </div>
                    </div>
                    <%}%>
                  </div>

                </div>

                <div class="col-sm-8 col-lg-9 col-md-8 product-container">
                  <% String t = request.getAttribute("typeName").toString(); %>
                  <h1><%=t.toString()%></h1>

                  <div class="js-product-list-top firt nav-top">
                    <div class="d-flex justify-content-around row">
                      <div class="col col-xs-12">
                        <ul class="nav nav-tabs">
                          <li>
                            <a href="#grid" data-toggle="tab" class="active show fa fa-th-large"></a>
                          </li>
                          <li>
                            <a href="#list" data-toggle="tab" class="fa fa-list-ul"></a>
                          </li>
                        </ul>
                        <div class="hidden-sm-down total-products">
                        </div>
                      </div>
                      <div class="col col-xs-12">
                        <div class="d-flex sort-by-row justify-content-lg-end justify-content-md-end">

                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="tab-content product-items">
                    <div id="grid" class="related tab-pane fade in active show">
                      <div class="row" id="data-product-row">
                        <% List<Product> list = (List<Product>) request.getAttribute("list");
                          for (Product p: list) {%>
                        <div class="item text-center col-md-4">
                          <div class="product-miniature js-product-miniature item-one first-item">
                            <div class="thumbnail-container border">
                              <a href="product_detail?pid=<%=p.product_id%>">
                                <img class="img-fluid image-cover" src="<%=p.getImage(0)%>" alt="img">
                                <img class="img-fluid image-secondary" src="<%=p.getImage(1)%>" alt="img">
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
                                  <a href="product_detail?pid=<%=p.product_id%>"><%=p.getName() %></a>
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
                                    <span class="price"><%=p.formatCurrency(p.getPrice_sell())%></span>
                                  </div>
                                </div>
                              </div>
                              <div class="product-buttons d-flex justify-content-center">
                                <form action="#" method="post" class="formAddToCart">
                                  <input type="hidden" name="id_product" value="1">
                                  <a class="add-to-cart" href="cart/add?id=<%=p.product_id%>" data-button-action="add-to-cart">
                                    <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                                  </a>
                                </form>
                                <a class="addToWishlist" href="favorite/add?id=<%=p.product_id%>" data-rel="1" onclick="">
                                  <i class="fa fa-heart" aria-hidden="true"></i>
                                </a>
                                <a href="product_detail?pid=<%=p.product_id%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                  <i class="fa fa-eye" aria-hidden="true"></i>
                                </a>
                              </div>
                            </div>
                          </div>
                        </div>
                        <%}%>
                      </div>
                    </div>
                    <div id="list" class="related tab-pane fade">
                      <div class="row" id="data-product-row-list">
                        <div class="item col-md-12">
                          <div class="product-miniature item-one first-item">
                            <div class="row">
                              <% List<Product> list2 = (List<Product>) request.getAttribute("list");
                                for (Product p: list
                                ) {%>
                              <div class="col-md-4">
                                <div class="thumbnail-container border">
                                  <a href="product_detail?pid=<%=p.product_id%>">
                                    <img class="img-fluid image-cover" src="<%=p.getImage(0)%>" alt="img">
                                    <img class="img-fluid image-secondary" src="<%=p.getImage(1)%>" alt="img">
                                  </a>
                                </div>
                              </div>
                              <div class="col-md-8">
                                <div class="product-description">
                                  <div class="product-groups">
                                    <div class="product-title">
                                      <a href="product_detail?pid=<%=p.product_id%>"><%=p.getName() %></a>
                                      <% String result = "Còn hàng";
                                        if(p.status == 0){
                                          result = "Hết hàng";
                                        }
                                      %>
                                      <span class="info-stock">
                                        <i class="fa fa-check-square-o" aria-hidden="true"></i>
                                        <%=result%>
                                      </span>
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
                                        <span class="price"><%=p.formatCurrency(p.getPrice_sell())%></span>
                                      </div>
                                    </div>
                                    <div class="discription">
                                      <%=p.getInfo() %>
                                    </div>
                                  </div>
                                  <div class="product-buttons d-flex">
                                    <form action="#" method="post" class="formAddToCart">
                                      <a class="add-to-cart" href="<c:url value="/cart/add?id=<%=p.product_id%>"></c:url>" data-button-action="add-to-cart">
                                        <i class="fa fa-shopping-cart" aria-hidden="true"></i>Thêm vào giỏ hàng
                                      </a>
                                    </form>
                                    <a class="addToWishlist" href="/favorite/add?id=<%=p.product_id%>" data-rel="1" onclick="">
                                      <i class="fa fa-heart" aria-hidden="true"></i>
                                    </a>
                                    <a href="product_detail?pid=<%=p.product_id%>" class="quick-view hidden-sm-down" data-link-action="quickview">
                                      <i class="fa fa-eye" aria-hidden="true"></i>
                                    </a>
                                  </div>
                                </div>

                              </div>
                              <%}%>
                            </div>

                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- pagination -->
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