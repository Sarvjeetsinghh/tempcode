package com.iardo.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOTP = request.getParameter("otp");

        System.out.println("\n=== OTP VERIFICATION ===");
        System.out.println("Entered OTP: " + enteredOTP);

        HttpSession session = request.getSession(false);

        if (session == null) {
            System.out.println("❌ Session expired");
            response.sendRedirect("forgotPassword.jsp?error=Session+expired.+Please+try+again");
            return;
        }

        String storedOTP = (String) session.getAttribute("resetOTP");
        String email = (String) session.getAttribute("resetEmail");
        String userType = (String) session.getAttribute("resetUserType");

        System.out.println("Stored OTP: " + storedOTP);
        System.out.println("Email: " + email);
        System.out.println("User Type: " + userType);

        if (storedOTP == null || email == null) {
            System.out.println("❌ Session data missing");
            response.sendRedirect("forgotPassword.jsp?error=Session+expired.+Please+try+again");
            return;
        }

        if (storedOTP.equals(enteredOTP)) {
            System.out.println("✅ OTP verified successfully");
            
            // Remove OTP from session (one-time use)
            session.removeAttribute("resetOTP");
            
            // Set verified flag
            session.setAttribute("otpVerified", true);
            
            // Redirect to reset password page
            response.sendRedirect("resetPassword.jsp");

        } else {
            System.out.println("❌ Invalid OTP");
            response.sendRedirect("verifyOTP.jsp?email=" + email + "&error=Invalid+OTP.+Please+try+again");
        }

        System.out.println("=======================\n");
    }
}
