<%--
    Document   : shipmentType
    Created on : Mar 24, 2018, 10:53:53 AM
    Author     : foush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>

      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>JSP Page</title>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
      <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
      <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

      <!--     Fonts and icons     -->
      <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

      <link rel="stylesheet" href="../Design/shipments/css/shipmentType.css" />
    <body>



      <div class="container">
      	<div class="row">
      		<div class="paymentCont">
      						<div class="headingWrap">
      								<h3 class="headingTop text-center">Select Your Payment Method</h3>
      								<p class="text-center">Created with bootsrap button and using radio button</p>
      						</div>
      						<div class="paymentWrap">
      							<div class="btn-group paymentBtnGroup btn-group-justified" data-toggle="buttons">
      					            <label class="btn paymentMethod active">
      					            	<div class="method visa"></div>
      					                <input type="radio" name="options" checked>
      					            </label>
      					            <label class="btn paymentMethod">
      					            	<div class="method master-card"></div>
      					                <input type="radio" name="options">
      					            </label>
      					            <label class="btn paymentMethod">
      				            		<div class="method amex"></div>
      					                <input type="radio" name="options">
      					            </label>
      					             <label class="btn paymentMethod">
      				             		<div class="method vishwa"></div>
      					                <input type="radio" name="options">
      					            </label>
      					            <label class="btn paymentMethod">
      				            		<div class="method ez-cash"></div>
      					                <input type="radio" name="options">
      					            </label>

      					        </div>
      						</div>
      						<div class="footerNavWrap clearfix">
      							<div class="btn btn-success pull-left btn-fyi"><span class="glyphicon glyphicon-chevron-left"></span> CONTINUE SHOPPING</div>
      							<div class="btn btn-success pull-right btn-fyi">CHECKOUT<span class="glyphicon glyphicon-chevron-right"></span></div>
      						</div>
      					</div>

      	</div>
      </div>


















    </body>
</html>
