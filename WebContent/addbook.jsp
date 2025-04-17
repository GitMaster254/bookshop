<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String isbm = request.getParameter("ISBM");
        String author = request.getParameter("Author");
        String bookname = request.getParameter("Bookname");
        String fee = request.getParameter("fee");

        String sql = "INSERT INTO books (isbm, author, bookname, fee) VALUES (?, ?, ?, ?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, isbm);
        pst.setString(2, author);
        pst.setString(3, bookname);
        pst.setString(4, fee);

        pst.executeUpdate();
        response.sendRedirect("listBooks.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Book</title>
</head>
<body>
<h1>Add New Book</h1>
<form method="post">
    ISBM: <input type="text" name="ISBM" required><br><br>
    Author: <input type="text" name="Author" required><br><br>
    Book Name: <input type="text" name="Bookname" required><br><br>
    Fee: 
    <select name="fee">
        <option>Free</option>
        <option>Trial</option>
        <option>Purchased</option>
    </select><br><br>
    <input type="submit" value="Add Book">
</form>
<br><a href="listbook.jsp">View Book List</a>
</body>
</html>
