<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 12/4/2020
  Time: 11:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Upload Photo</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body onload="disableSubmitButton()">

<h3>Welcome, Enter The User Details</h3>


<form th:action="@{/user/uploadPhoto}" th:object="${user}" method="post" enctype="multipart/form-data">
    <div>
        <label>Photos: </label>
        <input type="file" name="image" accept="image/png, image/jpeg" />
    </div>
    <div>
        <input type="submit" value="Submit" />
    </div>
</form>
</body>
</html>
