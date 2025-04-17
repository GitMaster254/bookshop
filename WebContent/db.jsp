<%@ include file="db.jsp" %>

<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/bookdb";
    String username = "root";  // Default XAMPP user
    String password = "";      // Default XAMPP password is empty

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
    } catch (Exception e) {
        out.println("Database Connection Error: " + e.getMessage());
    }
%>
