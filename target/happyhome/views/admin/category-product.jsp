<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="APIurl" value="/api-admin-category-product"/>
<%
  boolean deletePm = (boolean) request.getAttribute("deletePm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Loại sản phẩm </title>
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
            <h1>Danh sách danh mục</h1>
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
          <div class="col-md-9">
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title"></h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body" style="display: block; padding:0px ;">
                <c:if test="${success != null}">
                  <div class="alert-success" style="width: 30%">${success}</div>
                </c:if>

                <form style="padding:10px">
                  <table id="cate-product" class="table table-bordered table-striped" >
                    <thead>
                    <tr>
                      <th>Mã Danh mục </th>
                      <th>Tên Danh mục</th>
                      <th>Số sản phẩm </th>
                      <th>Tác vụ</th>
                    </tr>
                    </thead>
                    <tbody>
                      <th></th>
                      <th></th>
                      <th></th>
                      <th></th>
                    </tbody>
                    </tfoot>
                  </table>

                </form>
              </div>
              <!-- /.card-body -->
            </div>
          </div>
          <div class="col-md-3" >
            <div class="card card-success" >
              <div class="card-header">
                <h3 class="card-title">Thêm mới</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <a href="/productCate?"></a>
              <form id="add-cate" action="<c:url value="/admin-data-category"/>" method="get">
              <div class="card-body" style="display: block">
                <div class="form-group">
                  <label for="cate">Tên danh mục</label>
                  <input type="text" class="form-control" name="cate" id="cate" placeholder="">
                  <input type="hidden" name="action" value="add">
                </div>
                <button type="submit" class="btn btn-primary" form="add-cate" style="background-color: #28a745;
    border-color: #28a745;">Thêm Danh mục </button>
              </div>
              </form>
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
  const  getDataUrl = '<c:url value="/GetDataCateProduct"></c:url>';
  const  editUrl = '<c:url value="/admin-data-category?action=edit&id="></c:url>';
  var table = $('#cate-product').DataTable({
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
      {data: 'numbOfPro', name: 'numOfPro'},
      {data: 'id', name: 'action',render: function (data) {
          return '<a class="btn btn-danger btn-delete"  title="delete" ><i class="fa fa-trash"></i></a>' +
                  '<a class="btn btn-success" title="edit" href="'+ editUrl + data + '"' + '><i class="fa fa-pen" ></i>' + '</a>';
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
    if(deletePm) {
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