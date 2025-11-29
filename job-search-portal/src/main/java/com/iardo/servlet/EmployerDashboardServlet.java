package com.iardo.servlet;

import com.iardo.dao.JobDAO;
import com.iardo.model.Job;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/EmployerDashboardServlet")
public class EmployerDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private JobDAO jobDAO = new JobDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n=== EMPLOYER DASHBOARD ACCESS ===");

        HttpSession session = request.getSession(false);

        // Session validation
        if (session == null) {
            System.out.println("❌ Session is NULL");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Please+login+first");
            return;
        }

        String userType = (String) session.getAttribute("userType");
        Integer employerId = (Integer) session.getAttribute("employerId");

        System.out.println("Session ID: " + session.getId());
        System.out.println("userType: " + userType);
        System.out.println("employerId: " + employerId);

        // Validate user type
        if (!"employer".equals(userType)) {
            System.out.println("❌ userType is not 'employer'");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Please+login+as+employer");
            return;
        }

        // Validate employer ID
        if (employerId == null) {
            System.out.println("❌ employerId is NULL in session");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid+session");
            return;
        }

        System.out.println("✅ Session valid, fetching jobs for employer ID: " + employerId);

        // Fetch jobs posted by this employer
        List<Job> jobs = jobDAO.getJobsByEmployer(employerId);

        System.out.println("Jobs fetched: " + (jobs != null ? jobs.size() : 0));
        System.out.println("=================================\n");

        // Set jobs as request attribute
        request.setAttribute("jobs", jobs);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("employerDashboard.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}