<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Expert Profile</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .pointer       { cursor: pointer; }
        .trStyle:hover {background-color:#f5f5f5;}
    </style>
</head>
<body onload="getExpert()">
<h2>
    <c:if test="${not empty expert}">
        <p>Hello ${expert.firstName} ${expert.lastName}</p>
    </c:if>

    <c:if test="${empty expert}">
        <%--        <script>var customerId="${expert.id}"</script>--%>
        <p>Hello guest</p>
    </c:if>
</h2>
<div>
    <div class="w-25 p-3">
        <p>For see sub services click on the service category:</p>
        <table id="tb" class="table" >
            <thead>
            <th>Service Code</th>
            <th>Title</th>
            </thead>

            <tbody class="pointer">

            </tbody>
        </table>
    </div>
    <br>

    <div class="w-50 p-3" id="subServiceDiv" style="display: none;">
        <p>Sub services</p>
        <table id="tb1" class="table">
            <thead>
            <th>Sub Service Code</th>
            <th>Title</th>
            <th>Base Price</th>
            <th>Description</th>
            <th>Select</th>
            </thead>

            <tbody >

            </tbody>
        </table>
        <br>
        <button id="select" class="btn btn-primary">Select</button>
    </div>

    <br>
    <p id="myId"></p>
</div>

<script>
    var expertEmail;
    var expertId;
    $( document ).ready(function() {
            var msg = "";
            // var table = document.getElementById("tb");
            // for (var i = table.rows.length - 1; i > 0; i--) {
            //     table.deleteRow(i);
            // }
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
</body>
</html>
