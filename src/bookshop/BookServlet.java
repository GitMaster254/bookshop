package bookshop;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class BookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Initialize the DB connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookshop";
    private static final String DB_USER = "root"; // Replace with your DB username
    private static final String DB_PASSWORD = ""; // Replace with your DB password

    // Establish connection to the database
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (Exception e) {
            throw new SQLException("Database connection error: " + e.getMessage());
        }
    }

    // save and add Book to database
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String isbm = request.getParameter("ISBM");
        String author = request.getParameter("Author");
        String bookName = request.getParameter("Bookname");
        String fee = request.getParameter("fee");

        // Insert book details into the database
        String query = "INSERT INTO books (isbm, author, bookname, fee) VALUES (?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, isbm);
            ps.setString(2, author);
            ps.setString(3, bookName);
            ps.setString(4, fee);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("/WebContent/listbook.jsp");
            } else {
                response.getWriter().println("Error adding book.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    // Handle GET requests (Display All Books)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action != null && action.equals("delete")) {
            // Handle delete action
            String id = request.getParameter("id");
            deleteBook(id, response);
        } else {
            // Display all books
            displayBooks(request, response);
        }
    }

    // Method to display books from the database
    private void displayBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = "SELECT * FROM books";
        
        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            request.setAttribute("books", rs);
            RequestDispatcher dispatcher = request.getRequestDispatcher("listbook.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    // Method to delete a book from the database
    private void deleteBook(String id, HttpServletResponse response) throws IOException {
        String query = "DELETE FROM books WHERE id = ?";
        
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, id);
            int result = ps.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("/WebContent/listbook.jsp");
            } else {
                response.getWriter().println("Error deleting book.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
