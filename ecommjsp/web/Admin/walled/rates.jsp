<%--
    Document   : rates
    Created on : May 1, 2018, 5:21:02 PM
    Author     : Wallid Samy
--%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shipping Rates</title>
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
                PreparedStatement selectActors3=null;
                PreparedStatement updateActor=null;
                ResultSet resultSet = null;

                public Actor(){
                    try{
                        connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
                        statement = connection.createStatement();
                        selectActors=connection.prepareStatement("SELECT shipment_company_id,shipment_company_name FROM shipment_company_t");
                        selectActors2=connection.prepareStatement("SELECT zone_id,zone_name FROM zones_t");
                        selectActors3=connection.prepareStatement("SELECT zone_id,zone_name FROM zones_t");
//                        query ="SELECT shipment_company_t.shipment_company_name,zones_t.zone_name,zones_t.zone_name,shipping_rates_t.isFirst,shipping_rates_t.shipping_unit,shipping_rates_t.shipping_rate FROM shipping_rates_t LEFT JOIN shipment_company_t ON shipping_rates_t.shipment_company_t_shipment_company_id = shipment_company_t.shipment_company_id LEFT JOIN zones_t ON (shipping_rates_t.zone_source = zones_t.zone_id && shipping_rates_t.zones_destination = zones_t.zone_id)";
query ="SELECT shipment_company_t.shipment_company_name, t1.zone_name zsource,t2.zone_name dsource, shipping_rates_t.isFirst, shipping_rates_t.shipping_unit,shipping_rates_t.shipping_rate FROM shipping_rates_t LEFT JOIN shipment_company_t ON shipping_rates_t.shipment_company_t_shipment_company_id = shipment_company_t.shipment_company_id LEFT JOIN zones_t t1 ON (shipping_rates_t.zone_source = t1.zone_id)LEFT JOIN zones_t t2 ON (shipping_rates_t.zones_destination = t2.zone_id)";
                        updateActor=connection.prepareStatement("UPDATE shipping_rates_t SET shipping_rate=? WHERE (shipment_company_t_shipment_company_id=? && zone_source=? && zones_destination=? && isFirst=?);");
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
                        resultSet=selectActors3.executeQuery();
                        //resultSet = statement.executeQuery(query);
                    }catch(SQLException ex){
                        ex.printStackTrace();
                    }
                    return resultSet;
                }
                public ResultSet getActors4(){
                    try{
                        resultSet = statement.executeQuery(query);
                    }catch(SQLException ex){
                        ex.printStackTrace();
                    }
                    return resultSet;
                }
                public int updateActors(int comp, int sour,int dest,int first,int rat){
                    int result=0;
                    try{
                        updateActor.setInt(1, rat);
                        updateActor.setInt(2, comp);
                        updateActor.setInt(3, sour);
                        updateActor.setInt(4, dest);
                        updateActor.setInt(5, first);
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
            if(request.getParameter("update")!=null){

                result = actor.updateActors(Integer.parseInt(request.getParameter("selected_company")),Integer.parseInt(request.getParameter("selected_zone1")),Integer.parseInt(request.getParameter("selected_zone2")),Integer.parseInt(request.getParameter("first")),Integer.parseInt(request.getParameter("nrate")));
            }
            ResultSet zones2Set=actor.getActors3();
            ResultSet zones1Set=actor.getActors2();
            ResultSet companiesSet=actor.getActors();
            ResultSet ratesSet=actor.getActors4();
        %>

      <div id="page-content-wrapper">
        <!-- Keep all page content within the page-content inset div! -->
        <div class="page-content inset">
            <div class="row">
              <div class="col-md-12">
              <p class="well lead"><b>Rates Managment</b></p><br>
              <div class="container">
                <div class="row"> <!-- div da esquerda -->
                    <div class="col-sm-8 contact-form"> <!-- div da direita -->
                        <form id="contact" method="post" class="form">
							<p>Update Rates :</p>
                            <!-- Text input cidade e estado-->

                                <div class="row">
                                 <div class="dropdown">
                                     <select name="selected_company" class="form-control" style="width: 200px">
                                    <option value="-1">Select Company</option>
                                    <% while (companiesSet.next()){%>
                                    <option value="<%=companiesSet.getString("shipment_company_id")%>"><%=companiesSet.getString("shipment_company_name")%></option>
                                    <%}%>
                                  </select>
                                  </div>
                                </div>
                                 <div class="row">
                                 <div class="dropdown">
                                     <select name="selected_zone1" class="form-control" style="width: 200px">
                                    <option value="-1">Source Zone</option>
                                    <% while (zones1Set.next()){%>
                                    <option value="<%=zones1Set.getString("zone_id")%>"><%=zones1Set.getString("zone_name")%></option>
                                    <%}%>
                                  </select>
                                  </div>
                                 <div class="dropdown">
                                     <select name="selected_zone2" class="form-control" style="width: 200px">
                                    <option value="-1">Destination Zone</option>
                                    <% while (zones2Set.next()){%>
                                    <option value="<%=zones2Set.getString("zone_id")%>"><%=zones2Set.getString("zone_name")%></option>
                                    <%}%>
                                  </select>
                                  </div>
                                 </div>
                                  <div class="row">
                                  <div class="col-xs-6 col-md-9 form-group">
                                      <input class="form-control" id="cityname" name="nrate" placeholder="Enter New Rate." type="text"/>
                                </div>
                                 <div class="col-xs-6 col-md-9 form-group">
                                      <select name="first" class="form-control" style="width: 200px">
                                    <option value="-1">Is First</option>
                                    <option value="1">First</option>
                                    <option value="0">Not First</option>
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
                        <td>Company Name</td>
                        <td>Source Zone</td>
                        <td>Destination Zone</td>
                        <td>Is First</td>
                        <td>Unit</td>
                        <td>Rate</td>
                    </tr>
                    <% while (ratesSet.next()){%>
                    <tr>
                        <td><%=ratesSet.getString(1)%></td>
                        <td><%=ratesSet.getString(2)%></td>
                        <td><%=ratesSet.getString(3)%></td>
                        <td><%=ratesSet.getString(4)%></td>
                        <td><%=ratesSet.getString(5)%></td>
                        <td><%=ratesSet.getString(6)%></td>

                    </tr>
                    <%}%>
                </tbody>
        </table></center>
    </div>
</div>
                <input type="hidden" name="hidden" value="<%=result %>" />

    </body>
</html>
