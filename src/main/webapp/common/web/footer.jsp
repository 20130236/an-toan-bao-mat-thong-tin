<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Introduce" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- footer -->

<% Introduce in = (Introduce) request.getAttribute("info");%>
<div class="inner-footer">
    <div class="container">
        <div class="footer-top">
            <div class="row">
                <div class="col-lg-3 col-md-12 col-xs-12">
                    <div class="block">
                        <div class="block-content">
                            <div class="title-block">
                                <%=in.name%>
                            </div>
                            <p class="content-logo">
                                <%=in.introduce%>
                            </p>

                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-4 col-xs-12">
                    <div class="block">
                        <div class="block-content">
                            <div class="title-block">
                                VỀ CHÚNG TÔI
                            </div>
                            <ul>
                                <li>
                                    <a href="<c:url value="/about"/>">Giới thiệu HappyHome</a>
                                </li>
                                <li>
                                    <a href="<c:url value="/contact"/>">Liên hệ</a>
                                </li>
                                <li>
                                    <a href="<c:url value="/recruit"/>">Tuyển dụng</a>
                                </li>

                                <li>
                                    <a href="<c:url value="/agent"/>">Chính sách Đại lý / Đối tác</a>
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="block">
                        <div class="block-content">
                            <div class="title-block">
                                DỊCH VỤ
                            </div>
                            <ul>
                                <li>
                                    <a href="<c:url value="/faqs"/>">Các Câu Hỏi Thường Gặp</a>
                                </li>
                                <li>
                                    <a href="<c:url value="/guide"/>">Hướng Dẫn Đặt Hàng</a>
                                </li>
                                <li>
                                    <a href="<c:url value="/delivery"/>">Chính Sách Vận Chuyển</a>
                                </li>
                                <li>
                                    <a href="<c:url value="/warranty"/>">Chính Sách Bảo Hành</a>
                                </li>
                                <li>
                                    <a href="<c:url value="/privacy"/>">Chính Sách Bảo Mật Thông Tin</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-4">
                    <div class="block">
                        <div class="block-content">
                            <div class="title-block">
                                THÔNG TIN LIÊN HỆ
                            </div>
                            <div class="contact-content">
                                <div class="data align-self-stretch d-flex">
                                    <i class="fa fa-home float-left m-bottom" aria-hidden="true"></i>
                                    <div class="content-data">
                                        <b class="mr-2">Showroom:</b><%=in.showroom%>
                                    </div>
                                </div>
                                <div class="data d-flex align-self-stretch">
                                    <i class="fa fa-clock-o float-left" aria-hidden="true"></i>
                                    <div class="content-data">
                                        <b class="mr-2">Thời gian làm việc: </b><%=in.timework%>
                                    </div>
                                </div>
                                <div class="support d-dflex align-self-stretch">
                                    <div class="data mail-support">
                                        <i class="fa fa-envelope float-left" aria-hidden="true"></i>
                                        <div><%=in.email%></div>
                                    </div>
                                </div>
                                <div class="data d-flex align-self-stretch phone-support" style="margin-left: 0px">
                                    <div class="title-icon">
                                        <i class="fa fa-phone float-left" aria-hidden="true"></i>
                                    </div>
                                    <div><%=in.phone%></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="tiva-copyright">
        <div class="container">
            <div class="border-copyright">
                <div class="row align-items-center" style="  align-items: center;justify-content: center;">
                    <div class="">
                        <div class="social-content">
                            <div id="social-block">
                                <div class="social">
                                    <ul class="list-inline mb-0 justify-content-end">
                                        <li class="list-inline-item mb-0">
                                            <a href="#" target="_blank">
                                                <i class="fa fa-facebook"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item mb-0">
                                            <a href="#" target="_blank">
                                                <i class="fa fa-twitter"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item mb-0">
                                            <a href="#" target="_blank">
                                                <i class="fa fa-google"></i>
                                            </a>
                                        </li>
                                        <li class="list-inline-item mb-0">
                                            <a href="#" target="_blank">
                                                <i class="fa fa-instagram"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="tiva-copyright">
        <div class="container">
            <div class="row">
                <div class="text-center col-lg-12 ">
                        <span>
                            <a href="">Copyright © 2023 Nội Thất HAPPYHOME.</a>
                        </span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- back top top -->
<div class="back-to-top">
    <a href="#">
        <i class="fa fa-long-arrow-up"></i>
    </a>
</div>

<!-- Page Loader -->
<div id="page-preloader">
    <div class="page-loading">
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
    </div>
</div>
