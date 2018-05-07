<%--
    Document   : cities
    Created on : Apr 6, 2018, 7:36:14 PM
    Author     : Wallid Samy
--%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cities</title>
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
                        selectActors=connection.prepareStatement("SELECT city_id,city_name,zones_t_zone_id FROM cities_t");
                        insertActor = connection.prepareStatement(
                             "INSERT INTO ecommerce.cities_t(city_name)" +
                                "VALUE(?)");
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
                public int insertActors(String name){
                    int result=0;
                    try{
                        insertActor.setString(1, name);
                        result = insertActor.executeUpdate();
                    }catch(SQLException ex){
                        ex.printStackTrace();
                    }
                    return result;
                }
        }
        %>
        <%
            System.out.println(request.getParameter("submit"));
            int result=0;
            String name=new String();
            Actor actor = new Actor();
            if(request.getParameter("insert")!=null){
                name=request.getParameter("cityname");
                result = actor.insertActors(name);
            }
            ResultSet resultSet=actor.getActors();
        %>
	  <!-- Page content -->
      <div id="page-content-wrapper">
        <!-- Keep all page content within the page-content inset div! -->
        <div class="page-content inset">
            <div class="row">
              <div class="col-md-12">
              <p class="well lead"><b>Cities Managment</b></p><br>
              <div class="container">
                <div class="row"> <!-- div da esquerda -->
                    <div class="col-sm-8 contact-form"> <!-- div da direita -->
                        <form id="contact" method="post" class="form">
							<p>Inster new city:</p>
                            <!-- Text input cidade e estado-->
                            <div class="row">
                                <div class="col-xs-6 col-md-9 form-group">
                                    <input class="form-control" id="cityname" name="cityname" placeholder="Enter City Name." type="text"  required/>
                                </div>
                                <div class="col-xs-4 col-md-3 form-group">
                                    <button class="btn btn-primary pull-right" type="submit" name="insert">Insert</button>
                                    <button class="btn btn-primary pull-right" type="submit">Delete</button>
                                </div>
                        </form>
                    </div>
                </div>
            </div>
            </div>
          </div>
        </div>
            <center><table class="table table-condensed">

                <tbody>
                    <tr>
                        <td>City ID</td>
                        <td>City Name</td>
                        <td>City Zone ID</td>
                    </tr>
                    <% while (resultSet.next()){%>
                    <tr>
                        <td><%=resultSet.getString("city_id")%></td>
                        <td><%=resultSet.getString("city_name")%></td>
                        <td><%=resultSet.getString("zones_t_zone_id")%></td>
                    </tr>
                    <%}%>
                </tbody>
        </table></center>
    </div>
</div>
                <input type="hidden" name="hidden" value="<%=result %>" />

        <SCRIPT LANGUAGE="JavaScript">
        <!--
        function displayResults() {
            if(document.myForm.hidden.value==1){
                alert("Data inserted");
                window.location.reload();
            }
        }
              //-->
        </SCRIPT>
    </body>
</html>
