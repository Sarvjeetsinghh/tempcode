package com.iardo.servlet;

import com.iardo.dao.CandidateDAO;
import com.iardo.dao.EmployerDAO;
import com.iardo.model.Candidate;
import com.iardo.model.Employer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userType = request.getParameter("userType");
        String email = request.getParameter("email");

        System.out.println("=== PASSWORD RECOVERY ATTEMPT ===");
        System.out.println("User Type: " + userType);
        System.out.println("Email: " + email);

        if (userType == null || userType.isEmpty() || email == null || email.isEmpty()) {
            response.sendRedirect("forgotPassword.jsp?error=All+fields+are+required");
            return;
        }

        boolean userFound = false;
        String generatedOTP = generateOTP();

        if ("candidate".equals(userType)) {
            CandidateDAO dao = new CandidateDAO();
            Candidate candidate = dao.getCandidateByEmail(email);

            if (candidate != null) {
                userFound = true;
                HttpSession session = request.getSession();
                session.setAttribute("resetOTP", generatedOTP);
                session.setAttribute("resetEmail", email);
                session.setAttribute("resetUserType", userType);
                session.setMaxInactiveInterval(300); // 5 minutes
            }

        } else if ("employer".equals(userType)) {
            EmployerDAO dao = new EmployerDAO();
            Employer employer = dao.getEmployerByEmail(email);

            if (employer != null) {
                userFound = true;
                HttpSession session = request.getSession();
                session.setAttribute("resetOTP", generatedOTP);
                session.setAttribute("resetEmail", email);
                session.setAttribute("resetUserType", userType);
                session.setMaxInactiveInterval(300); // 5 minutes
            }
        }

        if (userFound) {
            System.out.println("✅ User found! Generated OTP: " + generatedOTP);
            // Redirect to OTP verification page
            response.sendRedirect("verifyOTP.jsp?otp=" + generatedOTP); 
        } else {
            System.out.println("❌ User not found");
            response.sendRedirect("forgotPassword.jsp?error=Invalid+email+address");
        }
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // 6-digit OTP
        return String.valueOf(otp);
    }
}
