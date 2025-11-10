package com.iardo.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.iardo.dao.JobDAO;
import com.iardo.model.Job;

@WebServlet("/AddJobServlet")
public class AddJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ✅ Get form parameters from JSP
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String company = req.getParameter("company");
        String location = req.getParameter("location");
        String salaryStr = req.getParameter("salary");

        double salary = 0.0;
        try {
            salary = Double.parseDouble(salaryStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // ✅ Create a new Job object
        Job job = new Job();
        job.setTitle(title);
        job.setDescription(description);
        job.setCompany(company);
        job.setLocation(location);
        job.setSalary(salary);

        // ✅ Save job in database using DAO
        JobDAO dao = new JobDAO();
        boolean result = dao.addJob(job);

        // ✅ Redirect based on result
        if (result) {
            res.sendRedirect("available-jobs.jsp?msg=success");
        } else {
            res.sendRedirect("add-job.jsp?msg=error");
        }
    }

    // Optional: Handle GET request by redirecting to job form page
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("add-job.jsp");
    }
}
