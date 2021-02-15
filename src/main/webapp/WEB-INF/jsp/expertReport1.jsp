<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Search</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
</head>
<body>
<div class="d-flex text-secondary bg-info justify-content-center p-3">
    <h1>ارائه خدمات منزل</h1>
</div>
<div><p class="text-right">به منظور جستجوي متخصصان، از فيلدهاي زير استفاده كنيد</p></div>
<center>
<form>
    <div class="w-50 t-3 s-3 e-3  align-items-center">
        <table class="table">
            <tbody>
            <tr>
<%--                <th scope="row">Name</th>--%>
                <td><input id="firstName" type="text" class="form-control form-control-sm" placeholder="نام"></td>
<%--                <th>Family</th>--%>
                <td><input id="lastName" type="text" class="form-control form-control-sm" placeholder="نام خانوادگی"></td>
<%--                <th scope="row">Email</th>--%>
                <td><input id="email" type="text" class="form-control form-control-sm" placeholder="ایمیل"></td>
            </tr>
            <tr>
<%--                <th>Specialty</th>--%>
                <td><input id="specialty" type="text" class="form-control form-control-sm" placeholder="تخصص"></td>
<%--                <th scope="row">Score</th>--%>
                <td><input id="score" type="text" class="form-control form-control-sm" placeholder="امتیاز"></td>
<%--                <th>Confirmation State</th>--%>
                <td>
                    <div class="form-group">
                        <select class="form-control  form-control-sm" id="sel1">
                            <option size="sm">وضعیت</option>
                            <option size="sm">CONFIRMED</option>
                            <option size="sm">WAITING_TO_BE_CONFIRMED</option>
                        </select>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</form>
<button id="search" class="btn btn-primary">جستجو</button>

    <div class="w-75 p-3" id="expertDiv" style="display: none;">
        <table id="tb" class="table">
            <thead class="thead-light">
            <th>کدپرسنلی</th>
            <th>نام</th>
            <th>نام خانوادگی</th>
            <th>ایمیل</th>
            <th>وضعیت</th>
            <th>عکس</th>
            <th>امتیاز</th>
            <th>
                <div class="row  justify-content-start">
                    <div class="col">عملیات</div>
                    <div class="col-md-auto"><button type="button" class="btn btn-outline-secondary"  data-toggle="modal" data-target="#insertExpertModal" data-bs-toggle="tooltip" data-bs-placement="top" title="متخصص جديد">
                        <span aria-hidden="true"><i class="bi bi-person-plus-fill"></i></span></button></div>
                </div>
            </th>
            </thead>

            <tbody>

            </tbody>
        </table>
    </div>
</center>

<p id="myId"></p>

<!-------------- Confirm Expert Modal --------------->
<div class="modal" id="confirmExpertModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">تاييد متخصص</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>آيا از تاييد متخصص اطمينان داريد؟</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">انصراف</button>
                <button type="button" id="confirmExpert" class="btn btn-danger" data-dismiss="modal">تاييد</button>
            </div>
        </div>
    </div>
</div>
<!------------------------------------------>
<!-------------DELETE Expert MODAL----------------->
<div class="modal" id="deleteExpertModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">حذف متخصص</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>آيا از حذف متخصص اطمينان داريد؟</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">انصراف</button>
                <button type="button" id="deleteExpert" class="btn btn-danger" data-dismiss="modal">حذف</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------->
<!---------Show Sub Services of Expert Modal--------------->
<div class="modal fade bd-example-modal-xl" id="showSubServiceModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div  class="container">
                    <div class="row  justify-content-start">
                        <div class="col"><h5 class="modal-title">ليست تخصص ها</h5></div>
                        <%--<div class="col-md-auto"><button type="button" class="btn btn-outline-secondary"  onClick="getExpert(globalSubServiceId)" data-bs-toggle="tooltip" data-bs-placement="top" title="بارگیری مجدد">
                            <span aria-hidden="true"><i class="bi bi-arrow-clockwise"></i></span></button></div>
                        <div class="col-md-auto"><button type="button" class="btn btn-outline-secondary"  data-toggle="modal" data-target="#assignExpertToSubServiceModal" data-bs-toggle="tooltip" data-bs-placement="top" title="متخصص جديد">
                            <span aria-hidden="true"><i class="bi bi-person-plus-fill"></i></span></button></div>--%>
                    </div>
                </div>
            </div>
            <div class="modal-body">
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
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">بستن</button>
            </div>
        </div>
    </div>
