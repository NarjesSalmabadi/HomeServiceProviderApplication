<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 12/4/2020
  Time: 11:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="<c:url value="/resources/theme/css/style.css"/>" rel="stylesheet">
    <title>Home</title>
    <style>
        .hDiv   {height: 150px;}
        .hDivNull   {height: 100px;}
    </style>
    <title>Register User</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<%--<body onload="disableSubmitButton()">--%>
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
    <h4>خوش آمدید. برای ثبت نام اطلاعات زیر را وارد کنید...</h4>
    <div class="p-5 bg-light w-50 justify-content-center">
    <form:form method="POST" action="/user/register" modelAttribute="user" enctype="multipart/form-data" onsubmit="return validate() ;">
        <table>
            <tr>
                <td><form:label path="firstName">نام</form:label></td>
                <td>           </td>
                <td><form:input required="required" class="form-control" id="name" path="firstName"/></td>
                <td>${firstNameMessage}</td>
            </tr>
            <tr>
                <td><form:label path="lastName">نام خانوادگی</form:label></td>
                <td>           </td>
                <td><form:input required="required" class="form-control" id="family" path="lastName"/></td>
                <td>${lastNameMessage}</td>
            </tr>
            <tr>
                <td><form:label path="email">ایمیل</form:label></td>
                <td>           </td>
                <td><form:input required="required" class="form-control" id="email" path="email"/></td>
                <td>${emailMessage}</td>
            </tr>
            <tr>
                <td><form:label path="password">رمزعبور</form:label></td>
                <td>           </td>
                <td><form:input required="required" class="form-control" id="password" path="password"/></td>
                <td>${passwordMessage}</td>
            </tr>
            <tr>
                <td>نقش کاربر</td>
                <td>           </td>
                <td><form:select path="userRole" items="${userRoleList}" id="userRole"/></td>
                <td><form:errors path="userRole" cssClass="error" /></td>
                <td><p id="userRoleEr"></p></td>
            </tr>
            <tr  id="photoDiv">
                <td><label>تصویر</label></td>
                <td>           </td>
                <td><input id="imageFile" type="file" name="image" accept="image/jpg" /></td>
                <td>${imageMessage}</td>
            </tr>
            <tr>
                <td>           </td>
                <td><input id="submit" class="btn btn-primary" type="submit" value="Submit"/></td>
            </tr>
        </table>
    </form:form>

    <%--    <button id="getAll" type="button">Get All</button>--%>
    <p id="result"></p>
    <%--    <img src="/@{${user.photoImagePath}}"  alt=""/>--%>
    </div>
</center>


