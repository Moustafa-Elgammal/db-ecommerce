<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>

<html>
    <head>
        <%-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> --%>
        <title>Login</title>
        <link href="http://localhost:8080/build/Design/shipments/css/bootstrap4.css" rel="stylesheet" id="bootstrap-css">

    </head>
    <body>
        <h1>Login</h1>

        <%

            System.out.print("check");

            String email = request.getParameter("custmer_email");
            String password = request.getParameter("password");
            Statement st ;


            try {
              // JDBC driver name and database URL
               String JDBC_DRIVER = "com.mysql.jdbc.Driver";
               String DB_URL = "jdbc:mysql://localhost/Ecommerce";
               out.println("<div class='btn btn-success'>"+"ok"+"</div>");

              //  Database credentials
               final String USER = "root";
               final String PASS = "";
             // open a connection
              Connection conn = null;
              Class.forName("com.mysql.jdbc.Driver");  // load the driver
              System.out.println("Connecting to database...");
              conn = DriverManager.getConnection(DB_URL,USER,PASS);
          // create the sql command
          System.out.println("Creating statement...");
          out.println("<div class='btn btn-success'>"+"ok2"+"</div>");
          out.println("<div class='btn btn-success'>"+email+"</div>");
          out.println("<div class='btn btn-success'>"+password+"</div>");



              PreparedStatement prep = conn.prepareStatement("Select * from customer_t WHERE custmer_email=? AND password=?");
              prep.setString(1,email);
              prep.setString(2,password);
              out.println("<div class='btn btn-success'>"+"ok3"+"</div>");


              ResultSet rs = prep.executeQuery();
               out.println("<div class='btn btn-success'>"+"ok4"+"</div>");

              if(rs.next()){
                out.println("<div class='btn btn-success'>"+"ok"+"</div>");
                prep.close();
                conn.close();

              }else{
                out.println("<div class='btn btn-success'>"+" not ok"+"</div>");
                prep.close();
                conn.close();

              }

            } catch (Exception e) {
                System.out.print("" + e);
                e.printStackTrace();
            }


        %>


    </body>
</html>
