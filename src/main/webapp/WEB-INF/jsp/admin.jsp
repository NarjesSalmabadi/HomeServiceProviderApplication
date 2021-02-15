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
    <title>Admin Profile</title>
    <style>
        .example-1:focus {

            /* Adds a white border around the button, along with a blue glow. The white and blue have a color contrast ratio of at least 3:1, which means this will work against any background color. */
            box-shadow: 0 0 0 2px #ffffff, 0 0 3px 5px #f9ef3a;

            /* NOTE: box-shadow is invisible in Windows high-contrast mode, so we need to add a transparent outline, which actually does show up in high-contrast mode. */
            outline: 2px dotted transparent;
            outline-offset: 2px;
        }
        .pointer    { cursor: pointer; }
        .hDiv   {height: 150px;}
    </style>
    <!------ Include the above in your HEAD tag ---------->
</head>



<body>
<nav class="navbar navbar-expand navbar-dark bg-primary"> <a href="#menu-toggle" id="menu-toggle" class="navbar-brand"><span class="navbar-toggler-icon"></span></a> <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample02" aria-controls="navbarsExample02" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
    <div class="collapse navbar-collapse" id="navbarsExample02">
        <ul class="navbar-nav mr-auto">
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
            <li class="sidebar-brand"> <a href="/"> صفحه اصلي </a> </li>
            <li> <a href="/admin">مديريت خدمات</a> </li>
            <li> <a href="/admin/expertReport">مديريت متخصصان</a> </li>
            <li> <a href="/admin/userReport">مديريت مشتريان</a> </li>
        </ul>
    </div> <!-- /#sidebar-wrapper -->
    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div>
            <nav class="navbar navbar-dark bg-light">
                <div   class="container row justify-content-start" id="service">
                </div>
                <div>
                    <button class="btn btn-outline-warning" data-toggle="modal" data-target="#insertModalService">خدمت جديد</button>
                </div>

            </nav>
            <br>
            <center>
                <div class="w-75 p-3 justify-content-center" id="subServiceDiv" style="display: none;">
                    <div  class="container">
                        <div class="row  justify-content-start">
                            <div class="col"><p  class="text-right">زيرخدمت ها</p></div>
                            <div class="col-md-auto"><button type="button" class="btn btn-outline-secondary"  data-toggle="modal" data-target="#insertModalSubService">زيرخدمت جديد</button></div>

                        </div>
                    </div>
                    <table id="tb1" class="table" style="overflow: auto">
                        <thead class="thead-light">
                        <tr>
                            <th>کد زیرخدمت</th>
                            <th>عنوان</th>
                            <th>قیمت پایه</th>
                            <th>توضیحات</th>
                            <th>عملیات</th>
                        </tr>
                        </thead>

                        <tbody >

                        </tbody>
                    </table>
                </div>
            </center>
            <p id="myId"></p>
        </div>

        <!--------------INSERT Service------------------>
        <div class="modal" id="insertModalService">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">اطلاعات خدمت را وارد کنید...</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <input type="text" class="form-control" id="insertServiceName" required placeholder="عنوان خدمت">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="insertService" class="btn btn-danger" data-dismiss="modal">ایجاد</button>
                    </div>
                </div>
            </div>
        </div>
        <!-------------------------------------------->
        <!--------------Edit Service------------------>
        <div class="modal" id="editModalService">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">عنوان جديد خدمت را وارد کنید...</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <input type="text" class="form-control" id="editServiceName" required placeholder="عنوان خدمت">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="editService" class="btn btn-danger" data-dismiss="modal">ويرايش</button>
                    </div>
                </div>
            </div>
        </div>
        <!-------------------------------------------->
        <!---------DELETE Service Modal--------------->
        <div class="modal" id="deleteModalService" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">حذف خدمت</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>آیا از حذف خدمت اطمینان دارید؟ با حذف خدمت، تمامي زيرخدمات مربوطه نيز حذف خواهند شد!</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">خیر</button>
                        <button type="button" id="deleteService" class="btn btn-danger" data-dismiss="modal">بله</button>
                    </div>
                </div>
            </div>
        </div>

        <!---------------------------------->
        <!--------------INSERT Sub Service------------------>
        <div class="modal" id="insertModalSubService">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">اطلاعات زیرخدمت را وارد کنید...</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <%--<div class="form-group">
                                <label for="insertServiceName1">Service Name</label>
                                <input type="text" class="form-control" id="insertServiceName1" required>
                            </div>--%>
                            <div class="form-group">
                                <input type="text" class="form-control" id="insertSubServiceName" required placeholder="عنوان">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="insertPrice" required placeholder="قيمت پايه">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="insertDescription" required placeholder="توضيحات">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="insertSubService" class="btn btn-danger" data-dismiss="modal">ایجاد</button>
                    </div>
                </div>
            </div>
        </div>
        <!-------------------------------------------->
        <!--------------Edit Sub Service Modal------------------>
        <div class="modal" id="editSubServiceModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">

                        <h4 class="modal-title">اطلاعات جديد زیرخدمت را وارد کنید...</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <input type="text" class="form-control" id="editName" required placeholder="عنوان">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="editPrice" required placeholder="قيمت پايه">
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="editDescription" required placeholder="توضيحات">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="editSubService" class="btn btn-danger" data-dismiss="modal">ویرایش</button>
                    </div>
                </div>
            </div>
        </div>
        <!-------------------------------------------->
        <!---------DELETE Sub Service Modal--------------->
        <div class="modal" id="deleteSubServiceModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">حذف زیرخدمت</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>آیا از حذف زیرخدمت اطمینان دارید؟ این زیرخدمت از تخصص های متخصصین و سفارش های مشتریان حذف خواهد شد!</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">خیر</button>
                        <button type="button" id="deleteSubService" class="btn btn-danger" data-dismiss="modal">بله</button>
                    </div>
                </div>
            </div>
        </div>
        <!---------------------------------->
        <!---------Show Experts of Sub Service Modal--------------->
        <div class="modal fade bd-example-modal-xl" id="showExpertModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div  class="container">
                            <div class="row  justify-content-start">
                                <div class="col"><h5 class="modal-title">ليست متخصصان</h5></div>
                                <div class="col-md-auto"><button type="button" class="btn btn-outline-secondary"  onClick="getExpert(globalSubServiceId)" data-bs-toggle="tooltip" data-bs-placement="top" title="بارگیری مجدد">
                                    <span aria-hidden="true"><i class="bi bi-arrow-clockwise"></i></span></button></div>
                                <div class="col-md-auto"><button type="button" class="btn btn-outline-secondary"  data-toggle="modal"
                                                                 data-target="#assignExpertToSubServiceModal" data-bs-toggle="tooltip" onclick="showAllExpert()"
                                                                 data-bs-placement="top" title="متخصص جديد">
                                    <span aria-hidden="true"><i class="bi bi-person-plus-fill"></i></span></button></div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                        <table id="tb" class="table">
                            <thead class="thead-light">
                            <th>كدپرسنلی</th>
                            <th>نام</th>
                            <th>نام خانوداگی</th>
                            <th>ایمیل</th>
                            <th>وضعیت</th>
                            <th>تصویر</th>
                            <th>گزینه ها</th>
                            </thead>

                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">بستن</button>
                    </div>
                </div>
            </div>
        </div>

        <!---------------------------------->
        <!--------------Assign Expert To SubService Modal------------------>
        <div class="modal" id="assignExpertToSubServiceModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">متخصص مورد نظر را انتخاب کنید</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <select id="sel_user" class="myClass" name="myClass">
                            <option value="0">- Select -</option>
                        </select>
                        <%--                <form>--%>
                        <%--                    <div class="form-group" id="selectExpertDropDown">--%>
                        <%--                    </div>--%>
                        <%--                </form>--%>
                        <%--                <form>--%>
                        <%--                    <div class="form-group">--%>
                        <%--                        <input type="text" class="form-control" id="expertCode" required>--%>
                        <%--                    </div>--%>
                        <%--                </form>--%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">انصراف</button>
                        <button type="button" id="assignExpertToSubService" class="btn btn-danger" data-dismiss="modal">ایجاد</button>
                    </div>
                </div>
            </div>
        </div>
        <!-------------------------------------------->
        <!---------DELETE Expert from SubService MODAL--------------->
        <div class="modal" id="deleteExpertModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>آیا از حذف متخصص اطمینان دارید؟</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">خیر</button>
                        <button type="button" id="deleteExpertFromSubService" class="btn btn-danger" data-dismiss="modal">بله</button>
                    </div>
                </div>
            </div>
        </div>

        <!---------------------------------->
        <script>
            var globalServiceId;
            var globalSubServiceId;
            var globalExpertId;
            var expertEmail;

            $("#tb1").on('click', '.btnSelect', function () {
                // get the current row
                var currentRow = $(this).closest("tr");
                globalSubServiceId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
            });

            // $("#tb").on('click', '.btnSelect2', function () {
            //     var currentRow = $(this).closest("tr");
            //     globalExpertId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
            //     currentRow.remove();
            // });
            /*************Show Services****************/
            $(document).ready(function () {
                var msg = "";
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/services",
                    success: function (result) {
                        if(result) {
                            $.each(result, function (index, value) {
                                $('#service').append("<div class=\"dropdown\"><button   class=\"btn btn-square btn-warning example-1 dropdown-toggle\" " +
                                    "data-toggle=\"dropdown\" id='" + value.id + "'>" + value.title + " <i class='fas fa-cog'></i></button> <span> </span> <ul class=\"dropdown-menu\">\n" +
                                    "    <li><a class=\"dropdown-item pointer\" onClick=\"getSubService(" + value.id + ")\">زيرخدمات</a></li>\n" +
                                    "    <li><a class=\"dropdown-item pointer\" onClick=\"editService(" + value.id + ")\" >ويرايش</a></li>\n" +
                                    "    <li><a class=\"dropdown-item pointer\" onClick=\"deleteService(" + value.id + ")\" >حذف</a></li>\n" +
                                    "  </ul></div>");
                            });
                        }
                        //$(msg).appendTo("#tb tbody");
                    },
                    error: function (result) {
                        $("#myId").text("در حال حاضر هیچ خدمتی در سایت تعریف نشده است");
                    }
                });
                $("#myId").text(" ");
            });
            /*************Show Sub Services****************/
            function getSubService(clicked_id)
            {
                globalServiceId = clicked_id;  //get service id for insert subService.
                $("#subServiceDiv").show();
                var msg = "";
                var table1 = document.getElementById("tb1");
                for (var i = table1.rows.length - 1; i > 0; i--) {
                    table1.deleteRow(i);
                }
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/services/subServices/"+clicked_id,
                    success: function (result) {
                        $.each(result, function (index, value) {
                            msg += "<tr><td>" + value.id + "</td><td>" + value.title+ "</td><td>" + value.basePrice+ "</td><td>" + value.description+"</td>"+
                                "<td><button type=\"button\" class=\"btn btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editSubServiceModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"ویرایش\">\n" +
                                " <i class=\"bi bi-pencil-fill\"></i>\n" +
                                "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-danger btnSelect3\"  data-toggle=\"modal\" data-target=\"#deleteSubServiceModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"حذف\">\n" +
                                " <i class=\"bi bi-trash-fill\"></i>\n" +
                                "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-warning btnSelect\" onClick=\"getExpert("+value.id+")\" data-toggle=\"modal\" data-target=\"#showExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"متخصصان\">\n" +
                                " <i class=\"bi bi-person-fill\"></i>\n" +
                                "</button></td></tr>";
                        });
                        $(msg).appendTo("#tb1 tbody");
                    },
                    error: function (result) {
                        $("#myId").text(JSON.stringify(result));
                    }
                });
            }
            /*************INSERT Service****************/
            $("#insertService").click(function () {
                var serviceName = $("#insertServiceName").val();
                var arr = {title: serviceName, category: {title: serviceName}};
                var txt;
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8080/services/newService",
                    data: JSON.stringify(arr),
                    contentType: "application/json",
                    success: function (value) {
                        txt=JSON.stringify(value);
                        var serviceId=txt.match(/\d+/g);
                        $('#service').append("<div class=\"dropdown\"><button   class=\"btn btn-square btn-warning example-1 dropdown-toggle\" " +
                            "data-toggle=\"dropdown\" id='" + serviceId + "'>" + serviceName + " <i class='fas fa-cog'></i></button> <span> </span> <ul class=\"dropdown-menu\">\n" +
                            "    <li><a class=\"dropdown-item pointer\" onClick=\"getSubService(" + serviceId + ")\">زيرخدمات</a></li>\n" +
                            "    <li><a class=\"dropdown-item pointer\" onClick=\"editService(" + serviceId + ")\" >ويرايش</a></li>\n" +
                            "    <li><a class=\"dropdown-item pointer\" onClick=\"deleteService(" + serviceId + ")\" >حذف</a></li>\n" +
                            "  </ul></div>");
                        document.getElementById("myId").innerText = JSON.stringify(value);
                    },
                    error: function (value) {
                        document.getElementById("myId").innerText = JSON.stringify(value);
                    }
                });
            });
            /*****************END**********************/
            /*************Edit Services****************/
            function editService(clicked_id)
            {
                globalServiceId = clicked_id;
                $('#editModalService').modal('show');
                $("#editService").click(function () {
                    var serviceName = $("#editServiceName").val();
                    var arr = {title: serviceName};
                    $.ajax({
                        type: "PUT",
                        url: "http://localhost:8080/services/editService/"+globalServiceId,
                        data: JSON.stringify(arr),
                        contentType: "application/json",
                        success: function (value) {
                            document.getElementById("myId").innerText = JSON.stringify(value);
                            document.getElementById(globalServiceId).firstChild.data = serviceName;
                        },
                        error: function (value) {
                            document.getElementById("myId").innerText = JSON.stringify(value);
                        }
                    });
                })
            }
            /*************Delete Services****************/
            function deleteService(clicked_id)
            {
                globalServiceId = clicked_id;  //get service id for insert subService.
                $('#deleteModalService').modal('show');
                $("#deleteService").click(function () {
                    $.ajax({
                        type: "DELETE",
                        url: "http://localhost:8080/services/deleteService/"+globalServiceId,
                        success: function (value) {
                            document.getElementById("myId").innerText = JSON.stringify(value);
                            document.getElementById(globalServiceId).remove();
                        },
                        error: function (value) {
                            document.getElementById("myId").innerText = JSON.stringify(value);
                        }
                    });
                })

            }
            /*************INSERT Sub Service****************/
            $("#insertSubService").click(function () {
                var serviceName = document.getElementById(globalServiceId).innerText;
                var subServiceName = $("#insertSubServiceName").val();
                var price = $("#insertPrice").val();
                var description = $("#insertDescription").val();
                var arr = {
                    title: subServiceName,
                    basePrice: price,
                    description: description,
                    subCategory: {title: subServiceName},
                    services: {id: globalServiceId}
                };
                var txt;
                var mess="";
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8080/services/newSubService",
                    data: JSON.stringify(arr),
                    contentType: "application/json",
                    success: function (value) {
                        txt=JSON.stringify(value);
                        var subServiceId=txt.match(/\d+/g);
                        document.getElementById("myId").innerText = JSON.stringify(value);
                        mess = "<tr><td>" + subServiceId + "</td><td>" + subServiceName+ "</td><td>" + price+ "</td><td>" + description+"</td>"+
                            "<td><button type=\"button\" class=\"btn btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editSubServiceModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"ویرایش\">\n" +
                            " <i class=\"bi bi-pencil-fill\"></i>\n" +
                            "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-danger btnSelect3\"  data-toggle=\"modal\" data-target=\"#deleteSubServiceModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"حذف\">\n" +
                            " <i class=\"bi bi-trash-fill\"></i>\n" +
                            "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-warning btnSelect\" onClick=\"getExpert("+subServiceId+")\" data-toggle=\"modal\" data-target=\"#showExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"متخصصان\">\n" +
                            " <i class=\"bi bi-person-fill\"></i>\n" +
                            "</button></td></tr>";
                        $(mess).appendTo("#tb1 tbody");
                    },
                    error: function (value) {
                        document.getElementById("myId").innerText = JSON.stringify(value);
                    },
                });

            });
            /*****************END**********************/
            /*************Edit Sub Service****************/
            $("#editSubService").click(function () {
                var name = $("#editName").val();
                var price = $("#editPrice").val();
                var description = $("#editDescription").val();
                var arr = {
                    title: name,
                    basePrice: price,
                    description: description,
                };
                $.ajax({
                    type: "PUT",
                    url: "http://localhost:8080/services/editSubService/"+globalSubServiceId,
                    data: JSON.stringify(arr),
                    contentType: "application/json",
                    success: function (value) {
                        var tableRow = $("table td").filter(function () {
                            return $(this).text() === globalSubServiceId;
                        }).closest("tr");
                        if(name !== ""){tableRow.find("td:eq(1)").text(name);}
                        if(price !== ""){tableRow.find("td:eq(2)").text(price);}
                        if(description !== ""){tableRow.find("td:eq(3)").text(description);}
                    },
                    error: function (value) {
                        document.getElementById("myId").innerText = JSON.stringify(value);
                    }
                });
            });
            /*****************END**********************/
            /*************Delete Sub Service****************/
            $("#tb1").on('click', '.btnSelect3', function () {
                var currentRow = $(this).closest("tr");
                globalSubServiceId = currentRow.find("td:eq(0)").text();
                $("#deleteSubService").click(function () {
                    $.ajax({
                        type: "DELETE",
                        url: "http://localhost:8080/services/deleteSubService/" + globalSubServiceId,
                        contentType: "application/json",
                        success: function (value) {
                            document.getElementById("myId").innerText = JSON.stringify(value);
                            currentRow.remove();
                        },
                        error: function (value) {
                            document.getElementById("myId").innerText = JSON.stringify(value);
                        }
                    });
                });
            });
            /*****************END**********************/
            /*************Show experts of a Sub Service****************/
            function getExpert(clicked_id) {
                var msg="";
                var table = document.getElementById("tb");
                for (var i = table.rows.length - 1; i > 0; i--) {
                    table.deleteRow(i);
                }
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/services/subServices/showExpert/"+clicked_id,
                    success: function (result) {
                        $.each(result, function (index, value) {
                            msg += "<tr><td>" + value.id + "</td><td>" + value.firstName + "</td><td>" + value.lastName + "</td><td>" + value.email +
                                "<td>" + value.confirmationState + "</td><td>" + value.photo + "</td>" +
                                "<td><button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"حذف\"><i class=\"bi bi-person-x-fill\"></i></button></td></tr>";
                        });
                        $(msg).appendTo("#tb tbody");
                    },
                    error: function (result) {
                        document.getElementById("myId").innerText = JSON.stringify(result);
                    }
                })
            }
            /*************Assign Expert to Sub Service****************/
            $("#assignExpertToSubService").click(function () {
                var expertId = $("#expertCode").val();
                var msg ="";
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8080/expertProfile1/selectService/"+expertEmail,
                    data: {"subServiceId":globalSubServiceId},
                    dataType:"json",
                    success: function (value) {
                        document.getElementById("myId").innerText = JSON.stringify(value.responseText);
                        document.getElementById("myId").innerText = "\n";
                        $.ajax({
                            type: "GET",
                            url: "http://localhost:8080/expert/"+expertId,
                            success: function (value) {
                                alert(value.firstName);
                                msg += "<tr><td>" + value.id + "</td><td>" + value.firstName + "</td><td>" + value.lastName + "</td><td>" + value.email +
                                    "<td>" + value.confirmationState + "</td><td>" + value.photo + "</td>" +
                                    "<td><button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" " +
                                    "data-target=\"#deleteExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" " +
                                    "title=\"حذف\"><i class=\"bi bi-person-x-fill\"></i></button></td></tr>";
                                $(msg).appendTo("#tb tbody");
                            },
                            error: function (value) {
                                $("#myId").text(JSON.stringify(value));
                            }
                        });
                    },
                    error: function (value) {
                        document.getElementById("myId").innerText = JSON.stringify(value);
                        document.getElementById("myId").innerText = "\n";
                    }
                });
            });
            /*************Delete Expert From Sub Service****************/
            $("#tb").on('click', '.btnSelect2', function () {
                var currentRow = $(this).closest("tr");
                globalExpertId = currentRow.find("td:eq(0)").text();
                $("#deleteExpertFromSubService").click(function () {
                    $.ajax({
                        type: "DELETE",
                        url: "http://localhost:8080/expertProfile1/deleteService/" + globalExpertId,
                        data: {"subServiceId": globalSubServiceId},
                        dataType: "json",
                        success: function (value) {
                            currentRow.remove();
                            document.getElementById("myId").innerText = JSON.stringify(value.responseText);
                        },
                        error: function (value) {
                            document.getElementById("myId").innerText = JSON.stringify(value.responseText);
                        }
                    });
                });
            });
            /*****************END**********************/
            function getExpertById() {
                var ms ="";
                var expertId = $("#expertCode").val();
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/expert/"+expertId,
                    success: function (value) {
                        alert(value.firstName);
                        ms += "<tr><td>" + value.id + "</td><td>" + value.firstName + "</td><td>" + value.lastName + "</td><td>" + value.email +
                            "<td>" + value.confirmationState + "</td><td>" + value.photo + "</td>" +
                            "<td><button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" " +
                            "data-target=\"#deleteExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" " +
                            "title=\"حذف\"><i class=\"bi bi-person-x-fill\"></i></button></td></tr>";
                        $(ms).appendTo("#tb tbody");
                    },
                    error: function (value) {
                        $("#myId").text(JSON.stringify(value));
                    }
                });
            }
            /*****************END**********************/
            function showAllExpert(){
                $.ajax({
                    type: "GET",
                    url: "http://localhost:8080/expert/confirmedAndEnabled",
                    success: function (result) {
                        console.log("salam");
                        var len = result.length;
                        $("#sel_user").empty();
                        $("#sel_user").append("<option>-------</option>");
                        for( var i = 0; i<len; i++){
                            var id = result[i]['id'];
                            var name = result[i]['firstName'];
                            var family = result[i]['lastName'];
                            var email = result[i]['email'];
                            $("#sel_user").append("<option value='"+email+"'>"+id+" "+name+" "+family+"</option>");}
                    },
                    error: function (result) {
                        $("#myId").text(JSON.stringify(result));
                    }
                });
            }
            var sel = document.getElementById('sel_user');
            //var lbl = document.getElementById('myLbl');
            sel.onchange = function(){
                expertEmail = this.options[this.selectedIndex].value;
            };
            // function getExpertEmail(email){
            //     expertEmail = email;
            //     alert(expertEmail);
            // }
        </script>
    </div> <!-- /#page-content-wrapper -->
</div> <!-- /#wrapper -->
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
