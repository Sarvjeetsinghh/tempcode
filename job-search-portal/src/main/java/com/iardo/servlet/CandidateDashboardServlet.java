package com.iardo.servlet;

import java.io.IOException;

import com.iardo.model.Candidate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile-dashboard")
	public class CandidateDashboardServlet extends HttpServlet {

	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);

	        // Not logged in
	        if (session == null || session.getAttribute("loggedCandidate") == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        // Logged in user
	        Candidate candidate = (Candidate) session.getAttribute("loggedCandidate");
	        request.setAttribute("candidate", candidate);

	        request.getRequestDispatcher("profile-dashboard.jsp").forward(request, response);
	    }
	}


