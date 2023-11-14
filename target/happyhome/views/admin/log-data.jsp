<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="APIurl" value="/api-admin-log"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách theo dõi hoạt động trong hệ thống</title>
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
                        <h1>Danh sách log</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Danh sách log</li>
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
                                    <select class="form-control ">
                                        <option selected="selected" disabled="disabled">Tìm kiếm theo</option>
                                        <option>Sản Phẩm mới</option>
                                        <option>Sản Phẩm hot</option>
                                    </select>

                                </div>
                            </div>

                            <!-- /.card-header -->
                            <div class="card-body">
                                <table id="log-data" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>UserId</th>
                                        <th>Level</th>
                                        <th>Src</th>
                                        <th>Date </th>
                                        <%--<th>ipAddress</th>--%>
                                        <%--<th><input type="checkbox" id="checkAll"></th>--%>
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
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- modal -->
            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <jsp:include page="/common/admin/footer.jsp"></jsp:include>
</div>
<!-- ./wrapper -->
<jsp:include page="/common/admin/js.jsp"></jsp:include>
<script>
    const  getDataUrl = '<c:url value="/GetDataLog"></c:url>';
    var table = $('#log-data').DataTable({
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
        ajax: '<c:url value="/GetDataLog"></c:url>',
        columns:[
            {data: 'userId', name: 'userId'},
            {data: 'level', name: 'level'},
            {data: 'src', name: 'src'},
            {data: 'creatAt', name: 'creatAt'},
        ]
    });

    $('#checkAll').click(function (e) {
        $('#log-data tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

    //var deletePm =
    $("#delete-btn").click(function(e) {
        //table.row.delete( $('input[type=checkbox]:checked').parents('tr')).draw().show().draw(false);
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var data = {};
        var ids = $('#log-data tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        $('input[type=checkbox]:checked').parents('tr').remove();
        data['ids'] = ids;
        var actionUrl = '${APIurl}';
        deleteLog(data,actionUrl);
    });

    function deleteLog(data,actionUrl){
        $.ajax({
            type: "DELETE",
            url: actionUrl,
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(data), // javacript object to json
            success: function (result){
                alert("delete success");
                //window.location.href = "/data-user?message=delete_success";
            },
            error: function (error){
                console.log(error);
                alert("error");
                //window.location.href = "/data-user?message=error_system";
            }
        });
    }
</script>
</body>
</html>