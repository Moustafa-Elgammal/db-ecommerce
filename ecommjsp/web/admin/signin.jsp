<%-- 
    Document   : signin
    Created on : May 1, 2018, 3:24:41 AM
    Author     : Mosutafa
--%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%!
  public  class DB_connection {
    String url = "jdbc:mysql://localhost:3306/Ecommerce";
    String username = "root";
    String password = "";

    Connection connection = null;
    PreparedStatement user = null;
    ResultSet resultSet = null;

    public  DB_connection() {
      try {
        connection = DriverManager.getConnection(url, username, password);

      } catch (SQLException e){
         //("connection exception");
      }
    }



    
    public boolean setQuery(String Query) {
      try {
        user = connection.prepareStatement(Query);
        return true;
      } catch (SQLException e){
        return false;
      }
    }

    
    public ResultSet getResults (){

      try {
        resultSet = user.executeQuery();
      } catch (SQLException e){

      }

      return resultSet;
    }


    public ResultSet executeQueryGetResults(String Query){
        setQuery(Query);
        return getResults();
    }
    



    
}
%>
<%
     if (session.getAttribute("id") != null){
            response.sendRedirect("index.jsp");
    }
     
    DB_connection db = new DB_connection();
    String Query;
    ResultSet userInfo;
%>

   <%
        ArrayList errors = new  ArrayList();

        String s = request.getParameter("submit");
        if(s != null){
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // validation 
            
            if(email == null)
                errors.add("email is required");
            
            else if(email.length() == 0)
                errors.add("empty email");
            
            
            if(password == null)
                errors.add("password is required");
            
            else if(password.length() == 0)
                errors.add("empty password");
            
            if(errors.size() == 0){
                Query = "SELECT * FROM custmers_t WHERE custmer_email='"+email+"' AND custmer_name='"+password+"';";
                userInfo = db.executeQueryGetResults(Query);
                %>
                <%
                if(userInfo.last()){
                    String name = request.getParameter( "username" );
                    session.setAttribute( "id", userInfo.getInt("custmer_id") );
                    
                    response.sendRedirect("index.jsp");

                %>
                <%
                }else {
                    errors.add("Invalied email or password........");
              
                    }
             }
                       
        }
    %>
    
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In</title>
        <link href="../Design/shipments/css/bootstrap4.css" rel="stylesheet" id="bootstrap-css">
    </head>
    <body>
        <div class="container">
                
            <div class="col-md-2">
            </div>
                <div class="col-md-8 ">
                    <%
                        if(errors.size() > 0){
                            for(int i = 0; i< errors.size();i++){
                                %>
                                <span class="badge badge-pill badge-danger">
                                     <%= errors.get(i) %>
                                </span><br>
                                   <%
                            }
                        }
                    %>
                    <form action="signin.jsp" method="post" >
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" name="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                          </div>
                          <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                          </div>
                          <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="exampleCheck1">
                            <label class="form-check-label" for="exampleCheck1">Remember me...</label>
                          </div>
                        <button type="submit" name="submit" class="btn btn-primary">Sign In</button>
                    </form>
                </div>
            </div>
        </div>
        
    </body>
</html>
