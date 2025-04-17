<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>List of Books</title>
</head>
<body>
<h1>Available Books</h1>
<table border="1">
    <tr>
        <th>ISBM</th>
        <th>Author</th>
        <th>Book Name</th>
        <th>Fee</th>
        <th>Actions</th>
    </tr>
<%
    String sql = "SELECT * FROM books";
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(sql);

    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("isbm") %></td>
        <td><%= rs.getString("author") %></td>
        <td><%= rs.getString("bookname") %></td>
        <td><%= rs.getString("fee") %></td>
        <td>
            <a href="updatebook.jsp?id=<%= rs.getInt("id") %>">Edit</a> | 
            <a href="deletebook.jsp?id=<%= rs.getInt("id") %>">Delete</a>
        </td>
    </tr>
<% } %>
</table>
<br><a href="addbook.jsp">Add New Book</a>
</body>
</html>
