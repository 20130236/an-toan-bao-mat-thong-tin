<%@ page import="model.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<% Product pr = (Product) request.getAttribute("product");

%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết sản phẩm <%=pr.getName()%>
    </title>

    <jsp:include page="/common/admin/css.jsp"></jsp:include>

</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

    <!-- Navbar -->
    <jsp:include page="/common/admin/header.jsp"></jsp:include>
    <!-- /.navbar -->

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1><%=pr.getName()%></h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Thêm sản phẩm</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8">
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Thông tin sản phẩm</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body" style="display: block; padding:0px ;">
                                <form>
                                    <div class="card-body">

                                        <div style="display: flex" class="row">
                                            <div class="form-group col-md-6 ">
                                                <label for="exampleInputEmail1">Id </label>
                                                <input type="text" class="form-control" id="" placeholder="<%=pr.getProduct_id()%>" disabled="disabled">
                                            </div>
                                            <div class="form-group col-md-6 ">
                                                <label for="exampleInputEmail1">Mã sản phẩm</label>
                                                <input type="text" class="form-control" id="" placeholder="<%=pr.getCode()%>" disabled="disabled">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Tên sản phẩm</label>
                                            <input type="email" class="form-control" id="exampleInputEmail1" placeholder="<%=pr.getName()%>" disabled="disabled">
                                        </div>
                                        <div style="display: flex" class="row">
                                            <div class="form-group col-md-6 ">
                                                <label for="exampleInputEmail1">Giá gốc </label>
                                                <input type="text" class="form-control" id="" placeholder="<%=pr.getPrice()%>" disabled="disabled">
                                            </div>
                                            <div class="form-group col-md-6 ">
                                                <label for="exampleInputEmail1">Giá khuyến mãi</label>
                                                <input type="text" class="form-control" id="" placeholder="<%=pr.getPrice_sell()%>" disabled="disabled">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Giới thiệu sản phẩm</label>
                                            <textarea rows="5" class="form-control" id="" placeholder="<%=pr.getInfo()%>" disabled="disabled"></textarea>
                                            <label for="exampleInputEmail1">Thông tin sản phẩm</label>
                                            <input type="email" class="form-control" id="" placeholder="Loại của sản phẩm: <%=pr.getNType()%>" disabled="disabled">
                                            <label for="exampleInputEmail1"></label>
                                            <input type="email" class="form-control" id="" placeholder="Hãng sản xuất: <%=pr.getBrand()%>" disabled="disabled">
                                            <label for="exampleInputEmail1"></label>
                                            <input type="email" class="form-control" id="" placeholder="Màu sắc sản phẩm: <%=pr.getColor()%>" disabled="disabled">
                                            <label for="exampleInputEmail1"></label>
                                            <input type="email" class="form-control" id="" placeholder="Kích thước sản phẩm: <%=pr.getSize()%>" disabled="disabled">
                                            <label for="exampleInputEmail1"></label>
                                            <input type="email" class="form-control" id="" placeholder="Thời gian bảo hành: <%=pr.getProduct_insurance()%>" disabled="disabled">
                                            <label for="exampleInputEmail1"></label>
                                            <input type="email" class="form-control" id="" placeholder="Trạng thái sản phẩm: <%=pr.getStatus()%>" disabled="disabled">

                                        </div>



                                    </div>
                                    <!-- /.card-body -->
                                </form>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <div class="card card-primary ">

                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card card-success">

                            <div class="card-header">
                                <h3 class="card-title">Hình ảnh sản phẩm</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body" style="display: block">
                                <div style="position: relative">


                                    <img src="<%=pr.getImage(0)%>"alt=" "style="width: 60%;height:60%;border: 1px solid rgba(0,0,0,.125);position: relative">



                                </div>
                                <br>

                            </div>
                        </div>



                    </div>
                    <!-- /.row -->
                </div><!-- /.container-fluid -->
        </section>


        <!-- /.content -->
    </div>

    <jsp:include page="/common/admin/footer.jsp"></jsp:include>

</div>
<jsp:include page="/common/admin/js.jsp"></jsp:include>
</body>
</html>
