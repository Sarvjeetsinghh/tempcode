package com.iardo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/EmployerRegisterServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // for logo upload
public class EmployerRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String person = request.getParameter("person");
        String designation = request.getParameter("designation");
        String password = request.getParameter("password");
        Part logoPart = request.getPart("logo");

        InputStream logoStream = (logoPart != null) ? logoPart.getInputStream() : null;

        String jdbcURL = "jdbc:mysql://localhost:3306/job_portal";
        String dbUser = "root";
        String dbPass = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            // ✅ Correct SQL query with table name
            String sql = "INSERT INTO jobs (email, password, name, logo, person, designation, post_date) VALUES (?, ?, ?, ?, ?, ?, NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, name);

            if (logoStream != null)
                stmt.setBlob(4, logoStream);
            else
                stmt.setNull(4, Types.BLOB);

            stmt.setString(5, person);
            stmt.setString(6, designation);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                // Redirect to login page after success
                response.sendRedirect("employer_login.jsp?msg=success");
            } else {
                response.getWriter().println("⚠️ Registration failed! Try again.");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}
