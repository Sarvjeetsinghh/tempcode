package com.iardo.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.iardo.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Allow GET to show redirect to login.jsp (optional)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If someone requests /LoginServlet with GET, forward to login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userType = request.getParameter("userType");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("User Type: " + userType);
        System.out.println("Email: " + email);

        if (userType == null || userType.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Select+user+type");
            return;
        }

        String sql = null;
        try (Connection conn = DBConnection.getConnection()) {

            if ("candidate".equals(userType)) {
                sql = "SELECT id, name, email, password FROM candidates WHERE email=? AND password=?";
            } else if ("employer".equals(userType)) {
                sql = "SELECT id, companyName AS name, email, password FROM employers WHERE email=? AND password=?";
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid+user+type");
                return;
            }

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession(true);

                session.setAttribute("userType", userType);
                session.setAttribute("userEmail", email);

                int id = rs.getInt("id");
                String name = rs.getString("name");

                if ("candidate".equals(userType)) {
                    session.setAttribute("candidateId", id);
                    session.setAttribute("candidateName", name);
                    System.out.println("CANDIDATE LOGIN SUCCESS: id=" + id + " name=" + name);
                    response.sendRedirect(request.getContextPath() + "/candidateDashboard.jsp");
                } else {
                    session.setAttribute("employerId", id);
                    session.setAttribute("employerName", name);
                    System.out.println("EMPLOYER LOGIN SUCCESS: id=" + id + " company=" + name);
                    // redirect to employer dashboard URL (change as needed)
                    response.sendRedirect(request.getContextPath() + "/employerDashboard.jsp");
                }

            } else {
                System.out.println("LOGIN FAILED - Invalid credentials for: " + email);
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid+email+or+password");
            }

        } catch (Exception e) {
            System.err.println("Exception in LoginServlet:");
            e.printStackTrace();
            // send a generic message to user; check logs for details
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Server+error");
        }
    }
}
