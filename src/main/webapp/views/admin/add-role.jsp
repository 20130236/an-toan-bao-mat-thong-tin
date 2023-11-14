<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Permission" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    ArrayList<Permission> permissions = (ArrayList<Permission>) request.getAttribute("permissions");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<c:url var="APIurl" value="/api-admin-role"/>
<c:url var="ROLEurl" value="/admin-role-data"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm role</title>
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
                            <li class="breadcrumb-item active">Thêm role </li>
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
                                <form action="<c:url value="/admin-role-data?action=add"/>" method="post" id="add-role">
                                    <div class="card-body">
                                        <c:if test="${ messageResponse != null}">
                                            <div class="alert-${alert}" style="width: 36%;">${messageResponse}</div>
                                        </c:if>
                                        <div style="display: flex" class="row">
                                            <div class="form-group col-md-6">
                                                <div class="form-group">
                                                    <span>Tên quyền</span>
                                                    <input id="role_name" name="title" type="text" class="form-control" placeholder="" value="">
                                                    <label id="role_name-error" class="error" for="role_name" style="display: inline;"></label>
                                                    <input type="hidden" name="id">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                                   <div class="card-body" id="permiss">
                                        <div style="display: flex" class="row">
                                            <div class="form-group col-md-6 ">
                                                <% for(Permission permiss : permissions){%>
                                                <div class="custom-control custom-checkbox">
                                                    <input class="custom-control-input" type="checkbox" name="permiss<%=permiss.getId()%>" id="customCheckbox<%=permiss.getId()%>" value="<%=permiss.getId()%>">
                                                    <label for="customCheckbox<%=permiss.getId()%>" class="custom-control-label"><%=permiss.getName()%></label>
                                                </div>
                                                <% }%>
                                            </div>
                                            <% if(success != null) {%>
                                            <div class="form-group col-md-6 ">
                                                <div class="form-group">
                                                    <div class="alert-success"><%=success%></div>
                                                </div>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>
                                    <!-- /.card-body -->
                            <!-- /.card-body -->
                        </div>
                    </div>

                    <div class="card-footer row" style="width: 100%;">
                        <button type="submit" class="btn btn-primary" id="add-role-btn">Thêm </button>
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

    $("#add-role-btn").click(function(e) {
        if(   $("#add-role").valid())
        {
            e.preventDefault(); // avoid to execute the actual submit of the form.
            var data = {};
            var formdata = $('#add-role').serializeArray();
            $.each(formdata,function (i,v){
                data[""+v.name+""] = v.value;
            })
            var ids = $('#permiss input[type=checkbox]:checked').map(function () {
                return $(this).val();
            }).get();
            data['idPermissions'] = ids;
            var actionUrl = '${APIurl}';
            addRole(data,actionUrl);
        }
      });

     function addRole(data,actionUrl){
          $.ajax({
              type: "POST",
              url: actionUrl,
              contentType: "application/json",
              dataType: "json",
              data: JSON.stringify(data), // javacript object to json
              success: function (result){
                  window.location.href = "${ROLEurl}?message=insert_success";
              },
              error: function (error){
                  console.log(error);
                  window.location.href = "${ROLEurl}?action=add&message=error_system";
              }
          });
      }

    /*$("#add-role").submit(function(e) {
        //var data = {};
        var ids = $('#permiss input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        //data['ids'] = ids;
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var form = $(this);
        var actionUrl = form.attr('action');
        $.ajax({
            type: "POST",
            url: actionUrl,
            data: form.serialize() + 'ids' + ids,
        });
    });*/

    +(function ($) {

        $("#add-role").validate({
            rules: {
                name: {
                    required : true
                },
            },
            messages: {
                name: {
                    required : "Phải nhập tên quyền",
                },
            }
        });
    })(jQuery);
</script>

</body>
</html>
