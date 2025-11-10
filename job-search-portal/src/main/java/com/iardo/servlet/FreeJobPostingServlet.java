package com.iardo.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.iardo.dao.JobDAO;
import com.iardo.model.Job;

@WebServlet("/FreeJobPostingServlet")
public class FreeJobPostingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ✅ Check if employer is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("employerId") == null) {
            res.sendRedirect("employer-login.jsp?msg=Please login first to post jobs");
            return;
        }

        try {
            // ✅ Get employer ID from session
            int employerId = (int) session.getAttribute("employerId");

            // ✅ Get form data
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String company = req.getParameter("company");
            String location = req.getParameter("location");
            double salary = Double.parseDouble(req.getParameter("salary"));
            String website = req.getParameter("website");

            // ✅ Create Job object
            Job job = new Job();
            job.setTitle(title);
            job.setDescription(description);
            job.setCompany(company);
            job.setLocation(location);
            job.setSalary(salary);
            job.setWebsite(website);
        

            // ✅ Save job to database using DAO
            JobDAO jobDAO = new JobDAO();
            boolean success = jobDAO.addJob(job);

            if (success) {
                req.setAttribute("msg", "✅ Job posted successfully!");
            } else {
                req.setAttribute("msg", "❌ Failed to post job. Please try again.");
            }

            // ✅ Redirect back to form with message
            RequestDispatcher rd = req.getRequestDispatcher("free-job-posting.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "⚠️ Error occurred while posting job.");
            RequestDispatcher rd = req.getRequestDispatcher("free-job-posting.jsp");
            rd.forward(req, res);
        }
    }
}
