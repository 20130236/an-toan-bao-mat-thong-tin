<%@ page import="model.Product_type" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Thêm sản phẩm mới</title>

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
            <h1>Thêm sản phẩm mới </h1>
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
      <form action="<c:url value="/admin-add_product"/>" method="post" name="editform" id="editform">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-8">
              <div class="card card-primary">
                <div class="card-header">
                  <h3 class="card-title">Thông tin chính</h3>
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
                          <label> Id </label>
                          <input type="text" class="form-control" name="id" >

                        </div>

                        <div class="form-group col-md-6 ">
                          <label>Mã sản phẩm</label>
                          <input type="text" class="form-control" name="code" >
                        </div>


                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Tên sản phẩm<span class="text-danger">(*)</span></label>
                        <input type="text" class="form-control" id="ten" name="ten" >
                      </div>
                      <div style="display: flex" class="row">
                        <div class="form-group col-md-6 ">
                          <label>Giá nhập vào</label>
                          <input type="text" class="form-control" id="gianhap" name="gianhap">
                        </div>

                        <div class="form-group col-md-6 ">
                          <label>Giá bán ra </label>
                          <input type="text" class="form-control" id="giaban" name="giaban">
                        </div>


                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Thông tin sản phẩm</label>
                      </div>
                      <div class="form-group">

                        <label for="exampleInputEmail1">Loại sản phẩm</label>
                        <select name="famille">
                          <% List<Product_type> list0 = (List<Product_type>) request.getAttribute("listType");
                            for (Product_type pty: list0
                            ) {%>
                          <option value="<%=pty.getType_id()%>" selected="selected">
                           <%=pty.getType_name()%>
                          </option>
                          <%}%>
                        </select>
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Hãng sản xuất</label>
                        <input type="text" class="form-control" id="hangsx" name="hangsx">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Màu sắc sản phẩm</label>
                        <input type="text" class="form-control" id="mausac" name="mausac">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Kích thước</label>
                        <input type="text" class="form-control" id="kichthuoc" name="kichthuoc">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Thời gian bảo hành</label>
                        <input type="text" class="form-control" id="baohanh" name="baohanh">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Thuộc tính sản phẩm</label>
                        <input type="text" class="form-control" id="thuoctinh" name="thuoctinh">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Trạng thái sản phẩm</label>
                        <input type="text" class="form-control" id="trangthai" name="trangthai">
                      </div>
                    </div>
                    <!-- /.card-body -->
                  </form>
                </div>
                <!-- /.card-body -->
              </div>
              <div class="card card-primary ">
                <div class="card-header">
                  <h3 class="card-title">
                    Nội dung mô tả sản phẩm
                  </h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                            <textarea id="summernote" name="mota" placeholder="Nhập nội dung mô tả sản phẩm">

              </textarea>
                </div>
                <div class="card-footer">
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card card-success">
                <div class="card-header">
                  <h3 class="card-title">Hình ảnh đại diện</h3>
                  <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                      <i class="fas fa-minus"></i>
                    </button>
                  </div>
                </div>
                <div class="card-body" style="display: block">
                  <br>
                  <div class="form-group" style="">
                    <label for="exampleInputFile">Tải ảnh lên</label>
                    <div class="input-group">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="">
                        <label class="custom-file-label" for="exampleInputFile">Chọn file</label>
                      </div>
                      <div class="input-group-append">
                        <span class="input-group-text">Tải lên</span>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
              </div>

            </div>


            <div class="card-footer row" style="width: 100%;">
              <button type="submit">Thêm sản phẩm</button>
            </div>


          </div>
          <!-- /.row -->
        </div><!-- /.container-fluid -->
      </form>

    </section>


    <!-- /.content -->
  </div>

  <jsp:include page="/common/admin/footer.jsp"></jsp:include>

</div>
<jsp:include page="/common/admin/js.jsp"></jsp:include>
</body>
</html>
