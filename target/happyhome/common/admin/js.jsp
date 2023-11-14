<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 29/11/2022
  Time: 8:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jQuery -->
<script src="<c:url value="/Template/admin/plugins/jquery/jquery.min.js"/>"></script>
<!-- Bootstrap -->
<script src="<c:url value="/Template/admin/plugins/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
<!-- AdminLTE -->
<script src="<c:url value="/Template/admin/dist/js/adminlte.js"/>"></script>
<!-- OPTIONAL SCRIPTS -->
<script src="<c:url value="/Template/admin/plugins/chart.js/Chart.min.js"/>"></script>
<!-- AdminLTE for demo purposes -->
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="<c:url value="/Template/admin/dist/js/pages/dashboard3.js"/>"></script>

<script src="<c:url value="/Template/admin/plugins/summernote/summernote-bs4.min.js"/>"></script>
<!-- jQuery -->
<script src="<c:url value="/Template/admin/plugins/jquery/jquery.min.js"/>"></script>
<!-- Bootstrap 4 -->
<script src="<c:url value="/Template/admin/plugins/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
<!-- bs-custom-file-input -->
<script src="<c:url value="/Template/admin/plugins/bs-custom-file-input/bs-custom-file-input.min.js"/>"></script>
<!-- AdminLTE App -->
<script src="<c:url value="/Template/admin/dist/js/adminlte.min.js"/>"></script>
<!-- Page specific script -->
<script src="<c:url value="/Template/admin/plugins/summernote/summernote-bs4.min.js"/>"></script>
<!-- Datatables -->
<script src="<c:url value="/Template/admin/plugins/datatables/jquery.dataTables.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-responsive/js/dataTables.responsive.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-buttons/js/dataTables.buttons.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/jszip/jszip.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/pdfmake/pdfmake.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/pdfmake/vfs_fonts.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-buttons/js/buttons.html5.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-buttons/js/buttons.print.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/datatables-buttons/js/buttons.colVis.min.js"/>"></script>

<!-- Select2 -->
<script src="<c:url value="/Template/admin/plugins/select2/js/select2.full.min.js"/>"></script>
<!-- InputMask -->
<script src="<c:url value="/Template/admin/plugins/moment/moment.min.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/inputmask/jquery.inputmask.min.js"/>"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="<c:url value="/Template/admin/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"/>"></script>
<script src="<c:url value="/Template/web/libs/jquery/jquery.validate.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/daterangepicker/daterangepicker.js"/>"></script>
<script src="<c:url value="/Template/admin/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"/>"></script>
<script>
  $(function () {
    bsCustomFileInput.init();
  });

  $(function () {
    // Summernote
    $('#summernote').summernote()

    // CodeMirror
    CodeMirror.fromTextArea(document.getElementById("codeMirrorDemo"), {
      mode: "htmlmixed",
      theme: "monokai"
    });
  })

  $(".mt-2").find('[href*="' + window.location.pathname.split('/')[4] + '"]').addClass('active');
  $(".mt-2").find('[href*="' + window.location.pathname.split('/')[4] + '"]').parents(".nav-item").addClass('menu-open');

  $(".nav-item").click(function () {
    if ($(this).hasClass("menu-open")) {
      $(this).removeClass('menu-open')
    } else {
      $(this).addClass('menu-open')
    }
  });

  $(function () {
    //Initialize Select2 Elements
    $('.select2').select2()

    //Initialize Select2 Elements
    $('.select2bs4').select2({
      theme: 'bootstrap4'
    })

    //Date picker
    $('#reservationdate').datetimepicker({
      format: 'L'
    });
  })

  $(function () {
    $("#example1").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false,
      "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
      "responsive": true,
    });
  });

  $(function () {
    $(".btn-default").click(function () {
      $(this).parent().remove();
    });
  });

</script>
