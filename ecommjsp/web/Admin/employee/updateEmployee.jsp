
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>


<!DOCTYPE html>
<html>
  <jsp:include page="../includes/header.html"/>
  <jsp:include page="../includes/sidebar.html"/>


  <!-- Content Wrapper. Contains page content -->

  <div class="content-wrapper">
    <div class="container">


      <%
              int employee_id = Integer.parseInt(request.getParameter("update_id"));
              String employee_name = request.getParameter("employee_name");
              String employee_phone = request.getParameter("employee_phone");
              float employee_salary = Float.parseFloat(request.getParameter("employee_salary"));
              int skill_id = Integer.parseInt(request.getParameter("skill_id"));

          try {
              Class.forName("com.mysql.jdbc.Driver");
              Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
              Statement st = conn.createStatement();

               int i = st.executeUpdate("insert into ecommerce.employees_t(employee_name + employee_phone + employee_salary + skills_t_skill_id)"
                      + "values('" + employee_name+ "','" + employee_phone + "','" + employee_salary + "')");

              out.println("Data is successfully updated!");
          } catch (Exception e) {
              out.print("" + e);
              System.out.print(e);
              e.printStackTrace();
          }

      %>


    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
