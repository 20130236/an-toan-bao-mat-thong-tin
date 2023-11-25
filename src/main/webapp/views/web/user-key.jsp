<%@ page import="model.UserModel" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    UserModel user = (UserModel) request.getAttribute("user");
    String success = (String) request.getAttribute("success");
%>
<html>
<!-- user-acount11:10-->
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Tạo Khóa</title>
    <link rel="icon" type="image/x-icon" href="/Template/web/img/home/Logo-happyhome-removebg-preview.png">
    <meta name="keywords" content="Furniture, Decor, Interior">
    <meta name="description" content="Furnitica - Minimalist Furniture HTML Template">
    <meta name="author" content="tivatheme">

    <!-- Mobile Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <jsp:include page="/common/web/css.jsp"></jsp:include>
    <style>
        .error{
            float: left !important;
            color:#dc3545 !important;
        }
        input[type="radio"]{
            opacity: 0;
            left: 28px;
            position: relative;
            cursor: pointer;
        }

        input[type="radio"]:checked~.design {
            background: #434343;
        }
        .design {
            width: 29px;
            height: 11px;
            border-radius: 50%;
            outline-offset: 3px;
            outline: 2px solid #888888;
            margin-right: 10px;
            margin-top: 5px;
        }
    </style>
</head>

<body class="user-acount">
<jsp:include page="/common/web/header.jsp"></jsp:include>

<!-- main content -->
<div class="main-content">
    <div class="wrap-banner">

        <!-- breadcrumb -->
        <nav class="breadcrumb-bg">
            <div class="container no-index">
                <div class="breadcrumb">
                    <ol>
                        <li>
                            <a href="home">
                                <span>Trang chủ</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>Tạo Khóa</span>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
        </nav>

        <div class="acount head-acount">
            <div class="container">
                <div id="main">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <form role="form" class="ng-pristine ng-valid">
                                <div class="form-group">
                                    <label for="keySize">Chọn độ dài khóa</label>
                                    <select class="form-control input-lg ng-pristine ng-valid ng-touched" name="keySize" id="keySize">
                                        <option value="512">515 bit</option>
                                        <option value="1024">1024 bit</option>
                                        <option value="2048">2048 bit</option>
                                        <option value="3072">3072 bit</option>
                                        <option value="4096">4096 bit</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <button id="btn-generateKey" class="btn btn-primary" name="generateKey" >Tạo khóa
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="privateKey">
                            <div class="form-group">
                                <a id="download-privateKey" class="btn btn-primary"
                                   download
                                   href="">
                                    <i class="fa fa-download" aria-hidden="true"></i>
                                    <span>Tải khóa</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<jsp:include page="/common/web/footer.jsp"></jsp:include>
<jsp:include page="/common/web/js.jsp"></jsp:include>

<script>

    $("#btn-generateKey").on("click",function (e){
        e.preventDefault();
        let data = {
            keySize :  $("#keySize").val()
        }
        console.log(data);
        getFilePrivateKey(data);
    });

    function getFilePrivateKey(data) {
        $.ajax({
            type: "POST",
            url: 'http://localhost:8080/api/user/key',
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                console.log(data);
                $("#download-privateKey").attr("href",data.path);
                alert("Tạo key thành công bạn có thể tải về");
            },
            error: function (error){
                alert("lỗi khi tạo key");
                console.log(error);
            }
        })
    }

</script>
</body>
</html>