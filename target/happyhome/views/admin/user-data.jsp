<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  boolean deletePm = (boolean) request.getAttribute("deletePm");
%>
<c:url var="APIurl" value="/api-admin-user"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Danh sách user</title>
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
            <h1>Danh sách người dùng</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Danh sách người dùng</li>
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
                  <select class="form-control " >
                    <option selected="selected" disabled="disabled">Tìm kiếm theo</option>
                    <option>Sản Phẩm mới</option>
                    <option>Sản Phẩm hot</option>
                    <option>Hết hàng</option>
                    <option>Texas</option>
                    <option>Washington</option>
                  </select>
                </div>
                <button class="btn btn-primary" style="float: right;"><a href="<c:url value="/admin-data-user?action=add"></c:url>" style="color: white">Thêm mới</a></button>
                <button id="delete-btn" class="btn btn-danger" style="float: right;margin-right: 10px">Xoá nhiều</button>
              </div>

              <!-- /.card-body -->
              <div class="card-body">
                <c:if test="${ messageResponse != null}">
                  <div class="alert-${alert}" style="width: 36%;">${messageResponse}</div>
                </c:if>
                <table id="user-data" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                    <th>Tên tài khoản</th>
                    <th>Email</th>
                    <th>Quyền</th>
                    <th>Tình trạng</th>
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
                  <tbody>

                  </tbody>
                </table>
              </div>
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
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
  const  getDataUrl = '<c:url value="/GetDataUser"></c:url>';
  const  editUrl = '<c:url value="/admin-data-user?action=edit&id="></c:url>';
  var table  = $('#user-data').DataTable({
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
      ajax: '/GetDataUser',
      columns: [
        {data: 'userName', name: 'username'},
        {data: 'email', name: 'email'},
        {data: 'role', name: 'role'},
        {
          data: 'enable', name: 'status', render: function (data, type, row) {
            return (data === 0 ? '<i class="fa fa-minus-circle text-danger" aria-hidden="true"></i>' : '<i class="fa fa-check text-primary" aria-hidden="true"></i>')
          }
        },
        {
          data: 'id', name: 'action', render: function (data) {
            return '<a class="btn btn-danger btn-delete"  title="delete" ><i class="fa fa-trash"></i></a>' + '<a class="btn btn-success" title="edit" href="'+ editUrl + data + '"' + '><i class="fa fa-pen" ></i>' + '</a>';
          }
        },
        {
          data: 'id', name: 'action', render: function (data) {
            return '<input type="checkbox" value="' + data + '"' + '>';
          }
        },
      ]
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
        deleteUser(data,actionUrl);
      });
    });


    $('#checkAll').click(function (e) {
      $('#user-data tbody :checkbox').prop('checked', $(this).is(':checked'));
      e.stopImmediatePropagation();
    });

/*    var deletePm = ;*/
      $("#delete-btn").click(function(e) {
        //table.row.delete( $('input[type=checkbox]:checked').parents('tr')).draw().show().draw(false);
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var data = {};
        var ids = $('#user-data tbody input[type=checkbox]:checked').map(function () {
          return $(this).val();
        }).get();
        $('input[type=checkbox]:checked').parents('tr').remove();
        data['ids'] = ids;
        var actionUrl = '${APIurl}';
        console.log(JSON.stringify(data));
        deleteUser(data,actionUrl);
      });

    function deleteUser(data,actionUrl){
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