</div>
<!---------------------------------->
<!--------Edit Expert MODAL--------->
<div class="modal" id="editExpertModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">اطلاعات متخصص را وارد كنيد...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <input type="text" class="form-control" id="editName" required placeholder="نام">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="editFamily" required placeholder="نام خانوادگي">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="editScore" required placeholder="امتياز">
                    </div>
                    <div class="form-group">
                        <select class="form-control  form-control-sm" id="editConfirmationState">
                            <option size="sm">وضعیت</option>
                            <option size="sm">CONFIRMED</option>
                            <option size="sm">WAITING_TO_BE_CONFIRMED</option>
                        </select>
<%--                        <label for="editConfirmationState">وضعيت</label>--%>
<%--                        <input type="text" class="form-control" id="editConfirmationState" required>--%>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="editExpert" class="btn btn-danger" data-dismiss="modal">ويرايش</button>
            </div>
        </div>
    </div>
</div>
<!------------------------------------>
<!-------DELETE Expert MODAL---------->
<div class="modal" id="deleteSubServiceModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">حذف زيرخدمت</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>آيا از حذف زيرخدمت اطمينان داريد؟</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">انصراف</button>
                <button type="button" id="deleteSubServiceFromExpert" class="btn btn-danger" data-dismiss="modal">حذف</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------->
<!--------------INSERT MODAL------------------>
<div class="modal" id="insertExpertModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">اطلاعات متخصص را وارد نمياييد</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <input type="text" class="form-control" id="insertName" required placeholder="نام">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="insertFamily" required placeholder="نام خانوادگي">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="insertEmail" required placeholder="ايميل">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="insertPassword" required placeholder="رمز عبور">
                    </div>
                </form>
                <p id="result"></p>
            </div>
            <div class="modal-footer">
                <button type="button" id="insertExpert" class="btn btn-danger" data-dismiss="modal">Create</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------->
</body>

