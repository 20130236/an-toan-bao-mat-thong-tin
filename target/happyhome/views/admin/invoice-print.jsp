<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>In hoá đơn</title>
  <jsp:include page="/common/admin/css.jsp"></jsp:include>
</head>
<body>
<div class="wrapper">
  <!-- Main content -->
  <section class="invoice">
    <div class="row">
      <div class="col-12">
        <!-- Main content -->
        <div class="invoice p-3 mb-3">
          <!-- title row -->
          <div class="row">
            <div class="col-12">
              <h4>
                Đơn hàng
                <!--<small class="float-right">Date: 2/10/2014</small>-->
              </h4>
            </div>
            <!-- /.col -->
          </div>
          <!-- info row -->
          <div class="row invoice-info">
            <div class="col-sm-4 invoice-col">
              From
              <address>
                <strong>HappyHome</strong><br>
                Địa chỉ: Đại học Nông Lâm TP.HCM<br>
                Phường Linh Trung, Q.Thủ Đức, TP.HCM.<br>
                Phone: (804) 123-5432<br>
                Email: info@almasaeedstudio.com
              </address>
            </div>
            <!-- /.col -->
            <div class="col-sm-4 invoice-col">
              To
              <address>
                <strong>Nguyễn Văn A</strong><br>
                Địa chỉ: 6/1D Khu phố 2, Linh Trung,<br>
                Phường Linh Trung, Q.Thủ Đức, TP.HCM.<br>
                Phone: 0368799134<br>
                Email: nguyenvanA@gmail.com
              </address>
            </div>
            <!-- /.col -->
            <div class="col-sm-4 invoice-col">
              <b>ID hoá đơn:</b> 4F3S8J<br><br>
              <b>Ngày lập HD</b> 2/22/2014<br>
              <b>Tài Khoản:</b> 968-34567
            </div>
            <!-- /.col -->
          </div>
          <!-- /.row -->

          <!-- Table row -->
          <div class="row">
            <div class="col-12 table-responsive">
              <table class="table table-striped">
                <thead>
                <tr>
                  <th>Số lượng</th>
                  <th>Mã sản phẩm</th>
                  <th>Tên sản phẩm</th>
                  <th>Mô tả</th>
                  <th>Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                  <td>1</td>
                  <td>SP01</td>
                  <td>Ghế xoay văn phòng lưng lưới xám GAK836</td>
                  <td>El snort testosterone trophy driving gloves handsome</td>
                  <td>300.000đ</td>
                </tr>
                <tr>
                  <td>1</td>
                  <td>SP02</td>
                  <td>Ghế xoay văn phòng lưng lưới xám GAK836</td>
                  <td>Wes Anderson umami biodiesel</td>
                  <td>300.000đ</td>
                </tr>
                <tr>
                  <td>1</td>
                  <td>SP03</td>
                  <td>Ghế xoay văn phòng lưng lưới xám GAK836</td>
                  <td>Terry Richardson helvetica tousled street art master</td>
                  <td>300.000đ</td>
                </tr>
                <tr>
                  <td>1</td>
                  <td>SP04</td>
                  <td>Ghế xoay văn phòng lưng lưới xám GAK836</td>
                  <td>Tousled lomo letterpress</td>
                  <td>300.000đ</td>
                </tr>
                </tbody>
              </table>
            </div>
            <!-- /.col -->
          </div>
          <!-- /.row -->

          <div class="row">
            <!-- accepted payments column -->
            <div class="col-6">
              <p class="lead">Phương thức thanh toán:</p>
              <img src="<c:url value="/Template/admin/dist/img/credit/visa.png"/>" alt="Visa">
              <img src=" <c:url value="/Template/admin/dist/img/credit/mastercard.png"/>" alt="Mastercard">
              <img src=" <c:url value="/Template/admin/dist/img/credit/american-express.png"/>" alt="American Express">
              <img src=" <c:url value="/Template/admin/dist/img/credit/paypal2.png"/>" alt="Paypal">

              <div style="background-color: #0000000d;padding: 5px 10px;margin-top: 10px">
                <div style="margin-top: 15px;color: red"><strong>Ghi Chú của khách hàng:</strong></div>
                <p class="" style="color:black">
                  Giao sớm giúp mình được không shop
                </p>
              </div>

            </div>
            <!-- /.col -->
            <div class="col-6">
              <p class="lead">Thành tiền</p>

              <div class="table-responsive">
                <table class="table">
                  <tr>
                    <th style="width:50%">Tổng tiền sản phẩm:</th>
                    <td>1.000.000đ</td>
                  </tr>
                  <tr>
                    <th>Thuế (9.3%)</th>
                    <td>300.000đ</td>
                  </tr>
                  <tr>
                    <th>Phí giao hàng:</th>
                    <td>50.000đ</td>
                  </tr>
                  <tr>
                    <th>Tổng tiền:</th>
                    <td>1.450.000đ</td>
                  </tr>
                </table>
              </div>
            </div>
            <!-- /.col -->
          </div>
          <!-- /.row -->

          <!-- this row will not appear when printing -->
          <div class="row no-print">
            <div class="col-12">
              <a href="invoice-print.jsp" rel="noopener" target="_blank" class="btn btn-default"><i class="fas fa-print"></i> In hoá đơn</a>

            </div>
          </div>
        </div>
        <!-- /.invoice -->
      </div><!-- /.col -->
    </div><!-- /.row -->

  </section>
  <!-- /.content -->
</div>
<!-- ./wrapper -->
<!-- Page specific script -->
<script>
  window.addEventListener("load", window.print());
</script>
</body>
</html>
