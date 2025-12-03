package com.iardo.servlet;

import com.iardo.dao.CandidateDAO;
import com.iardo.dao.ResumeDAO;
import com.iardo.model.Candidate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/makePrimaryResume")
public class MakePrimaryResumeServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }
        
        String userEmail = (String) session.getAttribute("userEmail");
        CandidateDAO candidateDAO = new CandidateDAO();
        Candidate candidate = candidateDAO.getCandidateByEmail(userEmail);
        
        if (candidate == null) {
            response.sendRedirect("login.jsp?error=User not found");
            return;
        }
        
        try {
            int resumeId = Integer.parseInt(request.getParameter("resumeId"));
            
            ResumeDAO resumeDAO = new ResumeDAO();
            boolean success = resumeDAO.makePrimary(resumeId, candidate.getId());
            
            if (success) {
                response.sendRedirect("myResume.jsp?success=Resume set as primary successfully");
            } else {
                response.sendRedirect("myResume.jsp?error=Failed to set resume as primary");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myResume.jsp?error=" + e.getMessage());
        }
    }
}



