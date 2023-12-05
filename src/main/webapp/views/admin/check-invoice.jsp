<%@ page import="model.Order" %>
<%@ page import="model.Introduce" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order_detail" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="digitalsignature.CheckOrders" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<% Order order = (Order) request.getAttribute("order");
  Introduce introduce = (Introduce) request.getAttribute("info");
  ArrayList<Order_detail> order_details = (ArrayList<Order_detail>) request.getAttribute("orderDetails");
%>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Duyệt đơn hàng</title>
  <jsp:include page="/common/admin/css.jsp"></jsp:include>
<style>
  #loading-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 9999;
  }

  .spinner {
    position: absolute;
    top: 50%;
    left: 50%;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #3498db;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    animation: spin 2s linear infinite;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
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
            <h1>Duyệt đơn hàng</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
              <li class="breadcrumb-item active">Duyệt đơn hàng</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <form action="<c:url value="/check_success"/>" method="POST" name="check" id="form_check">
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-8">
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Thông tin đơn hàng</h3>
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
                          <label>ID đơn hàng</label>
                          <div class="input-group date" id="ido" data-target-input="nearest">
                            <div class="form-control"><%=order.getOder_id()%></div>
                            <input type="hidden" name="order_id" value="<%=order.getOder_id()%>">
                          </div>
                        </div>
                      </div>
                      <div class="form-group col-md-6 ">
                        <label>Tên khách hàng</label>
                        <div class="form-control"><%=order.getFullName(order.getUser_name())%></div>
                      </div>
                    </div>
                    <div style="display: flex" class="row">
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <label>Số điện thoại</label>
                          <div class="input-group date" id="reservationdate1" data-target-input="nearest">
                            <div class="form-control"><%=order.getPhoneNum()%></div>
                          </div>
                        </div>
                      </div>
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <label>Ngày đặt hàng:</label>
                          <div class="input-group date" id="reservationdate2" data-target-input="nearest">
                            <div class="form-control"><%=Order.convertDateTime(order.getDate_order().toString())%></div>
                            <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                              <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div style="display: flex" class="row">
                      <div class="form-group col-md-12 ">
                        <label>Địa chỉ giao hàng</label>
                        <div class="form-control"><%=order.getAddress()%></div>
                        <input type="hidden" name="address" id="address" class="form-control" value="<%= order.getAddress() %>">
                      </div>
                      <div class="form-group col-md-12 ">
                        <label>Mã địa chỉ giao hàng</label>
                        <div class="form-control"><%=order.getTransport()%></div>
                        <input type="hidden" name="addressId" id="addressId" class="form-control" value="<%= order.getTransport() %>">
                      </div>
                    </div>
                    <div style="display: flex" class="row">
                      <div class="form-group col-md-12 ">
                        <label>Ghi chú của khách hàng</label>
                        <div class="form-control"><%=order.getNote()%></div>
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
              <div class="card-header" >
                <h3 class="card-title">
                  Thông tin thanh toán
                </h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div style="display: flex" class="row">
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Số tiền</label>
                      <div class="input-group date" id="reservationdate4" data-target-input="nearest">
                        <div class="form-control">
                           <%=order.formatCurrency(order.getTotal_money())%>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Phí vận chuyển</label>
                      <div class="input-group date" id="reservationdate5" data-target-input="nearest">
                        <div class="form-control">
                          <%=order.formatCurrency(order.getFee())%>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div style="display: flex" class="row">
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Phương thức thanh toán</label>
                      <div class="input-group date" id="reservationdate6" data-target-input="nearest">
                        <div class="form-control"><%=order.getPayment()%></div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Thành tiền</label>
                      <div class="input-group date" id="reservationdate8" data-target-input="nearest">
                        <div class="form-control">
                         <%=order.formatCurrency(order.getFee() + order.getTotal_money())%>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div style="display: flex" class="row">
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>Duyệt đơn hàng</label>
                      <div class="input-group date" id="reservationdate12" data-target-input="nearest">
                        <select class="form-control" name="status">
                          <option value="" selected>Chọn trạng thái</option>
                          <option value="1">Duyệt đơn hàng</option>
                          <option value="3">Từ chối đơn hàng</option>
                          <option value="2">Đã giao</option>
                          <option value="4">Giao hàng thất bại</option>
                          <option value="5">Huỷ đơn hàng</option>
                          <option value="6">Huỷ đơn hàng - Đã hoàn tiền</option>

                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="form-group col-md-6 ">
                    <div class="form-group">
                      <label>&nbsp</label>
                      <div class="input-group date" id="reservationdate13" data-target-input="nearest">
                        <button type="submit" class="btn btn-primary">Xác nhận</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /.row -->

      </div><!-- /.container-fluid -->

    </section>
    </form>

    <div class="card-body">
      <h2>Danh sách sản phẩm của đơn hàng</h2>
      <table id="example1" class="table table-bordered table-striped">

        <thead>
        <tr>
          <th>ID sản phẩm</th>
          <th>Tên sản phẩm</th>
          <th>Số lượng</th>
          <th>Đơn giá</th>
        </tr>
        </thead>
        <tbody>
        <% for (Order_detail o : order_details) { %>
        <tr>
          <td><%=o.getId_product()%></td>
          <td><%=o.getName(o.getId_product())%></td>
          <td><%=o.getAmount()%>
          <td>
             <%=o.formatCurrency(o.getPrice())%>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <div id="loading-overlay">
      <div class="spinner"></div>
    </div>
    <!-- /.content -->
  </div>
  <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>
  document.getElementById("form_check").addEventListener("submit", function() {
    // Hiển thị lớp phủ
    document.getElementById("loading-overlay").style.display = "block";
  });
</script>
<script>
  $(document).ready(function() {
    var orderStatus = "<%= order.getStatus() %>";
    var orderCheck = <%=CheckOrders.checkOrderIsNotChange(order.getOder_id())%>
    console.log(orderCheck);
    $('select[name="status"] option[value="' + orderStatus + '"]').prop('selected', true);

    if(!orderCheck){

      $('select[name="status"] option[value="1"]').hide();
      $('select[name="status"] option[value="2"]').hide();
      $('select[name="status"] option[value="3"]').hide();
      $('select[name="status"] option[value="4"]').hide();

    } else if (orderStatus == 0 && orderCheck) {
      $('select[name="status"] option[value="2"]').hide();
      $('select[name="status"] option[value="5"]').hide();
      $('select[name="status"] option[value="6"]').hide();

    } else if (orderStatus == 1 && orderCheck) {

      $('select[name="status"] option[value="3"]').hide();
      $('select[name="status"] option[value="1"]').hide();
    }
    else if (orderStatus == 2 && orderCheck) {
      $('select[name="status"] option[value="3"]').hide();
      $('select[name="status"] option[value="1"]').hide();
      $('select[name="status"] option[value="2"]').hide();
      $('select[name="status"] option[value="4"]').hide();
    }  else if(orderStatus == 5){
      $('select[name="status"] option[value="3"]').hide();
      $('select[name="status"] option[value="1"]').hide();
      $('select[name="status"] option[value="2"]').hide();
      $('select[name="status"] option[value="4"]').hide();
      $('select[name="status"] option[value="5"]').hide();
      $('select[name="status"] option[value="6"]').hide();

    } else if(orderStatus == 6 && orderCheck == true){
      $('select[name="status"] option[value="3"]').hide();
      $('select[name="status"] option[value="1"]').hide();
      $('select[name="status"] option[value="2"]').hide();
      $('select[name="status"] option[value="4"]').hide();
      $('select[name="status"] option[value="5"]').hide();
      $('select[name="status"] option[value="6"]').hide();
   }
  });
</script>
</body>
</html>
