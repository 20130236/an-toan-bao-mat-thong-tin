<%@ page import="model.Introduce" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% Introduce intro = (Introduce) request.getAttribute("info");%>
<!DOCTYPE html>
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<html lang="en">
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Liên hệ</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>
</head>

<body id="contact" class="blog">
    <jsp:include page="/common/web/header.jsp"></jsp:include>

    <!-- main content -->
    <div class="main-content">
        <div id="wrapper-site">
            <div id="content-wrapper">

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
                                    <a href="contact">
                                        <span>Liên hệ</span>
                                    </a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </nav>
                <div id="main">
                    <div class="page-home">
                        <div class="container">
                            <h1 class="text-center title-page">Liên hệ với  chúng tôi</h1>
                            <div class="row-inhert">
                                <div class="header-contact">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-4 col-md-4">
                                            <div class="item d-flex">
                                                <div class="item-left">
                                                    <div class="icon">
                                                        <i class="zmdi zmdi-email"></i>
                                                    </div>
                                                </div>
                                                <div class="item-right d-flex">
                                                    <div class="title">Email:</div>
                                                    <div class="contact-content">
                                                       <%=intro.email%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-4 col-md-4">
                                            <div class="item d-flex">
                                                <div class="item-left">
                                                    <div class="icon">
                                                        <i class="zmdi zmdi-home"></i>
                                                    </div>
                                                </div>
                                                <div class="item-right d-flex">
                                                    <div class="title">Địa chỉ:</div>
                                                    <div class="contact-content">
                                                    <%=intro.address%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-4 col-md-4">
                                            <div class="item d-flex justify-content-end  last">
                                                <div class="item-left">
                                                    <div class="icon">
                                                        <i class="zmdi zmdi-phone"></i>
                                                    </div>
                                                </div>
                                                <div class="item-right d-flex">
                                                    <div class="title">Hotline:</div>
                                                    <div class="contact-content">
                                                      <%=intro.phone%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="contact-map">
                                    <div id="map">
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1959.1065535475252!2d106.79248589450759!3d10.871389657342391!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175276398969f7b%3A0x9672b7efd0893fc4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6JtIFRwLiBI4buTIENow60gTWluaA!5e0!3m2!1svi!2s!4v1667912252789!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                    </div>
                                </div>
                                <div class="input-contact">
                                    <p class="text-intro text-center"><%=intro.caption%>
                                    </p>
									
                                    <p class="icon text-center">
                                        <a href="#">
                                            <img src="/Template/web/img/other/contact_mess.png" alt="img">
                                        </a>
                                    </p>

                                    <div class="d-flex justify-content-center">
                                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                            <div class="contact-form">
                                                <form action="#" method="post" enctype="multipart/form-data">
                                                    <div class="form-fields">
                                                        <div class="form-group row">
                                                            <div class="col-md-6">
                                                                <input class="form-control" name="name" placeholder="Tên của bạn">
                                                            </div>
                                                            <div class="col-md-6 margin-bottom-mobie">
                                                                <input class="form-control" name="from" type="email" value="" placeholder="Địa chỉ Email của bạn">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-md-12 margin-bottom-mobie">
                                                                <input class="form-control" name="from" type="text" value="" placeholder="Tiêu đề">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-md-12">
                                                                <textarea class="form-control" name="message" placeholder="Nội dung lời nhắn" rows="8"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <button class="btn" type="submit" name="submitMessage">
                                                            <img class="img-fl" src="/Template/web/img/other/contact_email.png" alt="img">GỬI
                                                        </button>
                                                    </div>
                                                </form>
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
<!-- contact11:10-->
</html>