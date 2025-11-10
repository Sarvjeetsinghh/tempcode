package com.iardo.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {

        String enteredOtp = req.getParameter("otp");
        HttpSession session = req.getSession();
        String sessionOtp = (String) session.getAttribute("otp");

        if (enteredOtp != null && enteredOtp.equals(sessionOtp)) {
            res.getWriter().println("OTP Verified! Registration/Login successful.");
        } else {
            res.getWriter().println("Invalid OTP. Try again.");
        }
    }
}

