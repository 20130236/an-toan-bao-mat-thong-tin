<%@ page import="model.Introduce" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% Introduce in = (Introduce) request.getAttribute("info");%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Thông tin web</title>
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
            <h1>Thông tin website </h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
              <li class="breadcrumb-item active">Thông tin website</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-9">
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
                      <label for="exampleInputEmail1">Tên website</label>
                      <input type="text" class="form-control" id="exampleInputEmail1" value="<%=in.name%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Địa chỉ</label>
                      <input type="text" class="form-control" id="exampl" value="<%=in.address%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Địa chỉ showroom</label>
                      <input type="text" class="form-control" id="exampl" value="<%=in.showroom%>">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Thời gian làm việc</label>
                      <input type="text" class="form-control" id="exampl" value="<%=in.timework%>">
                    </div>
                    <div style="display: flex" class="row">
                      <div class="form-group col-md-6 ">
                        <label for="exampleInputEmail1">Email</label>
                        <input type="text" class="form-control" id="email" value="<%=in.email%>">
                      </div>
                      <div class="form-group col-md-6 ">
                        <label for="exampleInputEmail1">Số điện thoại</label>
                        <input type="text" class="form-control" id="phone" value="<%=in.phone%>">
                      </div>
                    </div>
                    <div class="form-group">
                      <label>Miêu tả website</label>
                      <textarea rows="5" class="form-control"> <%=in.introduce%></textarea>
                    </div>
                    <div class="form-group">
                      <label>Lời nhắn</label>
                      <textarea rows="5" class="form-control"> <%=in.caption%></textarea>
                    </div>
                  </div>
                  <!-- /.card-body -->
                </form>
              </div>
              <!-- /.card-body -->
            </div>
          </div>
          <div class="col-md-3" >
            <div class="card card-success" >
              <div class="card-header">
                <h3 class="card-title">Logo đại diện</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body" style="display: block">
                <img src="<c:url value="/Template/web/img/home/Logo-happyhome.PNG"/>" alt="" style="width: 100%;height:155px;border: 1px solid rgba(0,0,0,.125);">
                <br>
                <div class="form-group" style="margin-top: 10px">
                  <label for="exampleInputFile">Duyệt ảnh</label>
                  <div class="input-group">
                    <div class="custom-file">
                      <input type="file" class="custom-file-input" id="exampleInputFile">
                      <label class="custom-file-label" for="exampleInputFile">Chọn ảnh</label>
                    </div>
                    <div class="input-group-append">
                      <span class="input-group-text">Tải lên</span>
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.card-body -->
            </div>

            <div class="card card-success" >
              <div class="card-header">
                <h3 class="card-title">Logo trình duyệt</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body" style="display: block">
                <img src="<c:url value="/Template/web/img/home/Logo-happyhome-removebg-preview.png"/>" alt="" style="width: 100%;height:155px;border: 1px solid rgba(0,0,0,.125);">
                <br>
                <div class="form-group" style="margin-top: 10px">
                  <label for="exampleInputFile">Duyệt ảnh</label>
                  <div class="input-group">
                    <div class="custom-file">
                      <input type="file" class="custom-file-input" id="exampleInputFile">
                      <label class="custom-file-label" for="exampleInputFile">Chọn ảnh</label>
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
            <button class="btn btn-primary" id="btnEdit">
              Sửa thông tin
            </button>
          </div>


          <div class="modal" tabindex="-1" role="dialog" id="modalEdit">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Chỉnh sửa thông tin website</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form action="info_controller" method="post" name="editform" id="editform">
                <div class="modal-body">
                  <div class="form-group">
                    <label for="input">Tên website</label>
                    <input type="text" class="form-control" id="name" name="pname" value="<%=in.name%>">
                  </div>
                  <div class="form-group">
                    <label for="input">Địa chỉ</label>
                    <input type="text" class="form-control" id="add" name="paddress" value="<%=in.address%>">
                  </div>
                  <div class="form-group">
                    <label for="input">Địa chỉ showroom</label>
                    <input type="text" class="form-control" id="addsr" name="pshowroom" value="<%=in.showroom%>">
                  </div>
                  <div class="form-group">
                    <label for="input">Thời gian làm việc</label>
                    <input type="text" class="form-control" id="tiw" name="ptimework" value="<%=in.timework%>">
                  </div>
                  <div class="form-group">
                    <label for="input">Email</label>
                    <input type="text" class="form-control" id="eml" name="pemail" value="<%=in.email%>">
                  </div>
                  <div class="form-group">
                    <label for="input">Số điện thoại</label>
                    <input type="text" class="form-control" id="ph" name="pphone" value="<%=in.phone%>">
                  </div>
                  <div class="form-group">
                    <label for="input">Miêu tả website</label>
                    <input type="text" class="form-control" id="intro" name="pintroduce" value="<%=in.introduce%>">
                  </div>
                  <div class="form-group">
                    <label for="input">Lời nhắn</label>
                    <input type="text" class="form-control" id="cap" name="pcaption" value="<%=in.caption%>">
                  </div>


                </div>
                <div class="modal-footer">
                  <input type="button" onclick="my_submit()" class="btn btn-success" value="Lưu chỉnh sửa"></input>
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
                </form>
              </div>
            </div>
          </div>

        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<!-- ./wrapper -->
<jsp:include page="/common/admin/js.jsp"></jsp:include>

<script>
  $('#btnEdit').click(function () {
    $('#modalEdit').modal();
  })
  function is_phonenumber(phonenumber) {
    var phoneno = /^\+?([0-9]{2})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{4})$/;
    if(phonenumber.match(phoneno)) {
      return true;
    }
    else {
      return false;
    }
  }
  function is_email(email) {
    var x = email;
    var atposition = x.indexOf("@");
    var dotposition = x.lastIndexOf(".");
    if (atposition < 1 || dotposition < (atposition + 2) || (dotposition + 2) >= x.length) {
      return false;
    }else{
      return true;
    }
  }
function my_submit() {
    error ="";
    tensp = document.getElementById("name").value;
    sdt = document.getElementById("ph").value;
    email = document.getElementById("eml").value;
    diachi = document.getElementById("add").value;
    showroom = document.getElementById("addsr").value;
    tgian = document.getElementById("tiw").value;
    introo = document.getElementById("intro").value;
    capp = document.getElementById("cap").value;
    if(tensp.length == 0){
      error = "Vui lòng nhập tên";
    }
    if(diachi.length == 0){
      error = "Vui lòng nhập địa chỉ";
    }
    if(showroom.length == 0){
      error = "Vui lòng nhập địa chỉ showroom";
    }
    if(tgian.length == 0){
      error = "Vui lòng nhập thời gian làm việc";
    }
    if(introo.length == 0){
      error = "Vui lòng nhập mô tả";
    }
    if(capp.length == 0){
      error = "Vui lòng nhập lời nhắn";
    }
    if(is_phonenumber(sdt) == false){
      error = "Số điện thoại không chính xác"
    }
    if(is_email(email) == false){
      error = "Địa chỉ email không chính xác"
    }
    if(error.length > 0){
      alert(error);
      return
    }
    else{
      modalEditt = document.getElementById("editform");
      modalEditt.submit();
    }
}
</script>
</body>
</html>