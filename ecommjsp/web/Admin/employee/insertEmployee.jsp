
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page import="java.io.*" %>

<!DOCTYPE html>
<html>
  <jsp:include page="../includes/header.html"/>
  <jsp:include page="../includes/sidebar.html"/>


  <!-- Content Wrapper. Contains page content -->

  <div class="content-wrapper">
    <div class="container">


      <%
              String employee_name = request.getParameter("employee_name");
              String employee_phone = request.getParameter("employee_phone");
              float employee_salary = Float.parseFloat(request.getParameter("employee_salary"));
              int skill_id = Integer.parseInt(request.getParameter("skill_id"));
              int branches_t_branch_id = Integer.parseInt(request.getParameter("branches_t_branch_id"));

              try {
                  Class.forName("com.mysql.jdbc.Driver");
                  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
                  Statement st = conn.createStatement();

                  int i = st.executeUpdate("insert into Ecommerce.employees_t(employee_name , employee_phone , employee_salary , branches_t_branch_id)"
                          + "values('" + employee_name + "','" + employee_phone + "','" + employee_salary + "','"+branches_t_branch_id +"')", Statement.RETURN_GENERATED_KEYS);
                  ResultSet rs = st.getGeneratedKeys();

                  int generatedID = 0;
                  if (rs.next()) {
                      generatedID = rs.getInt(1);
                  }


              int x = st.executeUpdate("insert into Ecommerce.skills_t_has_employees_t(skills_t_skill_id , employees_t_employee_id )"
                      + "values('" + skill_id + "','" + generatedID + "')");

              out.println("Data is successfully inserted!");

            
          }
          catch (Exception e


              ) {
              out.print("" + e);
              System.out.print(e);
              e.printStackTrace();
          }
      %>



    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
