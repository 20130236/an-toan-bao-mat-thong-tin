<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Post" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<html lang="en">


<!-- blog-list-sidebar-left10:09-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Danh mục bài viết</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">


    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>
</head>

<body id="blog-list-sidebar-left" class="blog">
    <header>


        <!-- header desktop -->
        <jsp:include page="/common/web/header.jsp"></jsp:include>
    </header>

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
                                                <span>Danh mục bài viết</span>
                                            </a>
                                        </li>
                                       
                                    </ol>
                                </div>
                            </div>
                        </nav>
                        <div class="container">
                            <div class="content">
                                <div class="row">
                                    <div class="sidebar-3 sidebar-collection col-lg-3 col-md-3 col-sm-4">
                                        <div class="sidebar-block">
                                            <div class="title-block">Thể loại</div>
                                            <div class="block-content">
                                                <div class="cateTitle hasSubCategory open level1">
                                                    <c:forEach items="${listAr}" var="item">
                                                        <div class="cateTitle hasSubCategory open level1">
                                                    <a class="cateItem" href="articleCate?cid=${item.getPost_category_id()}">${item.getPost_category_name()}</a>
                                                        </div>
                                                    </c:forEach>
                                                </div>


                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-sm-8 col-lg-9 col-md-9 flex-xs-first main-blogs">
                                        <h2>Bài đăng gần đây</h2>
                                        <% List<Post> list = (List<Post>) request.getAttribute("list");
                                            for (Post ar: list){
                                        %>
                                        <div class="list-content row">
                                            <div class="hover-after col-md-5 col-xs-12">
                                                <a href="detail_article?pid=<%=ar.getPost_id()%>">
                                                    <img src="<%=ar.getImagePost(0)%>" alt="img">
                                                </a>
                                            </div>
                                            <div class="late-item col-md-7 col-xs-12">
                                                <p class="content-title">
                                                    <a href="detail_article?pid=<%=ar.getPost_id()%>"><%=ar.getTitle()%>
                                                    </a>
                                                </p>

                                                <p class="description"><%=ar.getContent().substring(0,50)%>
                                                </p>
                                                <span class="view-more">
                                                    <a href="detail_article?pid=<%=ar.getPost_id()%>">Xem thêm</a>
                                                </span>
                                            </div>
                                        </div>
                                        <% } %>
                                        <div class="page-list col">

                                            <ul class="justify-content-center d-flex">
                                                <c:forEach var = "i" begin = "1" end = "${endP}">
                                                    <li class="${tag == i?"current active" :""}" >
                                                        <a rel="nofollow" href="list_posts?index=${i}" class="disabled js-search-link">${i}</a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
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
</body>

</html>