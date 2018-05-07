
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="http://localhost:8080/build/Design/shipments/css/bootstrap4.css" rel="stylesheet" id="bootstrap-css">

    </head>
    <body>

<div  class="container" style="margin-top:70px; width:700px;padding:20px;">
<!-- Default form login -->
<form action="checkCustomer.jsp" method="get">
<p class="h4 text-center mb-4">Sign in</p>
<div class="container">
<!-- Default input email -->
<label for="defaultFormLoginEmailEx" class="grey-text">Your email</label>
<input type="email" name="custmer_email" id="defaultFormLoginEmailEx" class="form-control">

<br>

<!-- Default input password -->
<label for="defaultFormLoginPasswordEx" class="grey-text">Your password</label>
<input type="password" name="password" id="defaultFormLoginPasswordEx" class="form-control">

</div>
<div class="text-center mt-4">
<button class="btn btn-indigo" type="submit">Login</button>
<a class="btn btn-default" href="#" style="color: #28292b!important;">Register</a>
</div>
</form>
<!-- Default form login -->
</div>

    </body>
</html>
