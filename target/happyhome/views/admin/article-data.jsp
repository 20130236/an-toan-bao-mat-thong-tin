<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dach sách bài viết</title>

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
            <h1>Danh sách bài viết</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item"><a href="#">Bài viết</a></li>
              <li class="breadcrumb-item active">Danh sách bài viết</li>
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
                  <select class="form-control " >
                    <option selected="selected" disabled="disabled">Tìm kiếm theo</option>
                    <option>Bài viết mới</option>
                    <option>Bài viết cũ hot</option>
                    <option>Tin tức</option>
                    <option>Khuyến mãi</option>
                  </select>
                </div>
                <a class="btn btn-primary" href="add-post.html" style="color: white;float: right">Thêm mới</a>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                    <th>Stt </th>
                    <th>Id bài viết</th>
                    <th>Mô tả ngắn  </th>
                    <th>Tác giả</th>
                    <th>Ngày Đăng</th>
                    <th>Tác vụ</th>
                  </tr>
                  </thead>
                  <tbody>
                  <tr>
                    <td>1</td>
                    <td>tt01</td>
                    <td>Giới thiệu website</td>
                    <td>admin</td>
                    <td>10/10/2020</td>
                    <td>
                      <button class="btn btn-danger">Xoá </button>
                      <button class="btn btn-success">Sửa </button>
                    </td>
                  </tr>
                  <tr>
                    <td>2</td>
                    <td>tt02</td>
                    <td>Bài viết 01</td>
                    <td>admin</td>
                    <td>-</td>
                    <td>
                      <button class="btn btn-danger">Xoá </button>
                      <button class="btn btn-success">Sửa </button>
                    </td>
                  </tr>
                  <tr>
                    <td>3</td>
                    <td>tt03</td>
                    <td>Bài viết 02</td>
                    <td>admin</td>
                    <td>-</td>
                    <td>
                      <button class="btn btn-danger">Xoá </button>
                      <button class="btn btn-success">Sửa </button>
                    </td>
                  </tr>
                  <tr>
                    <td>4</td>
                    <td>km001</td>
                    <td>Khuyến mãi, sale sập sàn!!!!</td>
                    <td>mod</td>
                    <td>10/11/2022</td>
                    <td>
                      <button class="btn btn-danger">Xoá </button>
                      <button class="btn btn-success">Sửa </button>
                    </td>
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
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>

  <jsp:include page="/common/admin/footer.jsp"></jsp:include>

</div>
<jsp:include page="/common/admin/js.jsp"></jsp:include>
</body>
</html>