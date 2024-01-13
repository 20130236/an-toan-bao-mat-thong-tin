<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Thêm đơn hàng</title>
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
            <h1>Thêm đơn hàng </h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
              <li class="breadcrumb-item active">Thêm đơn hàng</li>
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
                    <div style="display: flex" class="row">
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <label>Họ</label>
                          <input type="text" class="form-control " data-target="#reservationdate" placeholder="">
                        </div>
                      </div>
                      <div class="form-group col-md-6 ">
                        <label for="exampleInputEmail1">Tên</label>
                        <input type="text" class="form-control" id="" placeholder="">
                      </div>
                    </div>

                    <div style="display: flex" class="row">
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <label>Email</label>
                          <div class="input-group "  data-target-input="nearest">
                            <input type="text" class="form-control " placeholder="">
                          </div>
                        </div>
                      </div>
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <label>Số điện thoại</label>
                          <div class="input-group date" >
                            <input type="number" class="form-control "  placeholder="">
                          </div>
                        </div>
                      </div>
                    </div>

                    <div style="display: flex" class="row">
                      <div class="form-group col-md-12 ">
                        <label for="exampleInputEmail1">Địa chỉ giao hàng</label>
                        <input type="text" class="form-control " placeholder="">
                      </div>
                    </div>


                    <div style="display: flex" class="row">
                      <div class="form-group col-md-12 ">
                        <label for="exampleInputEmail1">Ghi chú của khách hàng</label>
                        <textarea class="form-control"> </textarea>
                      </div>
                    </div>


                    <div style="display: flex" class="row">
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <label>Ngày đặt hàng:</label>
                          <div class="input-group date" id="reservationdate" data-target-input="nearest">
                            <input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" placeholder="13/11/2022">
                            <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                          </div>
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

          <div class="col-md-4">
            <div class="card card-success ">
              <div class="card-header">
                <h3 class="card-title">
                  Sản phẩm
                </h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div style="display: flex" class="row">
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Sản phẩm</label>
                      <div class="input-group date" id="reservationdate21" data-target-input="nearest">
                        <input type="text" class="form-control " data-target="#reservationdate" placeholder="">
                      </div>
                    </div>
                  </div>
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Số lượng</label>
                      <div class="input-group date" id="reservationdate22" data-target-input="nearest">
                        <input type="number" class="form-control " data-target="#reservationdate" placeholder="">
                      </div>
                    </div>
                  </div>
                </div>
                <div style="display: flex" class="row">
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Đơn giá</label>
                      <div class="input-group date" id="reservationdate23" data-target-input="nearest">
                        <input type="text" class="form-control " data-target="#reservationdate" placeholder="">
                      </div>
                    </div>
                  </div>
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Thành tiền</label>
                      <div class="input-group date" id="reservationdate24" data-target-input="nearest">
                        <input type="text" class="form-control " data-target="#reservationdate" placeholder="">
                      </div>
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>

          <div class="card-footer row" style="width: 100%;">
            <button type="submit" class="btn btn-primary">Thêm đơn hàng</button>
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
