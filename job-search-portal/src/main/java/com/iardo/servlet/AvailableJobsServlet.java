package com.iardo.servlet;

import com.iardo.dao.JobDAO;
import com.iardo.model.Job;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import com.google.gson.Gson;


@WebServlet("/AvailableJobsServlet")
public class AvailableJobsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String location = request.getParameter("location");
        List<Job> jobs = new ArrayList<>();

        if (location != null && !location.trim().isEmpty()) {
            JobDAO jobDAO = new JobDAO();
            jobs = jobDAO.getJobsByLocation(location);
        }

        String json = new Gson().toJson(jobs);
        response.getWriter().write(json);
    }
}
