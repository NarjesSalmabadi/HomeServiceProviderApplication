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
            <nav class="navbar navbar-dark bg-light">
                <div   class="container row justify-content-start" id="expertSubService"></div>
            </nav>
            <center>
                <div class="w-75 p-3 justify-content-center" id="reservationDiv" style="display: none;">
                    <div  class="container">
                        <div class="row  justify-content-start">
                            <div class="col"><p  class="text-right">سفارشات جدید</p></div>
                        </div>
                    </div>
                    <table id="tb" class="table myTable" style="overflow: auto">
                        <thead class="thead-light">
                        <tr>
                            <th>شناسه سفارش</th>
                            <th>مشتری</th>
                            <th>آدرس</th>
                            <th>تاریخ</th>
                            <th>قیمت درخواستی</th>
                            <th>توضیحات</th>
                            <th>قیمت پایه</th>
                            <th>ثبت پیشنهاد</th>
                        </tr>
                        </thead>

                        <tbody >
                        </tbody>
                    </table>
                    <p id="myResult"></p>
                </div>
            </center>
            <p id="myId">${message}</p>
            <!---------DELETE Sub Service Modal--------------->
            <div class="modal" id="deleteModalSubService" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">حذف تخصص</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>آیا از حذف تخصص اطمینان دارید؟</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">خیر</button>
                            <button type="button" id="deleteSubService" class="btn btn-danger" data-dismiss="modal">بله</button>
                        </div>
                    </div>
                </div>
            </div>
            <!---------------------------------->
            <!--------suggestion Modal---------->
            <div class="modal" id="suggestionModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">اطلاعات مورد نیاز را وارد کنید...</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form:form method="POST" name="form" action="/expertProfile/createSuggestion" modelAttribute="suggestion">
                                <table>
                                    <tr>
                                        <td><label>ساعت شروع</label></td>
                                        <td>           </td>
                                        <td><input type="time" required="required" name="expertStartTime"/></td>
                                    </tr>
                                    <tr>
                                        <td><form:label path="duration">مدت زمان انجام کار (دقیقه)</form:label></td>
                                        <td>           </td>
                                        <td><form:input type="number" required="required" class="form-control" id="duration" path="duration"/></td>
                                    </tr>
                                    <tr>
                                        <td><form:label path="expertPrice">قیمت پیشنهادی</form:label></td>
                                        <td>           </td>
                                        <td><form:input required="required" class="form-control" id="expertPrice" path="expertPrice"/></td>
                                    </tr>
                                </table>
                                <form:input type="hidden" id="expertId" path="expert.id"/>
                                <form:input type="hidden" id="reservationId" path="reservation.id"/>
                                <input id="submit" class="btn btn-primary" type="submit" value="ثبت پیشنهاد"/>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
            <!------------------------------>
        </div> <!-- /#page-content-wrapper -->
    </div> <!-- /#wrapper -->
</div>
<script>
    var expertEmail;
    var expertId;

    /**********get expert email****************/
    function getExpert(){
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/username",
            success: function (result) {
                expertEmail=result;
                $("#userEmail").text(expertEmail)
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/expertProfile1/getExpert",
                    data: {"expertEmail":expertEmail},
                    success: function (result) {
                        expertId=result.id;
                        $("#customerId").val(expertId);
                        $.ajax({
                            type: "GET",
                            url: "http://localhost:8080/expertProfile1/showService/"+parseInt(expertId),
                            success: function (result) {
                                if(result) {
                                    $.each(result, function (index, value) {
                                        $('#expertSubService').append("<div class=\"dropdown\"><button   class=\"btn btn-square btn-warning example-1 dropdown-toggle\" " +
                                            "data-toggle=\"dropdown\" id='" + value.id + "'>" + value.title + " <i class='fas fa-cog'></i></button> <span> </span> <ul class=\"dropdown-menu\">\n" +
                                            "    <li><a class=\"dropdown-item pointer\" onClick=\"getReservation(" + value.id + ")\">سفارشات جدید</a></li>\n" +
                                            "    <li><a class=\"dropdown-item pointer\" onClick=\"deleteSubService(" + value.id + ")\" >حذف تخصص</a></li>\n" +
                                            "  </ul></div>");
                                    });
                                }
                                else {$("#myId").text("تخصصی برای شما ثبت نشده است.");}
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
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    }
    function deleteSubService(clicked_id){
        var subServiceId = clicked_id;
        $('#deleteModalSubService').modal('show');
        $("#deleteSubService").click(function () {
            $.ajax({
                type: "DELETE",
                url: "http://localhost:8080/expertProfile1/deleteService/" + parseInt(expertId),
                data: {"subServiceId": clicked_id},
                dataType: "json",
                success: function (value) {
                    document.getElementById(subServiceId).remove();
                },
                error: function (value) {
                    document.getElementById("myId").innerText = JSON.stringify(value.responseText);
                }
            });
        })
    }
    function getReservation(subServiceId){
        $("#reservationDiv").show();
        var msg = "";
        var table = document.getElementById("tb");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/expertProfile1/reservation/"+subServiceId,
            success: function (result) {
                if(result){
                    $.each(result, function (index, value) {
                        msg += "<tr><td>" + value.id + "</td><td>" + value.customer.firstName+" "+value.customer.lastName+ "</td><td>" + value.address+
                            "</td><td>" + value.dueDate.split('T')[0]+"</td>"+"</td><td>" + value.customerPrice+"</td>"+"</td>"+"</td><td class=\"cell-breakWord\">" + value.description+"</td>"+"</td><td>" + value.subServices.basePrice+"</td>"+
                            "<td><button type=\"button\" class=\"btn btn-success btnSelect\" onclick=\"openSuggestionModal("+value.id+")\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"پیشنهاد\">\n" +
                            " <i class=\"bi bi-pencil-fill\"></i>\n" + "</td></tr>";
                    });
                    $(msg).appendTo("#tb tbody");
                }
                else {$("#myResult").text("سفارش جدیدی برای این تخصص ثبت نشده است.");}
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result.responseText));
            }
        });
    }
    function openSuggestionModal(reservationId){
        $("#reservationId").val(reservationId);
        $('#suggestionModal').modal('show');
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

