<%@ page import="java.util.List" %>
<%@ page import="model.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    boolean deletePm = (boolean) request.getAttribute("deletePm");
%>
<c:url var="APIurl" value="/api-admin-role"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách quyền</title>
    <jsp:include page="/common/admin/css.jsp"></jsp:include>
    <style>
        input[type='checkbox']{
            width: 18px;
            height: 18px;
        }

        .btn-danger{
            margin-right: 9px !important;
        }

        fa{
            font-size: 16px !important;
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
                        <h1>Danh sách các quyền</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Danh sách danh mục</li>
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
                        <div class="card ">
                            <div class="card-header">
                                <button class="btn btn-primary" style="float: right;"><a href="<c:url value="/admin-role-data?action=add"></c:url>" style="color: white">Thêm mới</a></button>
                                <button id="delete-btn" class="btn btn-danger" style="float: right;margin-right: 10px">Xoá nhiều</button>
                            </div>
                            <div class="card-body" style="display: block; padding:0px ;">
                                <c:if test="${ messageResponse != null}">
                                    <div class="alert-${alert}" style="width: 36%;">${messageResponse}</div>
                                </c:if>
                                <form style="padding:10px">
                                    <table id="role-data" class="table table-bordered table-striped" >
                                        <thead>
                                        <tr>
                                            <th>Mã quyền </th>
                                            <th>Tên quyền</th>
                                            <th>Số tài khoản</th>
                                            <th>Tác vụ</th>
                                            <th><input type="checkbox" id="checkAll"></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form>
                            </div>
                            <!-- /.card-body -->
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
    <a href="<c:url value="/GetDataRole"></c:url>"></a>
</div>
<!-- ./wrapper -->

<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>
    const getDataUrl =  '<c:url value="/GetDataRole"></c:url>';
    const editUrl =  '<c:url value="/admin-role-data?action=edit&id="></c:url>';
    const deleteUrl =  '<c:url value="/admin-role-data?action=delete&id="></c:url>';

    var table = $('#role-data').DataTable({
        processing: true,
        serverSide: true,
        select: true,
        "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"],
        "paging": true,
        "lengthChange": false,
        "lengthChange": false,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true,
        ajax: getDataUrl,
        columns:[
            {data: 'id', name: 'id'},
            {data: 'name', name: 'name'},
            {data: 'numUser', name: 'numUser'},
            {data: 'id', name: 'action',render: function (data) {
                    return '<a class="btn btn-danger btn-delete"  title="delete href="'+ deleteUrl + data + '"' + '><i class="fa fa-trash"></i></a>' +
                        '<a class="btn btn-success" title="edit" href="' + editUrl + data + '"' + '><i class="fa fa-pen" ></i>' + '</a>';
                }},
            {data: 'id', name: 'id',render: function (data) {
                    return '<input type="checkbox" value="'+ data + '"' +'>';
                }},
        ]
    });

    $('#checkAll').click(function (e) {
        $('#role-data tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

    $("#delete-btn").click(function(e) {

        //table.row.delete( $('input[type=checkbox]:checked').parents('tr')).draw().show().draw(false);
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var data = {};
        var ids = $('#role-data tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        $('input[type=checkbox]:checked').parents('tr').remove();
        data['ids'] = ids;
        var actionUrl = '${APIurl}';
        deleteRole(data,actionUrl);
    });

    table.on( 'draw', function () {
        $(".btn-delete").click(function (e) {
            $(this).parents('tr').remove();
            let data ={};
            let id = [];
            id.push($(this).parents('tr').find("input").val());
            $(this).parents('tr').remove();
            data['ids'] = id;
            let actionUrl = '${APIurl}';
            deleteRole(data,actionUrl);
        });
    });

    function deleteRole(data,actionUrl){
        var deletePm = <%=deletePm%>;
        if(!deletePm) {
            alert("you don't have this permission");
            return;
        }
        $.ajax({
            type: "DELETE",
            url: actionUrl,
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(data), // javacript object to json
            success: function (result){
                //window.location.href = "/data-user?message=delete_success";
                alert("xoá thành công");
            },
            error: function (error){
                console.log(error);
                alert("đã có lỗi xảy ra");
                //window.location.href = "/data-user?message=error_system";
            }
        });
    }

</script>
</body>
</html>