<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mashadservice.ir
  Date: 2/4/2021
  Time: 6:35 PM
  To change this template use File | Settings | File Templates.
--%>
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
    </style>
</head>



<body onload="getExpert()">
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
            <li> <a href="/expertProfile">تخصص های من</a> </li>
            <li> <a href="/expertProfile/newService">انتخاب تخصص جدید</a> </li>
            <li> <a href="/expertProfile">سفارشات</a> </li>
        </ul>
    </div> <!-- /#sidebar-wrapper -->
    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div>

            <div class="p-3">
                <p>برای مشاهده تخصص های موجود بر روی خدمت مورد نظر کلیک کنید.</p>
                <div class="w-25 p-1">
                    <table id="tb" class="table" >
                        <thead class="thead-light">
                        <th>کد خدمت</th>
                        <th>عنوان</th>
                        </thead>

                        <tbody class="pointer">

                        </tbody>
                    </table>
                </div>

                <div class="w-50 p-1" id="subServiceDiv" style="display: none;">
                    <p>زیرخدمات</p>
                    <table id="tb1" class="table">
                        <thead class="thead-light">
                        <th>کد زیرخدمت</th>
                        <th>عنوان</th>
                        <th>قیمت پایه</th>
                        <th>توضیحات</th>
                        <th>انتخاب</th>
                        </thead>

                        <tbody >

                        </tbody>
                    </table>
                    <br>
                    <button id="select" class="btn btn-primary">انتخاب</button>
                </div>

                <br>
                <p id="myId"></p>
            </div>

        </div> <!-- /#page-content-wrapper -->
    </div> <!-- /#wrapper -->
</div>
<script>
    var expertEmail;
    var expertId;
    $( document ).ready(function() {
        var msg = "";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/services",
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr  onclick=addRowHandlers()  class=\"trStyle\"><td>" + value.id + "</td><td>" + value.title+"</td>";
                });
                $(msg).appendTo("#tb tbody");
            },
            error: function (result) {
                $("#myId").text("در حال حاضر هیچ خدمتی در سایت تعریف نشده است");
            }
        });
    });
    /**********get expert email****************/
    function getExpert(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                expertEmail=result;
                $("#userEmail").text(expertEmail)
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }
    function addRowHandlers() {
        var table = document.getElementById("tb");
        var rows = table.getElementsByTagName("tr");
        for (i = 0; i < rows.length; i++) {
            var currentRow = table.rows[i];
            var createClickHandler = function(row) {
                return function() {
                    var cell = row.getElementsByTagName("td")[0];
                    var id = cell.innerHTML;
                    //alert("id:" + id);
                    $("#subServiceDiv").show();
                    var msg = "";
                    var table1 = document.getElementById("tb1");
                    for (var i = table1.rows.length - 1; i > 0; i--) {
                        table1.deleteRow(i);
                    }
                    $.ajax({
                        type: "GET",
                        url: "http://localhost:8080/services/subServices/"+id,
                        success: function (result) {
                            $.each(result, function (index, value) {
                                msg += "<tr><td>" + value.id + "</td><td>" + value.title+ "</td><td>" + value.basePrice+ "</td><td>" + value.description+"</td>"+
                                    "<td><input type=\"checkbox\" class=\"form-check-input checkbox\" id=\"check\" name=\"option\" value=\"something\"></td></tr>";
                            });
                            $(msg).appendTo("#tb1 tbody");
                        },
                        error: function (result) {
                            $("#myId").text(JSON.stringify(result));
                        }
                    });
                };
            };
            currentRow.onclick = createClickHandler(currentRow);
        }
    }

    $("#select").click(function () {
        var arrayOfRows=new Array();
        $("#tb1 input[type=checkbox]:checked").each(function () {
            arrayOfRows.push($(this).closest('tr'));
        });
        if (arrayOfRows.length == 0) {
            alert("You should select at least one item!");
        }
        else{
            var i=0;
            for(i=0;i<arrayOfRows.length;i++){
                var currentRow=arrayOfRows[i];
                var subServiceId = currentRow.find("td:eq(0)").text();
                //alert(parseInt(customerId));
                $.ajax({
                    type:"POST",
                    url:"http://localhost:8080/expertProfile1/selectService/"+expertEmail,
                    data: {"subServiceId":subServiceId},
                    dataType:"json",
                    //contentType: 'application/json; charset=utf-8',
                    success :function(value){
                        document.getElementById("myId").innerText = JSON.stringify(value.responseText);
                        document.getElementById("myId").innerText = "\n";

                    },
                    error:function (value){
                        document.getElementById("myId").append(JSON.stringify(value.responseText));
                        document.getElementById("myId").append("\n");
                    }

                });

            }
            document.getElementById("myId").innerText="";
        }
    });
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

