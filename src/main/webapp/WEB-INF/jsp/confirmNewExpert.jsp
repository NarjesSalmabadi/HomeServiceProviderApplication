<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 12/4/2020
  Time: 11:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Confirm New Expert</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="d-flex text-secondary bg-info justify-content-center p-3">
    <h1>Welcome ...</h1>
</div>

<div>
    <br>
    <button id="getAll" class="btn btn-primary">See All Experts</button>
    <button type="button" id="insertBtn" class="btn btn-primary" data-toggle="modal" data-target="#insertModal">Add New
        Expert
    </button>
    <br>

    <div class="w-75 p-3">
        <table id="tb" class="table">
            <thead>
            <th>Personnel Code</th>
            <th>Name</th>
            <th>Family</th>
            <th>Email</th>
            <th>Confirmation State</th>
            <th>Image</th>
            <th>Operation</th>
            </thead>

            <tbody>

            </tbody>
        </table>
    </div>

    <br>
    <p id="myId"></p>
</div>

<script>
    var globalTicketId;

    $("#getAll").click(function () {
        var msg = "";
        var table = document.getElementById("tb");
        for (var i = table.rows.length - 1; i > 0; i--) {
            table.deleteRow(i);
        }
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/expert",
            success: function (result) {
                console.log("salam");
                $.each(result, function (index, value) {
                    msg += "<tr><td>" + value.id + "</td><td>" + value.firstName + "</td><td>" + value.lastName + "</td><td>" + value.email +
                        "<td>" + value.confirmationState + "</td><td>" + value.photo + "</td>" +
                        "<td><button class=\"btn btn-sm btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editModal\">Confirm</button>" +
                        "<button  class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteModal\">Delete</button></td></tr>";
                });
                $(msg).appendTo("#tb tbody");
            },
            error: function (result) {
                $("#myId").text(JSON.stringify(result));
            }
        });
    });

    $("#tb").on('click', '.btnSelect', function () {
        // get the current row
        var currentRow = $(this).closest("tr");
        globalTicketId = currentRow.find("td:eq(0)").text(); // get current row 1st TD value
    });
</script>

<!-------------- Confirm Modal --------------->
<div class="modal" id="editModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Confirm Expert</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are You Sure You Want to Confirm the Expert?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="confirmExpert" class="btn btn-danger" data-dismiss="modal">Confirm</button>
            </div>
        </div>
    </div>
</div>
<!-------------------------------------------->
<!--------------INSERT MODAL------------------>
<div class="modal" id="insertModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Enter New Information Please...</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="insertName">Name</label>
                        <input type="text" class="form-control" id="insertName" required>
                    </div>
                    <div class="form-group">
                        <label for="insertFamily">Family</label>
                        <input type="text" class="form-control" id="insertFamily" required>
                    </div>
                    <div class="form-group">
                        <label for="insertEmail">Email</label>
                        <input type="text" class="form-control" id="insertEmail" required>
                    </div>
                    <div class="form-group">
                        <label for="insertPassword">Password</label>
                        <input type="text" class="form-control" id="insertPassword" required>
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
<!---------DELETE MODAL--------------->
<div class="modal" id="deleteModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are You Sure You Want to Remove the Expert?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteExpert" class="btn btn-danger" data-dismiss="modal">Remove</button>
            </div>
        </div>
    </div>
</div>

<!---------------------------------->
<script>
    /**************confirm expert*************/
    $("#confirmExpert").click(function () {
        var tableRow = $("table td").filter(function () {
            return $(this).text() === globalTicketId;
        }).closest("tr");
        tableRow.find("td:eq(4)").text("CONFIRMED"); // get current row 1st TD value
        $.ajax({
            type: "PUT",
            url: "http://localhost:8080/expert/" + parseInt(globalTicketId),
            success: function (result) {
                document.getElementById("myId").innerText = JSON.stringify(result);
            },
            error: function (result) {
                document.getElementById("myId").innerText = JSON.stringify(result.responseText);
            }
        });
    });
    /****************END*********************/

    /*************check email****************/
    $("#insertEmail").on("input", function () {
        //alert("The text has been changed.");
        var email = $("#insertEmail").val();
        var name = $("#name").val();
        var family = $("#family").val();
        var password = $("#password").val();
        var arr = {firstName: "name", lastName: "family", email: email, password: "123", userRole: "ADMIN", enabled: false};
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/user/checkEmail",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                if (result == false) {
                    document.getElementById("result").innerText = "the email already exists!!";
                } else {
                    document.getElementById("result").innerText = "";
                }
            },
            error: function (result) {
            }
        });
    });

    /*************check password****************/
    $("#insertPassword").on("input", function () {
        var email = $("#insertEmail").val();
        var name = $("#name").val();
        var family = $("#family").val();
        var password = $("#insertPassword").val();
        var arr = {
            firstName: "name",
            lastName: "family",
            email: "email",
            password: password,
            userRole: "ADMIN",
            enabled: false
        };
        $.ajax({
            type: "POST",
            url: "http://localhost:8080/user/checkPassword",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success: function (result) {
                if (result == false) {
                    document.getElementById("result").innerText = "Password must be at least 8 digits " +
                        "and contain letters and numbers";
                } else {
                    document.getElementById("result").innerText = "";
                    document.getElementById("submit").disabled = false;
                }
            },
            error: function (result) {
            }
        });
    });

    /*************INSERT Expert in Table and DB****************/
    $("#insertExpert").click(function (){
        var name = $("#insertName").val();
        var family = $("#insertFamily").val();
        var email = $("#insertEmail").val();
        var password = $("#insertPassword").val();
        var arr = {firstName:name, lastName:family, email:email, password:password, userRole:"EXPERT", enabled:1, confirmationState:"WAITING_TO_BE_CONFIRMED"};
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
                    "<td> \"WAITING_TO_BE_CONFIRMED\""+"</td><td>Not Found</td>" +
                    "<td><button class=\"btn btn-sm btn-success btnSelect\" data-toggle=\"modal\" data-target=\"#editModal\">Confirm</button>" +
                    "<button class=\"btn btn-sm btn-danger btnSelect2\" data-toggle=\"modal\" data-target=\"#deleteModal\">Delete</button></td></tr>";

                $(mess).appendTo("#tb tbody");

            },
            error:function (value){
                document.getElementById("myId").innerText = JSON.stringify(value);
            }

        });

    });
    /*****************END**********************/

    /***Delete With ID in table and DB****/
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
</script>


</body>
</html>


