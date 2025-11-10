package com.iardo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String jdbcURL = "jdbc:mysql://localhost:3306/job_portal";
        String dbUser = "root";
        String dbPass = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

            String sql = "SELECT * FROM jobs WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("employerId", rs.getInt("id"));
                session.setAttribute("employerName", rs.getString("name"));
                session.setAttribute("employerEmail", rs.getString("email"));

                response.sendRedirect("employer_profile.jsp");
            } else {
                response.sendRedirect("employer_login.jsp?error=Invalid+Email+or+Password");
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}
