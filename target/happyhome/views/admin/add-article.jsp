<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đăng bài viết giới thiệu sản phẩm</title>

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
            <h1>Đăng bài viết giới thiệu sản phẩm - Quảng Cáo </h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
              <li class="breadcrumb-item active">Đăng bài viết</li>
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
                  <div class="form-group">
                    <label for="exampleInputEmail1">Tên bài viết</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Tên bài viết tối đa 35 kí tự">
                  </div>
                  <div class="form-group">
                    <label for="">Nội dung tóm tắt</label>
                    <textarea rows="5" class="form-control" placeholder="Nội dung tóm tắt không được quá 100 kí tự"> </textarea>
                  </div>

                  <div style="display: flex" class="row">
                    <div class="form-group col-md-6 ">
                      <div class="form-group">
                        <label>Date:</label>
                        <div class="input-group date" id="reservationdate" data-target-input="nearest">
                          <input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" placeholder="22/02/2020">
                          <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="form-group col-md-6 ">
                      <label for="exampleInputEmail1">Tài khoản đăng</label>
                      <input type="text" class="form-control" id="" placeholder="Tên bài viết tối đa 35 kí tự">
                    </div>
                  </div>
                  <div class=" row" style="display: flex">
                    <div class="form-group col-md-6 " style="text-align: left">
                      <label for="exampleCheck1">Kiểm duyệt bài viết</label>
                      <div>
                        <input type="checkbox" class="" id="exampleCheck1">
                        <label class="form-check-label" for="exampleCheck1">Kiểm duyệt</label>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
              </form>
            </div>
            <!-- /.card-body -->
          </div>
          </div>
          <div class="col-md-4" >
          <div class="card card-success" >
            <div class="card-header">
              <h3 class="card-title">Hình ảnh đại diện</h3>
              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body" style="display: block">
              <img src="<c:url value="/Template/admin/dist/img/1.jpg"/>" alt="" style="width: 100%;height:344px;border: 1px solid rgba(0,0,0,.125);">
              <br>
              <div class="form-group" style="margin-top: 10px">
                <label for="exampleInputFile">Hình ảnh tải lên</label>
                <div class="input-group">
                  <div class="custom-file">
                    <input type="file" class="custom-file-input" id="exampleInputFile">
                    <label class="custom-file-label" for="exampleInputFile">Chọn file</label>
                  </div>
                  <div class="input-group-append">
                    <span class="input-group-text">Tải lê<nav>  </nav></span>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.card-body -->
          </div>
          </div>

          <div class="col-md-12">
            <div class="card card-primary ">
              <div class="card-header" >
                <h3 class="card-title">
                  Nội dung bài viết
                </h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                    <textarea id="summernote">
                Place <em>some</em> <u>text</u> <strong>here</strong>
              </textarea>
              </div>
              
            </div>
          </div>

          <div class="card-footer row" style="width: 100%;">
            <button type="submit" class="btn btn-primary">Đăng bài viết</button>
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
