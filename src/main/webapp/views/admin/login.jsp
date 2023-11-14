<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin Đăng nhập</title>

  <jsp:include page="/common/admin/css.jsp"></jsp:include>
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href=""><b>HAPPYHOME</b>Admin</a>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Đăng nhập</p>
      <% if(error != null) {%>
      <div class="alert-danger"><%=error%></div>
      <% } %>
      <c:if test="${ messageResponse != null}">
        <div class="alert-${alert}">${messageResponse}</div>
      </c:if>
      <form action="<c:url value="/admin-login"/>" method="post">
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="username" id="username" placeholder="username">
          <label id="username-error" class="error" for="username" style="display: inline;"></label>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name="password" id="password" placeholder="Password">
          <label id="password-error" class="error" for="password" style="display: inline;"></label>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-4" style="margin-left: auto;margin-right: auto;">
            <button type="submit" class="btn btn-primary btn-block" style="width: 100px;">Đăng nhập</button>
          </div>
        </div>
      </form>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>
  $.validator.setDefaults({
    errorElement: "label",
    errorClass: "error"
  });

  +(function ($) {
    $("#customer-form").validate({
      rules: {
        username: {
          required : true
        },
        password: {
          required: true
        }
      },
      messages: {
        username: {
          required : "Phải nhập tên tài khoản",
        },
        password: {
          required: "Phải nhập mật khẩu",
        }
      }
    });
  })(jQuery);

</script>
</body>
</html>
