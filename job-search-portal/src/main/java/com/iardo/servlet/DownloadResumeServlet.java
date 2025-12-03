package com.iardo.servlet;

import com.iardo.dao.CandidateDAO;
import com.iardo.dao.ResumeDAO;
import com.iardo.model.Candidate;
import com.iardo.model.Resume;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/downloadResume")
public class DownloadResumeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
            int resumeId = Integer.parseInt(request.getParameter("id"));
            
            ResumeDAO resumeDAO = new ResumeDAO();
            Resume resume = resumeDAO.getResumeById(resumeId);
            
            if (resume == null || resume.getCandidateId() != candidate.getId()) {
                response.sendRedirect("myResume.jsp?error=Resume not found or unauthorized");
                return;
            }
            
            // Increment download count
            resumeDAO.incrementDownloads(resumeId);
            
            // Get file
            String applicationPath = request.getServletContext().getRealPath("");
            String fullPath = applicationPath + File.separator + resume.getFilePath();
            File file = new File(fullPath);
            
            if (!file.exists()) {
                response.sendRedirect("myResume.jsp?error=File not found on server");
                return;
            }
            
            // Set response headers
            response.setContentType("application/octet-stream");
            response.setContentLength((int) file.length());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + resume.getFileName() + "\"");
            
            // Write file to response
            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = response.getOutputStream()) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myResume.jsp?error=" + e.getMessage());
        }
    }
}