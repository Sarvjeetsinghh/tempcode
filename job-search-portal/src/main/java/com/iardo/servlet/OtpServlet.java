package com.iardo.servlet;


import com.iardo.util.OTPGenerator;
import com.iardo.util.SendOtp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/send-otp")
public class OtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {

        String mobile = req.getParameter("mobile");

        // Generate OTP
        String otp = OTPGenerator.generateOTP();

        // Send OTP
        boolean sent = SendOtp.sendOTP(mobile, otp);

        if (sent) {
            HttpSession session = req.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("mobile", mobile);
            res.sendRedirect("verify-otp.jsp");
        } else {
            res.getWriter().println("Failed to send OTP. Try again.");
        }
    }
}
