<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: mashadservice.ir
  Date: 2/3/2021
  Time: 1:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <title>Home/Login</title>
    <style>
        .hDiv   {height: 150px;}
        .hDivNull   {height: 100px;}
        /*.formH {height: 50%;}*/
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
<center>
    <div class="hDivNull"></div>
    <div class="p-5 bg-light w-25 formH justify-content-center">
        <form method="post" name="form" action="/doLogin"  >
            <div>
                <div class="form-group" >
                    <input type="email" class="form-control" id="email" name="email"  aria-describedby="emailHelp" placeholder="ایمیل" required="true"/>
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" id="password" name="password"  placeholder="رمزعبور" required="true"/>
                </div>
                <%--        <div class="form-check">--%>
                <%--            <input type="checkbox" class="form-check-input" id="exampleCheck1">--%>
                <%--            <label class="form-check-label" for="exampleCheck1">Check me out</label>--%>
                <%--        </div>--%>
                <button type="submit" id="submit" class="btn btn-primary">ورود</button>
            </div>
        </form>
        <small id="emailHelp" class="form-text text-muted"><p>${login_error}</p></small>
    </div>
</center>





</body>
</html>
