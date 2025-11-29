package com.iardo.servlet;

import java.io.IOException;

import com.iardo.dao.CandidateDAO;
import com.iardo.dao.EmployerDAO;
import com.iardo.model.Candidate;
import com.iardo.model.Employer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userType = request.getParameter("userType");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        System.out.println("=== REGISTRATION ATTEMPT ===");
        System.out.println("User Type: " + userType);
        System.out.println("Email: " + email);

        // Validate password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/register.jsp?error=Passwords+do+not+match");
            return;
        }

        try {
            if ("candidate".equals(userType)) {
                // CANDIDATE REGISTRATION
                String name = request.getParameter("name");
                String phone = request.getParameter("phone");
                String gender = request.getParameter("gender");
                String category = request.getParameter("category");

                // Check if email already exists
                CandidateDAO dao = new CandidateDAO();
                if (dao.emailExists(email)) {
                    System.out.println("❌ Email already exists: " + email);
                    response.sendRedirect(request.getContextPath() + "/register.jsp?error=Email+already+registered");
                    return;
                }

                // Create candidate object
                Candidate candidate = new Candidate();
                candidate.setFullName(name);
                candidate.setEmail(email);
                candidate.setPassword(password);
                candidate.setPhone(phone);
                candidate.setGender(gender);
                candidate.setCategory(category);

                // Register candidate
                boolean registered = dao.registerCandidate(candidate);

                if (registered) {
                    System.out.println("✅ CANDIDATE REGISTERED: " + name);
                    response.sendRedirect(request.getContextPath() + "/login.jsp?msg=success");
                } else {
                    System.out.println("❌ Registration failed");
                    response.sendRedirect(request.getContextPath() + "/register.jsp?error=Registration+failed");
                }

            } else if ("employer".equals(userType)) {
                // EMPLOYER REGISTRATION
                String companyName = request.getParameter("companyName");
                String phone = request.getParameter("phone");
                String industry = request.getParameter("industry");
                String website = request.getParameter("website");
                String address = request.getParameter("address");
                String description = request.getParameter("description");

                // Check if email already exists
                EmployerDAO dao = new EmployerDAO();
                if (dao.emailExists(email)) {
                    System.out.println("❌ Email already exists: " + email);
                    response.sendRedirect(request.getContextPath() + "/register.jsp?error=Email+already+registered");
                    return;
                }

                // Create employer object
                Employer employer = new Employer();
                employer.setCompanyName(companyName);
                employer.setEmail(email);
                employer.setPassword(password);
                employer.setPhone(phone);
                employer.setIndustry(industry);
                employer.setWebsite(website);
                employer.setAddress(address);
                employer.setDescription(description);

                // Register employer
                boolean registered = dao.registerEmployer(employer);

                if (registered) {
                    System.out.println("✅ EMPLOYER REGISTERED: " + companyName);
                    response.sendRedirect(request.getContextPath() + "/login.jsp?msg=success");
                } else {
                    System.out.println("❌ Registration failed");
                    response.sendRedirect(request.getContextPath() + "/register.jsp?error=Registration+failed");
                }

            } else {
                System.out.println("❌ Invalid user type");
                response.sendRedirect(request.getContextPath() + "/register.jsp?error=Invalid+user+type");
            }

        } catch (Exception e) {
            System.err.println("❌ Exception in RegisterServlet:");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/register.jsp?error=Server+error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to register page
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }
}