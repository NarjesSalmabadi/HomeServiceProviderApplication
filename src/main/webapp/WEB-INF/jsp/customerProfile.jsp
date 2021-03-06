<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <title>Expert Profile</title>
    <style>
        .pointer       { cursor: pointer; }
        .trStyle:hover {background-color:#f5f5f5;}
        .cell-breakWord {
            word-wrap: break-word;
        }
        .myTable {
            border-collapse: collapse;
            table-layout: fixed;
        }

    </style>
</head>

<body onload="getCustomer()">
<nav class="navbar navbar-expand navbar-dark bg-primary"> <a href="#menu-toggle" id="menu-toggle" class="navbar-brand"><span class="navbar-toggler-icon"></span></a> <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample02" aria-controls="navbarsExample02" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
    <div class="collapse navbar-collapse" id="navbarsExample02">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active"> <a class="nav-link" >
                <p id="userEmail"></p>
                <span class="sr-only">(current)</span></a> </li>
            <li class="nav-item active"> <a class="nav-link" href="/">صفحه اصلی <span class="sr-only">(current)</span></a> </li>
            <li class="nav-item"> <a class="nav-link" href="/logout">خروج</a> </li>
        </ul>
        <form class="form-inline my-2 my-md-0"> </form>
    </div>
</nav>
<div id="wrapper" class="toggled">
    <!-- Sidebar -->
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <li class="sidebar-brand"> <a href="/"> صفحه اصلی </a> </li>
            <li> <a href="/expertProfile">مشخصات</a> </li>
            <li> <a href="/expertProfile/newService">سفارشات</a> </li>
            <li> <a href="/expertProfile">سفارشات</a> </li>
        </ul>
    </div> <!-- /#sidebar-wrapper -->
    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div>

        </div> <!-- /#page-content-wrapper -->
    </div> <!-- /#wrapper -->
</div>
<script>
    var customerEmail;
    var customerId;

    /**********get customer email****************/
    function getCustomer(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                customerEmail=result;
                $("#userEmail").text(customerEmail)
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/customerProfile/getCustomer",
                    data: {"customerEmail":customerEmail},
                    success: function (result) {
                        customerId=result.id;
                    },
                    error: function (result) {
                        $("#myId").text(JSON.stringify(result));
                    }
                });
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }

</script>
<!-- Bootstrap core JavaScript -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script> <!-- Menu Toggle Script -->
<script>
    $(function(){
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        });

        $(window).resize(function(e) {
            if($(window).width()<=768){
                $("#wrapper").removeClass("toggled");
            }else{
                $("#wrapper").addClass("toggled");
            }
        });
    });

</script>

</body>


</html>

