<%--
    Document   : companies
    Created on : May 1, 2018, 5:20:31 PM
    Author     : Wallid Samy
--%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Companies</title>
        <link href="style.css" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="js/bootstrap.min.js"></script>
        <script src="jquery-3.3.1.min.js"></script>
        <script src="index.js"></script>
    </head>
    <body>
        <div id="wrapper" class="active">
    <!-- Sidebar -->
            <!-- Sidebar -->
    <div id="sidebar-wrapper">
        <ul id="sidebar_menu" class="sidebar-nav">
           <li class="sidebar-brand"><a id="menu-toggle">Menu<span id="main_icon" class="glyphicon glyphicon-align-justify"></span></a></li>
        </ul>
        <ul class="sidebar-nav" id="sidebar">
          <li><a href="companies.jsp">Companies<span class="sub_icon glyphicon glyphicon-link"></span></a></li>
          <li><a href="rates.jsp">Shipping Rates<span class="sub_icon glyphicon glyphicon-link"></span></a></li>
          <li><a href="zones.jsp">Zones<span class="sub_icon glyphicon glyphicon-link"></span></a></li>
          <li><a href="cities.jsp">Cities<span class="sub_icon glyphicon glyphicon-link"></span></a></li>
        </ul>
      </div>
            <%!
            public class Actor {
                String URL ="jdbc:mysql://localhost:3306/Ecommerce";
                String USERNAME="root";
                String PASSWORD="";


                Connection connection=null;
                PreparedStatement selectActors=null;
                PreparedStatement insertActor=null;
                ResultSet resultSet = null;

                public Actor(){
                    try{
                        connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                        selectActors=connection.prepareStatement("SELECT * FROM shipment_company_t");
                        insertActor = connection.prepareStatement("INSERT INTO ecommerce.shipment_company_t(shipment_company_name,shipment_company_phone,shipment_company_fax,shipment_company_email,shipment_company_address)" +
                                "VALUE(?,?,?,?,?)");
                        }catch(SQLException e){
                        e.printStackTrace();
                    }
                }
                public ResultSet getActors(){
                    try{
                        resultSet=selectActors.executeQuery();
                    }catch(SQLException ex){
                        ex.printStackTrace();
                    }
                    return resultSet;
                }
                public int insertActors(String name, String phone, String fax, String email, String address){
                    int result=0;
                    try{
                        insertActor.setString(1, name);
                        insertActor.setString(2, phone);
                        insertActor.setString(3, fax);
                        insertActor.setString(4, email);
                        insertActor.setString(5, address);
                        result = insertActor.executeUpdate();
                    }catch(SQLException ex){
                        ex.printStackTrace();
                    }
                    return result;
                }
        }
        %>
        <%
            int result=0;
            String name=new String();
            String phone=new String();
            String fax=new String();
            String email=new String();
            String address=new String();
            Actor actor = new Actor();
            if(request.getParameter("create")!=null){
                name=request.getParameter("cname");
                phone=request.getParameter("cphone");
                fax=request.getParameter("cfax");
                email=request.getParameter("cemail");
                address=request.getParameter("caddress");
                result = actor.insertActors(name,phone,fax,email,address);
            }
            ResultSet companiesSet=actor.getActors();
        %>

      <div id="page-content-wrapper">
        <!-- Keep all page content within the page-content inset div! -->
        <div class="page-content inset">
            <div class="row">
              <div class="col-md-12">
              <p class="well lead"><b>Companies Managment</b></p><br>
              <div class="container">
                <div class="row"> <!-- div da esquerda -->
                    <div class="col-sm-8 contact-form"> <!-- div da direita -->
                        <form id="contact" method="post" class="form">
							<p>Create new Company:</p>
                            <!-- Text input cidade e estado-->
                            <div class="row">
                                <div class="col-xs-6 col-md-9 form-group">
                                    <input class="form-control" id="cityname" name="cname" placeholder="Enter Company Name." type="text"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-md-9 form-group">
                                    <input class="form-control" id="cityname" name="cphone" placeholder="Enter company Phone." type="text"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-md-9 form-group">
                                    <input class="form-control" id="cityname" name="cfax" placeholder="Enter company Fax." type="text"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-md-9 form-group">
                                    <input class="form-control" id="cityname" name="cemail" placeholder="Enter company Mail." type="text"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-md-9 form-group">
                                    <input class="form-control" id="cityname" name="caddress" placeholder="Enter company Address." type="text"/>
                                </div>
                            </div>
                            <div class="col-xs-4 col-md-3 form-group">
                                    <button class="btn btn-primary pull-right" type="submit" name="create">Create</button>
                                </div>
                        </form>

                </div>
            </div>
            </div>
          </div>
        </div>
            <h2>Companies</h2>
            <center><table class="table table-condensed">

                <tbody>
                    <tr>
                        <td>Company ID</td>
                        <td>Com[any Name</td>
                        <td>Company Phone</td>
                        <td>Company fax</td>
                        <td>Company email</td>
                        <td>Company Address</td>
                    </tr>
                    <% while (companiesSet.next()){%>
                    <tr>
                        <td><%=companiesSet.getString(1)%></td>
                        <td><%=companiesSet.getString(2)%></td>
                        <td><%=companiesSet.getString(3)%></td>
                        <td><%=companiesSet.getString(4)%></td>
                        <td><%=companiesSet.getString(5)%></td>
                        <td><%=companiesSet.getString(6)%></td>
                    </tr>
                    <%}%>
                </tbody>
        </table></center>
    </div>
</div>
                <input type="hidden" name="hidden" value="<%=result %>" />

    </body>
</html>
