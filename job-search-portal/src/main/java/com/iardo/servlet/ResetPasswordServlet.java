package com.iardo.servlet;

import com.iardo.dao.CandidateDAO;
import com.iardo.dao.EmployerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("forgotPassword.jsp?error=Session+expired");
            return;
        }

        String enteredOTP = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String storedOTP = (String) session.getAttribute("resetOTP");
        String email = (String) session.getAttribute("resetEmail");
        String userType = (String) session.getAttribute("resetUserType");

        System.out.println("=== PASSWORD RESET ATTEMPT ===");
        System.out.println("Entered OTP: " + enteredOTP);
        System.out.println("Stored OTP: " + storedOTP);
        System.out.println("Email: " + email);
        System.out.println("User Type: " + userType);

        // Validate inputs
        if (enteredOTP == null || newPassword == null || confirmPassword == null) {
            response.sendRedirect("verifyOTP.jsp?error=All+fields+are+required");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("verifyOTP.jsp?error=Passwords+do+not+match");
            return;
        }

        if (!enteredOTP.equals(storedOTP)) {
            response.sendRedirect("verifyOTP.jsp?error=Invalid+OTP");
            return;
        }

        // Update password
        boolean updated = false;

        if ("candidate".equals(userType)) {
            CandidateDAO dao = new CandidateDAO();
            updated = dao.updatePassword(email, newPassword);
        } else if ("employer".equals(userType)) {
            EmployerDAO dao = new EmployerDAO();
            updated = dao.updatePassword(email, newPassword);
        }

        if (updated) {
            System.out.println("✅ Password updated successfully");
            // Clear session attributes
            session.removeAttribute("resetOTP");
            session.removeAttribute("resetEmail");
            session.removeAttribute("resetUserType");

            response.sendRedirect("login.jsp?success=Password+reset+successful!+Please+login");
        } else {
            System.out.println("❌ Password update failed");
            response.sendRedirect("verifyOTP.jsp?error=Failed+to+reset+password");
        }
    }
}