<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String isbm = request.getParameter("ISBM");
        String author = request.getParameter("Author");
        String bookname = request.getParameter("Bookname");
        String fee = request.getParameter("fee");

        String sql = "UPDATE books SET isbm=?, author=?, bookname=?, fee=? WHERE id=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, isbm);
        pst.setString(2, author);
        pst.setString(3, bookname);
        pst.setString(4, fee);
        pst.setInt(5, id);

        pst.executeUpdate();
        response.sendRedirect("listBooks.jsp");
    }

    String sql = "SELECT * FROM books WHERE id=?";
    PreparedStatement pst = conn.prepareStatement(sql);
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    rs.next();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Book</title>
</head>
<body>
<h1>Update Book</h1>
<form method="post">
    ISBM: <input type="text" name="ISBM" value="<%= rs.getString("isbm") %>" required><br><br>
    Author: <input type="text" name="Author" value="<%= rs.getString("author") %>" required><br><br>
    Book Name: <input type="text" name="Bookname" value="<%= rs.getString("bookname") %>" required><br><br>
    Fee: 
    <select name="fee">
        <option <%= "Free".equals(rs.getString("fee")) ? "selected" : "" %> >Free</option>
        <option <%= "Trial".equals(rs.getString("fee")) ? "selected" : "" %> >Trial</option>
        <option <%= "Purchased".equals(rs.getString("fee")) ? "selected" : "" %> >Purchased</option>
    </select><br><br>
    <input type="submit" value="Update Book">
</form>
<br><a href="listBooks.jsp">Back to List</a>
</body>
</html>
