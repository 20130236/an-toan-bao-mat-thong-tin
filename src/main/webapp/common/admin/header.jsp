<%@ page import="model.UserModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    UserModel user = (UserModel)session.getAttribute("auth");
%>
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
        <!-- Navbar Search -->
        <li class="nav-item">
            <a class="nav-link" data-widget="navbar-search" href="#" role="button">
                <i class="fas fa-search"></i>
            </a>
            <div class="navbar-search-block">
                <form class="form-inline">
                    <div class="input-group input-group-sm">
                        <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
                        <div class="input-group-append">
                            <button class="btn btn-navbar" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                            <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                <i class="fas fa-expand-arrows-alt"></i>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
                <i class="fas fa-th-large"></i>
            </a>
        </li>
    </ul>
</nav>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="home.html" class="brand-link">
        <img src="<c:url value="/Template/admin/dist/img/AdminLTELogo.png"/>" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">QUẢN LÍ HAPPYHOME</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="<c:url value="/Template/admin/dist/img/user2-160x160.jpg"/>" class="img-circle elevation-2" alt="User Image">
            </div>
            <% if (user != null) {%>
            <div class="info">
                <a href="#" class="d-block"><%=user.getUserName()%></a>
            </div>
            <% } else {%>
            <div class="info">
                <a href="#" class="d-block">Admin</a>
            </div>
            <% }%>
        </div>

        <!-- SidebarSearch Form -->
        <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div><div class="sidebar-search-results"><div class="list-group"><a href="#" class="list-group-item"><div class="search-title"><strong class="text-light"></strong>N<strong class="text-light"></strong>o<strong class="text-light"></strong> <strong class="text-light"></strong>e<strong class="text-light"></strong>l<strong class="text-light"></strong>e<strong class="text-light"></strong>m<strong class="text-light"></strong>e<strong class="text-light"></strong>n<strong class="text-light"></strong>t<strong class="text-light"></strong> <strong class="text-light"></strong>f<strong class="text-light"></strong>o<strong class="text-light"></strong>u<strong class="text-light"></strong>n<strong class="text-light"></strong>d<strong class="text-light"></strong>!<strong class="text-light"></strong></div><div class="search-path"></div></a></div></div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
                with font-awesome or any other icon font library -->
                <li class="nav-item ">
                    <a href="<c:url value="/admin-home"/>" class="nav-link ">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>
                            Trang chủ
                        </p>
                    </a>
                </li>
                <li class="nav-item ">
                    <a href="" class="nav-link ">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            Quản lý sản phẩm
                            <i class="fas fa-angle-left right"></i>
                            <span class="badge badge-info right"></span>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-data-category?access="/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh mục sản phẩm</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin-product_manager"/>" class="nav-link ">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh sách sản phẩm </p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin-add_product"/>" class="nav-link ">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Thêm sản phẩm</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item" id="quan-ly-user">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                            Quản lý user
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-data-user?action=list"/>" class="nav-link" id="data-user">
                                <i class="far fa-circle nav-icon"></i>
                                <p> Danh sách user</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item " id="quan-ly-don-hang">
                    <a href="" class="nav-link">
                        <i class="nav-icon fas fa-tree"></i>
                        <p>
                            Quản lý đơn hàng
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-order_controller"/>" class="nav-link ">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh sách đơn hàng</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin-check_order"/>" class="nav-link ">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Duyệt đơn hàng</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item " id="quan-ly-report">
                    <a href="" class="nav-link">
                        <i class="nav-icon fa fa-wrench"></i>
                        <p>
                            Quản lý report
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-listreport_controller"/>" class="nav-link ">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh sách report</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin-check_report"/>" class="nav-link ">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Duyệt report</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item" >
                    <a href="" class="nav-link">
                        <i class="nav-icon fas fa-rss"></i>
                        <p>
                            Quản lý thông tin web
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-info_controller"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Thông tin trên website</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item" >
                    <a href="" class="nav-link">
                        <i class="nav-icon fas fa-chart-pie"></i>
                        <p>
                            Thống kê
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-remaining-controller"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Tổng quan về kho hàng</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item" >
                    <a href="" class="nav-link">
                        <i class="nav-icon fas fa-paperclip"></i>
                        <p>
                            Quản lý quyền
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-role-data"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh sách các quyền</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item" >
                    <a href="" class="nav-link">
                        <i class="nav-icon fas fa-shipping-fast"></i>
                        <p>
                            Quản lý Kho
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-import-products"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh sách phiếu nhập hàng</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin-import-product"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Thêm phiếu nhập hàng</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item" >
                    <a href="" class="nav-link">
                        <i class="nav-icon fas fa-search-location"></i>
                        <p>
                            Quản lý log
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin-log-data"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh sách log</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin-statistics-log"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Thống kê log</p>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>






