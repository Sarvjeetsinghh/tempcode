package com.iardo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/register")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class RegisterServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/job_portal";
    private static final String JDBC_USER = "root"; // 🔹 change if needed
    private static final String JDBC_PASSWORD = "root"; // 🔹 change if needed

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String experience = request.getParameter("experience");
        String category = request.getParameter("category");

        Part profilePicPart = request.getPart("profilePic");
        String fileName = profilePicPart.getSubmittedFileName();

        // Password validation
        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?msg=password_mismatch");
            return;
        }

        // Save uploaded profile picture
        String uploadPath = getServletContext().getRealPath("") + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        profilePicPart.write(uploadPath + File.separator + fileName);

        // ✅ Insert into MySQL
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String sql = "INSERT INTO users (gender, dateofbirth, email, password, picture, name, phone, experience, categories) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, gender);
            ps.setString(2, dob);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, fileName);
            ps.setString(6, fullname);
            ps.setString(7, phone);
            ps.setString(8, experience);
            ps.setString(9, category);

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("register.jsp?msg=success");
            } else {
                response.sendRedirect("register.jsp?msg=failed");
            }

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?msg=error");
        }
    }
}
