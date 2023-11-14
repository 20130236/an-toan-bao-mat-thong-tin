<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="APIurl" value="/api-admin-product"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách sản phẩm</title>
    <jsp:include page="/common/admin/css.jsp"></jsp:include>
    <style>
        input[type='checkbox']{
            width: 18px;
            height: 18px;
        }
    </style>
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
                        <h1>Danh sách nhập hàng</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Danh sách nhập hàng</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header" style="margin-top: 10px;margin-bottom: -10px">
                                <div class="form-group" style="width: 50%;float: left">
                                    <select class="form-control ">
                                        <option selected="selected" disabled="disabled">Tìm kiếm theo</option>
                                        <option>Sản Phẩm mới</option>
                                        <option>Sản Phẩm hot</option>
                                    </select>

                                </div>
                                <button class="btn btn-primary" style="float: right;"><a href="<c:url value="/admin-import-product"/>" style="color: white">Nhập hàng</a></button>
                            </div>

                            <!-- /.card-header -->
                            <div class="card-body">
                                <table id="product-data" class="table table-bordered table-striped">

                                    <thead>
                                    <tr>
                                        <th>Id sản phẩm</th>
                                        <th>Tên User</th>
                                        <th>Số lượng</th>
                                        <th>Ngày nhập</th>
                                    </tr>
                                    </thead>

                                    <tbody>

                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                    </tbody>

                                </table>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- modal -->
            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<!-- ./wrapper -->
<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>
    const  getDataUrl = '<c:url value="/GetDataImportProduct"></c:url>';
    var table = $('#product-data').DataTable({
        processing: true,
        serverSide: true,
        select: true,
        "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"],
        "paging": true,
        "lengthChange": false,
        "lengthChange": false,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true,
        ajax: getDataUrl,
        columns:[
            {data: 'pro_id', name: 'product_id'},
            {data: 'username', name: 'username'},
            {data: 'quantity', name: 'quantity'},
            {data: 'date', name: 'date'},
        ]
    });

</script>
</body>
</html>