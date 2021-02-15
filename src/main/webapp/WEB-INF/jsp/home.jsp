<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <title>Home</title>
    <style>
        .hDiv   {height: 150px;}
    </style>
</head>
<body>
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
<div class="d-flex text-dark bg-info justify-content-center p-3 hDiv" style="background:transparent url('/resources/theme/images/3.jpg') no-repeat center center /cover">>
    <h1>ارائه خدمات منزل</h1>
</div>
<nav class="navbar navbar-expand navbar-dark bg-light">
    <div id="service">
    </div>
</nav>

<script>
    $(document).ready(function () {
        var msg = "";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/services",
            success: function (result) {
                if(result) {
                    $.each(result, function (index, value) {
                        $('#service').append("<button class=\"btn btn-secondary dropdown-toggle\"  type=\"button\" onclick=\"dropFunc( "+value.id+ ")\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n" +
                            value.title + "</button>"+"<div class=\"dropdown-menu\"  id=\"x_"+value.id+"\"></div>");
                    });
                }
            },
            error: function (result) {
                $("#myId").text("در حال حاضر هیچ خدمتی در سایت تعریف نشده است");
            }
        });
        $("#myId").text(" ");
        $(".dropdown-toggle").click(function(){
            //  $(this).find(".dropdown-menu").slideToggle();
            $('.dropdown-toggle').dropdown()
        });
    });

    function dropFunc(id){
        document.getElementById("x_"+id).innerHTML="";
        var msg2="";
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/services/subServices/"+id,
            success: function (result) {
                $.each(result, function (index, value) {
                    //msg2 +=
                    $("#x_"+id).append("<a class=\"dropdown-item\" href=\"/home/subService/"+value.id+"\" >"+value.title+"</a>");
                });
                $("#x_"+id).append(msg2);
                //$(msg2).appendTo(id);
                //$("#myId").innerHTML="";


                // document.getElementById("serviceDiv").appendChild(msg);
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });

    }
</script>
</body>
</html>
