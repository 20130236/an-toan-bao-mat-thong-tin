<%@ page import="model.Role" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  List<Role> roles = (List<Role>) request.getAttribute("roles");
  String error = (String) request.getAttribute("error");
  String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Thêm user</title>
  <jsp:include page="/common/admin/css.jsp"></jsp:include>
  <style>
    .error{
      float: left !important;
      color:#dc3545 !important;
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
            <h1>Thêm user </h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
              <li class="breadcrumb-item active">Thêm user </li>
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
                <form action="<c:url value="/admin-data-user?action=add"/>" method="post" id="add-user">
                  <div class="card-body">
                    <div style="display: flex" class="row">
                      <div class="form-group col-md-6">
                        <div class="form-group">
                          <span>Tên tài khoản</span>
                          <input id="username" name="username" type="text" class="form-control" placeholder="" value="">
                          <label id="username-error" class="error" for="username" style="display: inline;"></label>
                          <% if(error != null) {%>
                          <div class="error"><%=error%></div>
                          <% }%>
                        </div>
                      </div>
                      <div class="form-group col-md-6">
                        <div class="form-group">
                          <span>Họ và tên</span>
                          <input id="full_name" name="full_name" type="text" class="form-control" placeholder="" value="">
                          <label id="full_name-error" class="error" for="full_name" style="display: inline;"></label>
                        </div>
                      </div>
                      <div class="form-group col-md-6">
                        <div class="form-group">
                          <span>email</span>
                          <input id="email" name="email" type="text" class="form-control" placeholder="" value="">
                          <label id="email-error" class="error" for="email" style="display: inline;"></label>
                        </div>
                      </div>
                    </div>
                    <div style="display: flex" class="row">
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <span>Mật khẩu</span>
                          <input id="password" name="password" type="password" class="form-control" placeholder="" value="">
                          <label id="password-error" class="error" for="password" style="display: inline;"></label>
                        </div>
                      </div>
                      <div class="form-group col-md-6 ">
                        <div class="form-group">
                          <span>Quyền</span>
                          <select class="form-control" id="role" name="role">
                            <select class="form-control" id="select-role" name="role">
                              <%for (Role r : roles) {%>
                              <option value="<%=r.getId()%>"><%=r.getName()%></option>
                              <%}%>
                            </select>
                          </select>
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

          <div class="card-footer row" style="width: 100%;">
            <button type="submit" class="btn btn-primary" form="add-user" >Thêm </button>
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
<script src="<c:url value="/Template/web/libs/jquery/jquery.validate.js"/>"></script>
<script>
  $.validator.setDefaults({
    errorElement: "label",
    errorClass: "error"
  });

  +(function ($) {
    /*$("#add-user").submit(function(e) {
        e.preventDefault();
        var form = $(this);
        var actionUrl = form.attr('action');
        $.ajax({
            type: "POST",
            url: actionUrl,
            data: form.serialize(),
            success: function () {
                alert( "Thêm thành công" );
            },
            error: function (error){
                console.log(error);
            }
        });
    });*/

    /*  $("#edit-acc").submit(function(e) {
          e.preventDefault(); // avoid to execute the actual submit of the form.
          var data = {};
          var formdata = $(this).serializeArray();
          $.each(formdata,function (i,v){
              data[""+v.name+""] = v.value();
          })
          var form = $(this);
          var actionUrl = form.attr('action');
          editUser(data,actionUrl)
      });*/

    /*  function editUser(data,actionUrl){
          $.ajax({
              type: "POST",
              url: actionUrl,
              contentType: "application/json",
              dataType: "json",
              data: JSON.stringify(obj), // javacript object to json
              success: function (result){
                  console.log(result);
              },
              error: function (error){
                  console.log(error);
              }
          });
      }*/

    $("#add-user").validate({
      rules: {
        username: {
          required : true
        },
        password: {
          required: true
        },
        password_again: {
          required: true
        },
        full_name: {
          required: true
        },
        email: {
          required : true,
          email : true
        },
        phone_num: {
          required : true
        }
      },
      messages: {
        userName: {
          required : "Phải nhập tên tài khoản",
        },
        password: {
          required: "Phải nhập mật khẩu",
        },
        password_again: {
          required: "Phải nhập lại mật khẩu"
        },
        full_name: {
          required : "Phải nhập họ và tên"
        },
        email: {
          required : "Phải nhập email",
          email : "email không đúng định dạng"
        },
        phone_num: {
          required : "Phải nhập số điện thoại"
        }
        /* address: {
             required: "Phải nhập địa chỉ"
         }*/
      }
    });
  })(jQuery);
</script>

</body>
</html>
