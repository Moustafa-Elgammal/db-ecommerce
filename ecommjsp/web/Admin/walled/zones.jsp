<%--
    Document   : zones
    Created on : Apr 11, 2018, 12:58:49 AM
    Author     : Wallid Samy
--%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Zones</title>
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

                String query;
                Statement statement;

                Connection connection=null;
                PreparedStatement selectActors=null;
                PreparedStatement selectActors2=null;
                PreparedStatement insertActor=null;
                PreparedStatement updateActor=null;
                ResultSet resultSet = null;

                public Actor(){
                    try{
                        connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                        statement = connection.createStatement();
                        selectActors=connection.prepareStatement("SELECT city_id,city_name FROM cities_t");
                        selectActors2=connection.prepareStatement("SELECT zone_id,zone_name FROM zones_t");
                        query ="SELECT cities_t.city_id,cities_t.city_name,zones_t.zone_name FROM cities_t LEFT JOIN zones_t ON cities_t.zones_t_zone_id = zones_t.zone_id";
                        insertActor = connection.prepareStatement(
                             "INSERT INTO ecommerce.zones_t(zone_name)" +
                                "VALUE(?)");
                        updateActor=connection.prepareStatement("UPDATE cities_t SET zones_t_zone_id=? WHERE city_id=?;");
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
                public ResultSet getActors2(){
                    try{
                        resultSet=selectActors2.executeQuery();
                    }catch(SQLException ex){
                        ex.printStackTrace();
                    }
                    return resultSet;
                }
                public ResultSet getActors3(){
                    try{
                        //resultSet=selectActors4.executeQuery();
                        resultSet = statement.executeQuery(query);
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
                public int updateActors(int city_id, int zone_id){
                    int result=0;
                    try{
                        updateActor.setInt(1, zone_id);
                        updateActor.setInt(2, city_id);
                        result = updateActor.executeUpdate();
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
            Actor actor = new Actor();
            if(request.getParameter("create")!=null){
                name=request.getParameter("zonename");
                result = actor.insertActors(name);
            }
            if(request.getParameter("update")!=null){

                result = actor.updateActors(Integer.parseInt(request.getParameter("selected_city")),Integer.parseInt(request.getParameter("selected_zone")));
            }
            ResultSet resultSet=actor.getActors3();
            ResultSet zonesSet=actor.getActors2();
            ResultSet citiesSet=actor.getActors();
        %>

      <div id="page-content-wrapper">
        <!-- Keep all page content within the page-content inset div! -->
        <div class="page-content inset">
            <div class="row">
              <div class="col-md-12">
              <p class="well lead"><b>Zones Managment</b></p><br>
              <div class="container">
                <div class="row"> <!-- div da esquerda -->
                    <div class="col-sm-8 contact-form"> <!-- div da direita -->
                        <form id="contact" method="post" class="form">
							<p>Create new zone :</p>
                            <!-- Text input cidade e estado-->
                            <div class="row">
                                <div class="col-xs-6 col-md-9 form-group">
                                    <input class="form-control" id="cityname" name="zonename" placeholder="Enter zone Name." type="text"/>
                                </div>
                                <div class="col-xs-4 col-md-3 form-group">
                                    <button class="btn btn-primary pull-right" type="submit" name="create">Create</button>
                                </div>
                                </div>
                                <div class="row">
                                 <div class="dropdown">
                                     <select name="selected_zone" class="form-control" style="width: 200px">
                                    <option value="-1">Select Zone</option>
                                    <% while (zonesSet.next()){%>
                                    <option value="<%=zonesSet.getString("zone_id")%>"><%=zonesSet.getString("zone_name")%></option>
                                    <%}%>
                                  </select>
                                  </div>
                                 <div class="dropdown">
                                     <select name="selected_city" class="form-control" style="width: 200px">
                                    <option value="-1">Select City</option>
                                    <% while (citiesSet.next()){%>
                                    <option value="<%=citiesSet.getString("city_id")%>"><%=citiesSet.getString("city_name")%></option>
                                    <%}%>
                                  </select>
                                  </div>
                                <div class="col-xs-4 col-md-3 form-group">
                                    <button class="btn btn-primary pull-right" type="submit" name="update">Update</button>
                                </div>
                             </div>
                        </form>

                </div>
            </div>
            </div>
          </div>
        </div>
            <h2>Rates</h2>
            <center><table class="table table-condensed">

                <tbody>
                    <tr>
                        <td>City ID</td>
                        <td>City Name</td>
                        <td>City Zone Name</td>
                    </tr>
                    <% while (resultSet.next()){%>
                    <tr>
                        <td><%=resultSet.getString("city_id")%></td>
                        <td><%=resultSet.getString("city_name")%></td>
                        <td><%=resultSet.getString(3)%></td>

                    </tr>
                    <%}%>
                </tbody>
        </table></center>
    </div>
</div>
                <input type="hidden" name="hidden" value="<%=result %>" />

    </body>
</html>
