<%--
    Document   : shipmentCalcuForm
    Created on : Mar 24, 2018, 9:34:23 AM
    Author     : foush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <script src="../Design/shipments/js/jquery-1.11.1.min.js"></script>
        <link href="../Design/shipments/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="../Design/shipments/js/bootstrap.min.js"></script>

        <!--     Fonts and icons     -->
      	<link rel="stylesheet" type="text/css" href="../Design/shipments/fonts/Roboto.min.css" />
      	<link rel="stylesheet" href="../Design/shipments/fonts/font-awesome.min.css" />
      <script type="text/javascript" src="../Design/shipments/js/jquery.validate.min.js"></script>
      <script type="text/javascript" src="../Design/shipments/js/jquery.payment.min.js"></script>

      <!-- If you're using Stripe for payments -->
        <link rel="stylesheet" href="../Design/shipments/css/shipmentCalculator.css" />
        <link rel="stylesheet" href="../Design/shipments/css/shipmentType.css" />






    </head>
    <body>
        <div class="image-container set-full-height" style="background-image: url('http://demos.creative-tim.com/material-bootstrap-wizard/assets/img/wizard-book.jpg')">


    		<!--  Made With Material Kit  -->
    		<a href="http://demos.creative-tim.com/material-kit/index.html?ref=material-bootstrap-wizard" class="made-with-mk" target="_blank">
    			<div class="brand">MK</div>
    			<div class="made-with">Made with <strong>Material Kit</strong></div>
    		</a>

    	    <!--   Big container   -->
    	    <div class="container">
    	        <div class="row">
    		        <div class="col-sm-8 col-sm-offset-2">
    		            <!-- Wizard container -->
    		            <div class="wizard-container">
    		                <div class="card wizard-card" data-color="red" id="wizard">
    		                    <form action="" method="">
    		                <!--        You can switch " data-color="blue" "  with one of the next bright colors: "green", "orange", "red", "purple"             -->

    		                    	<div class="wizard-header">
    		                        	<h3 class="wizard-title">
    		                        		shipment porcess
    		                        	</h3>
    									<h5>This information will let us know more about your shipment process.</h5>
    		                    	</div>
    								<div class="wizard-navigation">
    									<ul>
    			                            <li><a href="#details" data-toggle="tab">Account</a></li>
    			                            <li><a href="#captain" data-toggle="tab">payment Type</a></li>
    			                            <li><a href="#description" data-toggle="tab">Extra Details</a></li>
                                      <li><a href="#creditCard" data-toggle="tab">creditCard</a></li>

    			                        </ul>
    								</div>

    		                        <div class="tab-content">
    		                            <div class="tab-pane" id="details">
    		                            	<div class="row">
    			                            	<div class="col-sm-12">
    			                                	<h4 class="info-text"> Let's start with the basic details.</h4>
    			                            	</div>
    		                                	<div class="col-sm-6">
    												<div class="input-group">
    													<span class="input-group-addon">
    														<i class="material-icons">email</i>
    													</span>
    													<div class="form-group label-floating">
    			                                          	<label class="control-label">Your Email</label>
    			                                          	<input name="name" type="text" class="form-control">
    			                                        </div>
    												</div>

    												<div class="input-group">
    													<span class="input-group-addon">
    														<i class="material-icons">lock_outline</i>
    													</span>
    													<div class="form-group label-floating">
    			                                          	<label class="control-label">Your Password</label>
    			                                          	<input name="name2" type="password" class="form-control">
    			                                        </div>
    												</div>

    		                                	</div>
    		                                	<div class="col-sm-6">
    		                                    	<div class="form-group label-floating">
    		                                        	<label class="control-label">Country</label>
    	                                        		<select class="form-control">
    														<option disabled="" selected=""></option>
    	                                                	<option value="Afghanistan"> Afghanistan </option>
    	                                                	<option value="Albania"> Albania </option>
    	                                                	<option value="Algeria"> Algeria </option>
    	                                                	<option value="American Samoa"> American Samoa </option>
    	                                                	<option value="Andorra"> Andorra </option>
    	                                                	<option value="Angola"> Angola </option>
    	                                                	<option value="Anguilla"> Anguilla </option>
    	                                                	<option value="Antarctica"> Antarctica </option>
    	                                                	<option value="...">...</option>
    		                                        	</select>
    		                                    	</div>

    		                                	</div>



    		                            	</div>
    		                            </div>
    		                            <div class="tab-pane" id="captain">
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
                                  							<div> </div>
                                                <div> </div>

                                  						</div>
                                  					</div>


    		                            </div>

    		                            <div class="tab-pane" id="description">

                                      <form action="">
                                        <div class="form-group">
                                          <label for="email">quantity</label>
                                          <input type="text" class="form-control" id="email">
                                        </div>
                                        <div class="form-group">
                                          <label for="pwd">Password:</label>
                                          <input type="text" class="form-control" id="pwd">
                                        </div>
                                        <div class="checkbox">
                                          <label><input type="checkbox"> Remember me</label>
                                        </div>
                                        <button type="submit" class="btn btn-default">Submit</button>
                                      </form>



    		                            </div>
                                    <div class="tab-pane" id="creditCard">


                                                <!-- CREDIT CARD FORM STARTS HERE -->
                                                <div class="panel panel-default credit-card-box">
                                                    <div class="panel-heading display-table" >
                                                        <div class="row display-tr" >
                                                            <h3 class="panel-title display-td" >Payment Details</h3>
                                                            <div class="display-td" >
                                                                <img class="img-responsive pull-right" src="http://i76.imgup.net/accepted_c22e0.png">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="panel-body">
                                                        <form role="form" id="payment-form" method="POST" action="javascript:void(0);">
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <div class="form-group">
                                                                        <label for="cardNumber">CARD NUMBER</label>
                                                                        <div class="input-group">
                                                                            <input
                                                                                type="tel"
                                                                                class="form-control"
                                                                                name="cardNumber"
                                                                                placeholder="Valid Card Number"
                                                                                autocomplete="cc-number"
                                                                                required autofocus
                                                                            />
                                                                            <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-xs-7 col-md-7">
                                                                    <div class="form-group">
                                                                        <label for="cardExpiry"><span class="hidden-xs">EXPIRATION</span><span class="visible-xs-inline">EXP</span> DATE</label>
                                                                        <input
                                                                            type="tel"
                                                                            class="form-control"
                                                                            name="cardExpiry"
                                                                            placeholder="MM / YY"
                                                                            autocomplete="cc-exp"
                                                                            required
                                                                        />
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-5 col-md-5 pull-right">
                                                                    <div class="form-group">
                                                                        <label for="cardCVC">CV CODE</label>
                                                                        <input
                                                                            type="tel"
                                                                            class="form-control"
                                                                            name="cardCVC"
                                                                            placeholder="CVC"
                                                                            autocomplete="cc-csc"
                                                                            required
                                                                        />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <div class="form-group">
                                                                        <label for="couponCode">COUPON CODE</label>
                                                                        <input type="text" class="form-control" name="couponCode" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <button class="subscribe btn btn-success btn-lg btn-block" type="button">Start Subscription</button>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="display:none;">
                                                                <div class="col-xs-12">
                                                                    <p class="payment-errors"></p>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                                <!-- CREDIT CARD FORM ENDS HERE -->
                                    </div>





    		                        </div>
    	                        	<div class="wizard-footer">
    	                            	<div class="pull-right">
    	                                    <input type='button' class='btn btn-next btn-fill btn-danger btn-wd' name='next' value='Next' />
    	                                    <input type='button' class='btn btn-finish btn-fill btn-danger btn-wd' name='finish' value='Finish' />
    	                                </div>
    	                                <div class="pull-left">
    	                                    <input type='button' class='btn btn-previous btn-fill btn-default btn-wd' name='previous' value='Previous' />

    										<div class="footer-checkbox">
    											<div class="col-sm-12">
    											  <div class="checkbox">
    												  <label>
    													  <input type="checkbox" name="optionsCheckboxes">
    												  </label>
    												  Subscribe to our newsletter
    											  </div>
    										  </div>
    										</div>
    	                                </div>
    	                                <div class="clearfix"></div>
    	                        	</div>
    		                    </form>
    		                </div>
    		            </div> <!-- wizard container -->
    		        </div>
    	    	</div> <!-- row -->
    		</div> <!--  big container -->

    	    <div class="footer">
    	        <div class="container text-center">
    	             Made with <i class="fa fa-heart heart"></i> by <a href="http://www.creative-tim.com" target="_blank">Creative Tim</a>.
    	        </div>
    	    </div>
    	</div>

    <script src="../Design/shipments/js/shipmentCalculator.js"></script>
</body>
</html>
