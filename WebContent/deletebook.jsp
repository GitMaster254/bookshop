<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    String sql = "DELETE FROM books WHERE id=?";
    PreparedStatement pst = conn.prepareStatement(sql);
    pst.setInt(1, id);

    pst.executeUpdate();
    response.sendRedirect("listBooks.jsp");
%>
