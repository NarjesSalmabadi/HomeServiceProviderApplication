<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        .hDivNull   {height: 150px;}
        .table td {text-align: center;}
        .divColor {background-color: #dcdcdc
        }
        .buttonColor {background-color: darkturquoise}
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
<center>
    <div class="hDivNull"></div>
    <div class="w-50 p-3 divColor">
        <table class="table table-borderless">
            <thead>
            <tr>
                <th scope="col" colspan="3"><h4>${subService.title}</h4></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">قیمت پایه</th>
                <td>${subService.basePrice}</td>
                <td class="align-middle" rowspan="2"><button class="btn buttonColor" onclick="openOrderModal()">سفارش</button></td>
            </tr>
            <tr>
                <th scope="row">توضیحات</th>
                <td>${subService.description}</td>
            </tr>
            </tbody>
            <tr>
                <td scope="col" colspan="3" class="text-danger">${message}</td>
            </tr>
        </table>
    </div>
</center>
<!--------------Order Modal------------------>
<div class="modal" id="orderModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">اطلاعات مورد نیاز را وارد کنید...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form:form method="POST" name="form" action="/createReservation" modelAttribute="reservation">
                    <table>
                        <tr>
                            <td><label>تاریخ</label></td>
                            <td>           </td>
                            <td><input type="date" required="required" id="dueDate" name="userDueDate"/></td>
                        </tr>
                        <tr>
                            <td><form:label path="address">آدرس</form:label></td>
                            <td>           </td>
                            <td><form:input required="required" class="form-control" id="address" path="address"/></td>
                        </tr>
                        <tr>
                            <td><form:label path="customerPrice">قیمت پیشنهادی</form:label></td>
                            <td>           </td>
                            <td><form:input required="required" class="form-control" id="customerPrice" path="customerPrice"/></td>
                        </tr>
                        <tr>
                            <td><form:label path="description">توضیحات</form:label></td>
                            <td>           </td>
                            <td><form:input required="required" class="form-control" id="description" path="description"/></td>
                        </tr>
                    </table>
                    <form:input type="hidden" id="customerEmail" path="customer.email"/>
                    <form:input type="hidden" id="subServiceId" path="subServices.id"/>
                    <input id="submit" class="btn btn-primary" type="submit" value="ثبت سفارش"/>
                </form:form>
                <button type="button" class="btn btn-danger" data-dismiss="modal">بستن</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------->
<script>
    var customerEmail;
    function openOrderModal(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                customerEmail=result;
                $("#customerEmail").val(customerEmail)
                $("#subServiceId").val(${subService.id})
            },
            error: function (result) {
            }
        });
        if(customerEmail){
            $('#orderModal').modal('show');
        }else{
            alert("برای ثبت سفارش ابتدا باید وارد سایت شوید. در صورت که حساب کاربری ندارید، لطفا ثبت نام کنید.");
        }
    }
</script>
</body>
</html>
