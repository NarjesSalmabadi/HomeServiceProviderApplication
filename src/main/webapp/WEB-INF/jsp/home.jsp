<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <title>Home</title>
    <style>
        .hDiv   {height: 150px;}
    </style>
</head>
<body  onload="serviceLoad()">
<nav class="navbar navbar-expand navbar-dark bg-primary">
    <div>
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active"> <a class="nav-link" href="/">صفحه اصلی <span class="sr-only">(current)</span></a> </li>
            <li class="nav-item"> <a class="nav-link" href="/home/loginPage">ورود</a> </li>
            <li class="nav-item"> <a class="nav-link" href="/user/register">ثبت نام</a> </li>
        </ul>
        <form class="form-inline my-2 my-md-0"> </form>
    </div>
    <div>
        <ul class="navbar-nav mr-auto">
            <li class="nav-item"> <a class="nav-link" href="/logout">خروج</a> </li>
        </ul>
        <form class="form-inline my-2 my-md-0"> </form>
    </div>
</nav>
<div class="d-flex text-dark bg-info justify-content-center p-3 hDiv" style="background:transparent url('/resources/theme/images/3.jpg') no-repeat center center /cover">
    <h1>ارائه خدمات منزل</h1>
</div>
<nav class="navbar navbar-expand navbar-dark bg-light">
    <div class="btn-group" id="service">
    </div>
</nav>

<script>
    function serviceLoad() {
        var msg = "";
        var msg2 = ""
        var div = document.getElementById("service");
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/services/hasSubServices",
            async:false,
            success: function (result) {
                $.each(result, function (index, value) {
                    msg +=
                        "<div class=\"dropdown\"><button class=\"btn light dropdown-toggle\"  type=\"button\" onclick=\"dropFunc( "+value.id+ ")\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n" +
                        value.title +
                        "</button>"+"<div class=\"dropdown-menu\"  id=\"x_"+value.id+"\"></div></div>"
                });

                $(msg).appendTo("#service");
                // document.getElementById("serviceDiv").appendChild(msg);
            },
            error: function (result) {
                $("#myId").text("در حال حاضر هیچ خدمتی در سایت تعریف نشده است");
            }
        });
    }

    function dropFunc(id){
        document.getElementById("x_"+id).innerHTML="";
        var msg2="";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/services/subServices/"+id,
            success: function (result) {
                $.each(result, function (index, value) {
                    //msg2 +=
                    msg2+="<a class=\"dropdown-item\" href=\"/showSubService/"+value.id+"\">"+value.title+"</a>";
                });
                $("#x_"+id).append(msg2);
                $(msg2).appendTo(id);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }


</script>
</body>
</html>
