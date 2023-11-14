<%@ page import="model.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Post" %>
<%@ page import="model.Post" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<% Post post = (Post) request.getAttribute("ar");
%>
<html lang="zxx">
<!-- blog-detail10:38-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=post.title%></title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>


    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v15.0&appId=1827192387637142&autoLogAppEvents=1" nonce="TPPeMGh0"></script>
    <meta property="fb:app_id" content="1827192387637142" />
</head>

<body id="blog-detail" class="blog">
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
                                                <span>Danh mục bài viết</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <span>Chi tiết bài viết</span>
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


                                    </div>
                                    <div class="col-sm-8 col-lg-9 col-md-9 flex-xs-first main-blogs">
                                        <h3><%=post.title%></h3>
                                        <div class="hover-after">
                                            <img src="<%=post.getImagePost(0)%>" alt="img" class="img-fluid">
                                        </div>
                                        <div class="late-item">
                                            <p>
                                                <%=post.content%>
                                            </p>
                                           



                                            <div class="border-detail">
                                                <p class="post-info float-left">
                                                    <span>Ngày đăng <%=post.date%></span>
                                                    <span>0 Bình luận</span>
                                                   </span>
                                                </p>
                                                <div class="btn-group">
                                                    <a href="#">
                                                        <i class="zmdi zmdi-share"></i>
                                                        <span>Chia sẻ</span>
                                                    </a>
                                                    <a href="#" class="email">
                                                        <i class="fa fa-envelope" aria-hidden="true"></i>
                                                        <span>Gửi đến bạn bè</span>
                                                    </a>
                                                    <a href="#" class="print">
                                                        <i class="zmdi zmdi-print"></i>
                                                        <span>In</span>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="related">
                                            <h2 class="title-block">TIN TỨC MỚI NHẤT</h2>
                                            <div class="main-blogs">
                                                <div class="row">
                                                    <% List<Post> list = (List<Post>) request.getAttribute("newest");
                                                        for (Post ar: list){
                                                    %>
                                                    <div class="col-md-4">
                                                        <div class="hover-after">
                                                            <a href="detail_article?pid=<%=ar.post_id%>">
                                                                <img src="<%=ar.getImagePost(0)%>" alt="img" class="img-fluid">
                                                            </a>
                                                        </div>
                                                        <div class="late-item">
                                                            <p class="content-title">
                                                                <a href="detail_article?pid=<%=ar.post_id%>"><%=ar.title%></a>
                                                            </p>
                                                            <p class="description"><%=ar.content.substring(0,50)%>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="reply late-item">
                                            <div class="blog-comment" id="blog-comment">
                                                <h2 class="title-block">Bình luận</h2>
                                                <div class="fb-comments" data-href="https://nguyenthanhdat20130013.github.io/HappyHomeMVC/<%=post.post_id%>" data-width="" data-numposts="5"></div>
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
</body>


<!-- blog-detail10:54-->
</html>