<script>
    var imageFile=$("#imageFile").val();
    var userRoleValid=false;
    var emailValid;
    var passwordValid;
    var maxFileSize=true;
    var imageFormat=true;
    var nameSize;
    var familySize;

    function disableSubmitButton(){
        document.getElementById("submit").disabled = true;
    }
    $("#getAll").click( function(){
        $.ajax({
            type:"GET",
            url:"http://localhost:8080/user/allUsers",
            success :function (result){
                console.log("hello");
                console.log(result);
                console.log(result.name);
                document.getElementById("result").innerText = JSON.stringify(result);
            },
            error:function (result){
                $("#result").text(JSON.stringify(result));
            }
        });
    });
    /*************check name Input****************/
    $("#name").on("input", function () {
        if( $(this).val().length>15 && $(this).val().length===0){
            //document.getElementById("nameEr").innerText = "the size of name should upto 10!!";
            nameSize=false;
        }else{
            //document.getElementById("nameEr").innerText = "";
            nameSize=true;
        }
    });
    /*************check family Input****************/
    $("#family").on("input", function () {
        if( $(this).val().length>30 && $(this).val().length===0){
            //document.getElementById("familyEr").innerText = "the size of family should upto 20!!";
            familySize=false;
        }else{
            //document.getElementById("familyEr").innerText = "";
            familySize=true;
        }
    });

    /*************check user Role****************/
    function myFunction() {
        if($("#selectOption").val() === "-------") {
            document.getElementById("userRoleEr").innerText = "the User Role is Null!!";
            userRoleValid = false;
        }else{
            document.getElementById("userRoleEr").innerText ="";
            userRoleValid=true;
        }
        if($("#selectOption").val() !== "EXPERT" ){
            $("#photoTR").css("display", "none");
            $("#imageFile").prop('required',false);
        }else if($("#selectOption").val() === "EXPERT"){
            $("#photoTR").css("display", "block");
            $("#imageFile").prop('required',true);
        }
    }
    /*************check image size and format****************/
    $('#imageFile').bind('change', function() {
        if(this.files[0].size>512000){
            //document.getElementById("imageResult").innerText = "the size is wrong!!";
            maxFileSize=false;
        }
        else{
            //document.getElementById("imageResult").innerText ="";
            maxFileSize=true;
        }
        if (!(this.files && this.files[0] && this.files[0].name.match(/\.(jpg)$/)) ){
            //document.getElementById("imageType").innerText ="the format is wrong!";
            imageFormat=false;
        }
        else{
            document.getElementById("imageType").innerText ="";
            imageFormat=true;
        }

        //this.files[0].size gets the size of your file.

    });
    /*************check email****************/
    $("#email").on("input", function(){
        //alert("The text has been changed.");
        var email=$("#email").val();
        var name=$("#name").val();
        var family=$("#family").val();
        var password=$("#password").val();
        var userRole=$("#userRole").val();
        var arr={firstName:"name",lastName:"family",email:email,password:"123",userRole:"ADMIN",enabled:false};
        $.ajax({
            type:"POST",
            url:"http://localhost:8080/user/checkEmail",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success :function (result){
                if(result==false){ emailValid = false;
                //document.getElementById("result").innerText = "the email already exists!!";
                   }
                else {
                    emailValid = true;
                    document.getElementById("result").innerText ="";
                }
            },
            error:function (result){
               // $("#result").text(JSON.stringify(result));
            }
        });
    });

    $("#password").on("input", function(){
        var email=$("#email").val();
        var name=$("#name").val();
        var family=$("#family").val();
        var password=$("#password").val();
        var userRole=$("#userRole").val();
        var arr={firstName:"name",lastName:"family",email:"email",password:password,userRole:"ADMIN",enabled:false};
        $.ajax({
            type:"POST",
            url:"http://localhost:8080/user/checkPassword",
            data: JSON.stringify(arr),
            contentType: 'application/json; charset=utf-8',
            success :function (result){
             if(result==false){
                 passwordValid= false;
                 // document.getElementById("result").innerText = "Password must be at least 8 digits " +
                 //                                                                    "and contain letters and numbers";
                                                                                   }
             else {
                 passwordValid= true;
                 document.getElementById("result").innerText ="";
                 //document.getElementById("submit").disabled = false;
             }
            },
            error:function (result){
                // $("#result").text(JSON.stringify(result));
            }
        });
    });
    /*************validate****************/
    function validate(){
        if(userRoleValid!==false) {
            if (passwordValid === true && emailValid === true &&
                userRoleValid === true && maxFileSize===true &&
                imageFormat===true && nameSize===true && familySize===true) {
                return true;
            } else {
                if (emailValid === false && passwordValid === true) {
                    $("#email").focus();
                } else if (passwordValid === false && emailValid === true) {
                    $("#password").focus();
                } else if (passwordValid === false && emailValid === false) {
                    $("#email").focus();
                } else if (passwordValid === true && emailValid === false) {
                    $("#email").focus();
                }

                return false;
            }
            return true;
        }
        else {
            document.getElementById("result3").innerText = "the User Role is Null!!";
            return false;

        }
    }

    // $( "#userRole" ).change(function() {
    //     if ($("#userRole").val() === 'EXPERT') {
    //         $("#photoDiv").show();
    //     }else{
    //         $("#photoDiv").hide();
    //     }
    // });

</script>
</body>
</html>
