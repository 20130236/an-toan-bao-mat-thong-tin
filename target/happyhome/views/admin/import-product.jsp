<%@ page import="model.Role" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Nhập hàng</title>
    <jsp:include page="/common/admin/css.jsp"></jsp:include>
    <style>
        .error{
            float: left !important;
            color:#dc3545 !important;
        }
        .col-md-6{
            border-top: 2px solid !important;
        }

        .smart-search-wrapper {
            position: absolute;
            top: 99%;
            width: 100%;
            background: #fff;
            z-index: 100;
            right: 0;
            left: 0;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.08);
        }

        .smart-search-wrapper .item-ult {
            padding: 10px 10px;
            border-bottom: 1px dotted #dfe0e1;
            clear: both;
            width: 100%;
            float: left;
        }

        .smart-search-wrapper .item-ult .thumbs {
            width: 40px;
            display: inline-block;
            text-align: right;
        }

        .smart-search-wrapper .item-ult .title {
            width: calc(100% - 40px);
            padding-right: 15px;
            float: left;
            line-height: 20px;
            position: relative;
            margin-top: 0px !important;
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
                        <h1>Nhập hàng </h1>
                        <c:if test="${ messageResponse != null}">
                            <div class="alert-${alert}">${messageResponse}</div>
                        </c:if>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Nhập hàng </li>
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
                                <input id="search-product" oninput="searchByName(this)"  class="form-control" placeholder="tìm kiếm tên sản phẩm" >
                                <div id="product-name-search-result" class="smart-search-wrapper ajaxSearchResults" style="display: block;">
                                    <div class="resultsContent">

                                    </div>
                                </div>
                                <form  id="import-product">
                                    <div class="card-body">
                                        <div style="display: flex" class="row display-product">

                                        </div>
                                    </div>
                                    <!-- /.card-body -->
                                </form>
                            </div>
                            <!-- /.card-body -->
                        </div>
                    </div>

                    <div class="card-footer row" style="width: 100%;">
                        <button class="btn btn-primary" id="import-product-btn" >Nhập hàng</button>
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
    const  getProductByIdDataUrl = '<c:url value="/getProductById"></c:url>';
    const  searchDataUrl = '<c:url value="/searchProductName"></c:url>';
    const  importUrl = '<c:url value="/admin-import-product"></c:url>';
    const successUrl = '<c:url value="/admin-import-product?message=insert_success&alert=success"></c:url>';
    var search_result = $("#product-name-search-result .resultsContent");
    function searchByName(param) {
        var textSearch = param.value;
        $.ajax({
            type: "GET",
            url: searchDataUrl,
            data: {
                txtSearch : textSearch,
            },
            success: function (result){
                console.log(result);
                search_result.empty();
                if(result === null){
                    return;
                }
                result.forEach(function (product) {
                    search_result.append('<div class="item-ult">' +
                        '<div class="thumbs">' +
                            '<a title="' + product.name +'">' +
                                '<img style="width: 50px;height: 50px" alt="' + product.name +'" src="'+product.img1+'">' +
                            '</a>' +
                        '</div>' +
                    '<div class="title">' +
                        '<input name="id" type="hidden" value="'+ product.product_id +'">' +
                        '<a style="color: #0C1021" class="import-product-name" ">' + product.name + '</a>' +
                        '<p class="f-initial">' + product.price_sell + 'đ</p>' +
                    '</div>' +
                '</div>');
                });
                $('.import-product-name').on("click",function(){
                    var id_product = $(this).parent().find('input[type=hidden]').val();
                    var import_products = $(".display-product");
                    $.ajax({
                        type: "GET",
                        url: getProductByIdDataUrl,
                        data: {
                            id_product: id_product,
                        },
                        success: function (result) {
                            import_products.append('<div class="form-group col-md-6">' +
                                '<div class="form-group">' +
                                '<span>Tên sản phẩm</span>' +
                                '<input  name="product_name" type="text" class="form-control" disabled value="'+ result.name +'">' +
                                '<input  type="hidden" value="'+ result.product_id +'">' +
                                '<label id="username-error" class="error" style="display: inline;"></label>' +
                                '</div>' +
                                '</div>' +
                                '<div class="form-group col-md-6">' +
                                '<div class="form-group">' +
                                '<span>Số lượng sản phẩm</span>' +
                                '<input  type="number" class="form-control"  value="">' +
                                '<label id="quantity-error" class="error"  style="display: inline;"></label>' +
                                '</div>' +
                                '</div>');
                        },
                        error: function (error) {
                            console.log(error);
                        }
                    });
                })
            },
            error: function (error){
                console.log(error);
            }
        });
    }

    $("#import-product-btn").click(function () {
        if ($('.display-product').is(':empty')){
            alert("vui lòng thêm sản phẩm");
            return;
        }
        var data = {};
        //var data;
        $(".display-product")
        var ids = $('.display-product input[type=hidden]').map(function () {
            return $(this).val();
        }).get();
        var quantity = $('.display-product input[type=number]').map(function () {
            return $(this).val();
        }).get();
        data['ids'] = ids;
        data['quantities'] = quantity;
        console.log(data);
        $.ajax({
            type: "POST",
            url: importUrl,
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(data),
            success : function (result){
                console.log(result);
                window.location.href = successUrl;
            },
            error : function (error){
                console.log(error);
            },
        });
        //import_product(data);
    })

    function import_product(data){
        $.ajax({
            type: "POST",
            url: "/admin-import-product",
            contentType: "application/json",
            dataType: "json",
            data: data,
            success : function (result){
                console.log(result);
            },
            error : function (error){
                console.log(error);
            },
        });
    }

    $('#search-product').on("click",function(){
        var display_result = document.getElementById("product-name-search-result");
        display_result.style.display = 'block';
    });

    window.addEventListener('mouseup',function(event){
        var search_product = $("#search-product");
        var display_result = document.getElementById("product-name-search-result");
        if(event.target != search_product && event.target.parentNode != search_product){
            display_result.style.display = 'none';
        }
    });

    $.validator.setDefaults({
        errorElement: "label",
        errorClass: "error"
    });

    $.validator.addMethod('minQuantity', function (value, param) {
        return value < param;
    });


    +(function ($) {
        $("#import-product").validate({
            rules: {
                product_name: {
                    required : true
                },
                quantity :{
                    required : true,
                    minQuantity : 0
                }
            },
            messages: {
                product_name: {
                    required : "Phải nhập tên tài khoản",
                },
                quantity: {
                    required : "Phải nhập số lượng",
                    minQuantity : "số lượng phải lớn hơn 0"
                },
            }
        });
    })(jQuery);
</script>
</body>
</html>
