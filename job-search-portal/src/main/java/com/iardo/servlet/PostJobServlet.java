package com.iardo.servlet;


import com.iardo.dao.JobDAO;
import com.iardo.model.Job;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/postJob")
public class PostJobServlet extends HttpServlet {

    private JobDAO jobDAO = new JobDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n=== POST JOB ATTEMPT ===");

        // 🔥 Session validation
        HttpSession session = request.getSession(false);

        // ✅ YE CODE YAHAAN HAI
        if (session == null) {
            System.out.println("❌ Session is NULL");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Session+expired");
            return;
        }

        System.out.println("Session ID: " + session.getId());
        System.out.println("userType: " + session.getAttribute("userType"));
        System.out.println("employerId: " + session.getAttribute("employerId"));

        String userType = (String) session.getAttribute("userType");
        
        // ✅ YE CODE YAHAAN HAI
        if (!"employer".equals(userType)) {
            System.out.println("❌ userType is not 'employer', it is: " + userType);
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Please+login+as+employer");
            return;
        }

        Integer employerId = (Integer) session.getAttribute("employerId");
        
        // ✅ YE CODE YAHAAN HAI
        if (employerId == null) {
            System.out.println("❌ employerId is NULL");
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid+session");
            return;
        }

        System.out.println("✅ Session valid, employer ID: " + employerId);

        // Get form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String category = request.getParameter("category");
        String salary = request.getParameter("salary");

        System.out.println("Job Details:");
        System.out.println("  Title: " + title);
        System.out.println("  Location: " + location);
        System.out.println("  Category: " + category);

        // Add job to database
     // Add job to database using Job object
        Job job = new Job();

        job.setEmployerId(employerId);
        job.setTitle(title);
        job.setDescription(description);
        job.setLocation(location);
             // Make sure your form has jobType
        // Make sure your form has experience
        job.setSalary(salary);
     // Form should submit deadline

        boolean success = jobDAO.addJob(job);

        if (success) {
            System.out.println("✅ Job posted successfully!");
            response.sendRedirect(request.getContextPath() + "/employerDashboard?success=Job+posted+successfully");
        } else {
            System.out.println("❌ Failed to post job");
            response.sendRedirect(request.getContextPath() + "/postJob.jsp?error=Failed+to+post+job");
        }


        System.out.println("======================\n");
    }
}