<%@ page import="model.UserModel" %>
<%@ page import="model.Role" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Role> roles = (List<Role>) request.getAttribute("roles");
    UserModel user = (UserModel) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sửa user</title>
    <jsp:include page="/common/admin/css.jsp"></jsp:include>
    <style>
        .button-switch {
            margin-top: 28px;
            font-size: 18px;
            height: 1.875em;
            margin-bottom: 0.625em;
            position: relative;
            width: 4.5em;
        }
        .button-switch .lbl-off,
        .button-switch .lbl-on {
            cursor: pointer;
            display: block;
            font-size: 0.9em;
            font-weight: bold;
            line-height: 1em;
            position: absolute;
            top: 0.5em;
            transition: opacity 0.25s ease-out 0.1s;
            text-transform: uppercase;
        }
        .button-switch .lbl-off {
            right: 15px;
            color: #fefefe !important;
            font-size: 14px !important;
        }
        .button-switch .lbl-on {
            color: #fefefe;
            opacity: 0;
            left: 0.4375em;
            font-size: 14px !important;
        }
        .button-switch .switch {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            height: 0;
            font-size: 1em;
            left: 0;
            line-height: 0;
            outline: none;
            position: absolute;
            top: 0;
            width: 0;
        }
        .button-switch .switch:before, .button-switch .switch:after {
            content: "";
            font-size: 1em;
            position: absolute;
        }
        .button-switch .switch:before {
            border-radius: 1.25em;
            background: #dc3545;
            height: 1.875em;
            left: -0.25em;
            top: -0.1875em;
            transition: background-color 0.25s ease-out 0.1s;
            width: 4.5em;
        }
        .button-switch .switch:after {
            box-shadow: 0 0.0625em 0.375em 0 #666;
            border-radius: 50%;
            background: #fefefe;
            height: 1.5em;
            transform: translate(0, 0);
            transition: transform 0.25s ease-out 0.1s;
            width: 1.5em;
        }
        .button-switch .switch:checked:after {
            transform: translate(2.5em, 0);
        }
        .button-switch .switch:checked ~ .lbl-off {
            opacity: 0;
        }
        .button-switch .switch:checked ~ .lbl-on {
            opacity: 1;
        }
        .button-switch .switch#switch:checked:before {
            background: #28a745;
        }

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
                        <h1>Sửa user </h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Sửa user </li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
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
                                <c:if test="${ messageResponse != null}">
                                    <div class="alert-${alert}" style="width: 36%;">${messageResponse}</div>
                                </c:if>
                                <form action="<c:url value="/admin-data-user?action=edit"/>" method="post" id="edit-user">
                                    <div class="card-body">
                                        <c:if test="${success != null}">
                                            <div class="alert-success" style="width: 36%;">${success}</div>
                                        </c:if>
                                        <div style="display: flex" class="row">
                                            <div class="form-group col-md-6 ">
                                                <div class="form-group">
                                                    <span>Tên tài khoản</span>
                                                    <div style="padding: 7px;background-color: #007bff;border: #007bff;color: #ffffff;border-radius: 3px;"><%=user.getUserName()%></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="display: flex" class="row">
                                            <div class="form-group col-md-6 ">
                                                <div class="form-group">
                                                    <span>Họ và tên</span>
                                                    <input type="text" class="form-control" name="full_name" id="full_name" value="<%=user.getFullName()==null?"":user.getFullName()%>" placeholder="">
                                                    <label id="full_name-error" class="error" for="full_name" style="display: inline;"></label>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-6 ">
                                                <div class="form-group">
                                                    <span>Email</span>
                                                    <input type="text" class="form-control" name="email" id="email" value="<%=user.getEmail()==null?"":user.getEmail()%>" placeholder="">
                                                    <label id="email-error" class="error" for="email" style="display: inline;"></label>
                                                    <input type="hidden" class="form-control" name="id" value="<%=user.getId()%>" placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                        <div style="display: flex" class="row">
                                            <div class="form-group col-md-6 ">
                                                <div class="form-group">
                                                    <span>Quyền</span>
                                                    <select class="form-control" id="select-role" name="role">
                                                        <%for (Role r : roles) {%>
                                                        <option value="<%=r.getId()%>"><%=r.getName()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-6 ">
                                                <div class="form-group">
                                                    <div class="button-switch">
                                                        <input type="checkbox" id="switch" class="switch" name="enable" />
                                                        <label for="switch" class="lbl-off">Khoá</label>
                                                        <label for="switch" class="lbl-on">Mở</label>
                                                    </div>
                                                </div>
                                                <input type="hidden" id="enable" name="enable" value="">
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
                        <button type="submit" class="btn btn-primary" form="edit-user" >Lưu thông tin</button>
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
<script type="text/javascript">
    var enable = "<%=user.getEnable()%>"
    var role = "<%=user.getRole()%>"

    if("1" === enable ){
        $("#switch").prop('checked', true);
    }

    $('#select-role option[value=role]').attr('selected','selected');
    $("#select-role").val(role).change();

    $(document).ready(function() {
        if ($('#switch').prop('checked')) {
            $(enable).val(1);
        } else {
            $(enable).val(0);
        }
    })

    $.validator.setDefaults({
        errorElement: "label",
        errorClass: "error"
    });

    +(function ($) {
        $("#edit-user").validate({
            rules: {
                username: {
                    required : true
                },
                email: {
                    required : true,
                    email : true
                },
                full_name: {
                    required : true
                },
            },
            messages: {
                username: {
                    required : "Phải nhập tên tài khoản",
                },
                email: {
                    required : "Phải nhập email",
                    email : "email không đúng định dạng"
                },
                full_name: {
                    required : "Phải nhập họ và tên"
                },
            }
        });
    })(jQuery);

</script>
</body>
</html>
