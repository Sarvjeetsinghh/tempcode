package com.iardo.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            String userType = (String) session.getAttribute("userType");
            String userEmail = (String) session.getAttribute("userEmail");

            System.out.println("=== LOGOUT ===");
            System.out.println("User Type: " + userType);
            System.out.println("Email: " + userEmail);

            // Invalidate the session
            session.invalidate();

            System.out.println("Session invalidated successfully");
        }

        // Redirect to login page with success message
        response.sendRedirect(request.getContextPath() + "/login.jsp?success=Logged out successfully!");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}