<script>
    var globalExpertId;
    var globalSubServiceId;

    $("#tb").on('click', '.btnSelect', function () {
        // get the current row
        var currentRow = $(this).closest("tr");
        globalExpertId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
    });



    $("#search").click(function () {
        $("#expertDiv").show();
        var msg = "";
        var table = document.getElementById("tb");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        var email = $("#email").val();
        var firstName = $("#firstName").val();
        var lastName = $("#lastName").val();
        var specialty = $("#specialty").val();
        var score = $("#score").val();
        var confirmationState = null;
        if($("#sel1").val() != "وضعیت"){
            confirmationState = $("#sel1").val();
        }
        var arr = {firstName:firstName, lastName:lastName, email:email, confirmationState:confirmationState, score:score, specialties:[{title: specialty}]};
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/expert/report",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.id + "</td><td>" + value.firstName + "</td><td>" + value.lastName + "</td><td>" + value.email +
                        "</td><td>" + value.confirmationState + "</td><td>" + value.photo + "</td>" +
                        "<td>"+value.score+"</td><td><button type=\"button\" class=\"btn btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"ویرایش\">\n" +
                        " <i class=\"bi bi-pencil-fill\"></i>\n" +
                        "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"حذف\">\n" +
                        " <i class=\"bi bi-trash-fill\"></i>\n" +
                        "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-warning btnSelect\" data-toggle=\"modal\" data-target=\"#confirmExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"تایید\">\n" +
                        " <i class=\"bi bi-check-square-fill\"></i>\n" +
                        "</button> <span> </span><button type=\"button\" class=\"btn btn-primary btnSelect\" onClick=\"getSubService("+value.id+")\" data-toggle=\"modal\" data-target=\"#showSubServiceModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"تخصص ها\">\n" +
                        " <i class=\"bi bi-list-ul\"></i>\n" +
                        "</button></td></tr>";
                });
                $(msg).appendTo("#tb tbody");
                //$("#myId").text(JSON.stringify(result));
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    });

    /**************confirm expert*************/
    $("#confirmExpert").click(function () {
        var tableRow = $("table td").filter(function () {
            return $(this).text() === globalExpertId;
        }).closest("tr");
        tableRow.find("td:eq(4)").text("CONFIRMED"); // get current row 1st TD value
        $.ajax({
            type: "PUT",
            url: "http://localhost:8080/expert/" + parseInt(globalExpertId),
            success: function (result) {
                document.getElementById("myId").innerText = JSON.stringify(result);
            },
            error: function (result) {
                document.getElementById("myId").innerText = JSON.stringify(result.responseText);
            }
        });
    });
    /****************END*********************/
    /***********Delete Expert***************/
    $("#tb").on('click', '.btnSelect2', function () {
        // get the current row
        var currentRow = $(this).closest("tr");
        var expertId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
        $("#deleteExpert").click(function (){
            $.ajax({
                type:"DELETE",
                url:"http://localhost:8080/expert/"+parseInt(expertId),
                success :function (result){
                    currentRow.remove();
                    document.getElementById("myId").innerText = JSON.stringify(result);
                },
                error:function (result){
                    document.getElementById("myId").innerText = JSON.stringify(result);
                }
            });
        });
    });
    /****************END*********************/
    /*******show sub service of expert*******/
    function getSubService(clicked_id) {
        var msg="";
        var table = document.getElementById("tb1");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/expertProfile/showService/"+clicked_id,
            success: function (result) {
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.id + "</td><td>" + value.title + "</td><td>" + value.basePrice + "</td><td>" + value.description +
                        "</td>" + "<td><button  class=\"btn btn-sm btn-danger btnSelect3\" data-toggle=\"modal\" data-target=\"#deleteSubServiceModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"حذف\"><i class=\"bi bi-person-x-fill\"></i></button></td></tr>";
                });
                $(msg).appendTo("#tb1 tbody");
            },
            error: function (result) {
                document.getElementById("myId").innerText = JSON.stringify(result);
            }
        })
    }
    /****************END*********************/
    /*************Edit Expert****************/
    $("#editExpert").click(function (){
        var name = $("#editName").val();
        var family = $("#editFamily").val();
        var score = $("#editScore").val();
        var confirmationState = null;
        if($("#editConfirmationState").val() != "وضعیت"){
            confirmationState = $("#editConfirmationState").val();
        }
        var arr = {firstName:name, lastName:family, confirmationState:confirmationState, score:score};
        $.ajax({
            type:"PUT",
            url:"http://localhost:8080/expertProfile/edit/"+globalExpertId,
            data: JSON.stringify(arr),
            contentType: "application/json",
            success :function(value){
                document.getElementById("myId").innerText = JSON.stringify(value);
                var tableRow = $("table td").filter(function () {
                    return $(this).text() === globalExpertId;
                }).closest("tr");
                if(name!==""){tableRow.find("td:eq(1)").text(name);}
                if(family!==""){tableRow.find("td:eq(2)").text(family);}
                if(score!==""){tableRow.find("td:eq(6)").text(score);}
                if(confirmationState!==null){tableRow.find("td:eq(4)").text(confirmationState);}
            },
            error:function (value){
                document.getElementById("myId").innerText = JSON.stringify(value);
            }

        });

    });
    /*****************END**********************/
    /*************Delete Sub Service From Expert****************/
    $("#tb1").on('click', '.btnSelect3', function () {
        var currentRow = $(this).closest("tr");
        globalSubServiceId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
        $("#deleteSubServiceFromExpert").click(function () {
            $.ajax({
                type: "DELETE",
                url: "http://localhost:8080/expertProfile/deleteService/"+globalExpertId,
                data: {"subServiceId":globalSubServiceId},
                dataType:"json",
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
    /*************INSERT Expert in Table and DB****************/
    $("#insertExpert").click(function (){
        var name = $("#insertName").val();
        var family = $("#insertFamily").val();
        var email = $("#insertEmail").val();
        var password = $("#insertPassword").val();
        var arr = {firstName:name, lastName:family, email:email, password:password, userRole:"EXPERT", enabled:1, confirmationState:"WAITING_TO_BE_CONFIRMED", score:0};
        var tId;
        var mess="";
        $.ajax({
            type:"POST",
            url:"http://localhost:8080/expert",
            data: JSON.stringify(arr),
            contentType: "application/json",
            success :function(value){
                tId=JSON.stringify(value);
                var h=tId.match(/\d+/g);
                mess="<tr><td>"+h+"</td><td>"+name+"</td><td>"+family+"</td><td>"+email+
                    "<td> WAITING_TO_BE_CONFIRMED"+"</td><td>Not Found</td>" +
                    "<td>"+value.score+"</td><td><button type=\"button\" class=\"btn btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"ویرایش\">\n" +
                    " <i class=\"bi bi-pencil-fill\"></i>\n" +
                    "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"حذف\">\n" +
                    " <i class=\"bi bi-trash-fill\"></i>\n" +
                    "</button> <span> </span>"+"<button type=\"button\" class=\"btn btn-warning btnSelect\" data-toggle=\"modal\" data-target=\"#confirmExpertModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"تایید\">\n" +
                    " <i class=\"bi bi-check-square-fill\"></i>\n" +
                    "</button> <span> </span><button type=\"button\" class=\"btn btn-primary btnSelect\" onClick=\"getSubService("+value.id+")\" data-toggle=\"modal\" data-target=\"#showSubServiceModal\" data-bs-toggle=\"tooltip\" data-bs-placement=\"top\" title=\"تخصص ها\">\n" +
                    " <i class=\"bi bi-list-ul\"></i>\n" +
                    "</button></td></tr>";
                $(mess).appendTo("#tb tbody");
            },
            error:function (value){
                document.getElementById("myId").innerText = JSON.stringify(value);
            }

        });

    });
    /*****************END**********************/
</script>

</html>
