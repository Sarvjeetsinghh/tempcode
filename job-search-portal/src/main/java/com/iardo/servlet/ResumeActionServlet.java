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

@WebServlet("/resumeAction")
public class ResumeActionServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }
        
        String userEmail = (String) session.getAttribute("userEmail");
        String action = request.getParameter("action");
        String resumeIdStr = request.getParameter("resumeId");
        
        if (resumeIdStr == null || action == null) {
            response.sendRedirect("myResume.jsp?error=Invalid request");
            return;
        }
        
        try {
            int resumeId = Integer.parseInt(resumeIdStr);
            
            // Get candidate details
            CandidateDAO candidateDAO = new CandidateDAO();
            Candidate candidate = candidateDAO.getCandidateByEmail(userEmail);
            
            if (candidate == null) {
                response.sendRedirect("login.jsp?error=User not found");
                return;
            }
            
            ResumeDAO resumeDAO = new ResumeDAO();
            Resume resume = resumeDAO.getResumeById(resumeId);
            
            // Verify the resume belongs to this candidate
            if (resume == null || resume.getCandidateId() != candidate.getId()) {
                response.sendRedirect("myResume.jsp?error=Unauthorized access");
                return;
            }
            
            switch (action) {
                case "download":
                    handleDownload(request, response, resume, resumeDAO);
                    break;
                    
                case "preview":
                    handlePreview(request, response, resume, resumeDAO);
                    break;
                    
                case "delete":
                	handleDelete(request, response, resume, resumeDAO, candidate.getId());
                    break;
                    
                case "makePrimary":
                    handleMakePrimary(request, response, resumeId, candidate.getId(), resumeDAO);
                    break;
                    
                default:
                    response.sendRedirect("myResume.jsp?error=Invalid action");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("myResume.jsp?error=Invalid resume ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myResume.jsp?error=An error occurred: " + e.getMessage());
        }
    }
    
    private void handleDownload(HttpServletRequest request, HttpServletResponse response, 
                               Resume resume, ResumeDAO resumeDAO) throws IOException {
        String applicationPath = request.getServletContext().getRealPath("");
        String filePath = applicationPath + File.separator + resume.getFilePath();
        File file = new File(filePath);
        
        if (!file.exists()) {
            response.sendRedirect("myResume.jsp?error=File not found");
            return;
        }
        
        // Set content type based on file extension
        String mimeType = getMimeType(resume.getFileType());
        response.setContentType(mimeType);
        response.setHeader("Content-Disposition", "attachment; filename=\"" + resume.getFileName() + "\"");
        response.setContentLengthLong(file.length());
        
        // Increment download count
        resumeDAO.incrementDownloads(resume.getResumeId());
        
        // Write file to response
        try (FileInputStream inStream = new FileInputStream(file);
             OutputStream outStream = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
        }
    }
    
    private void handlePreview(HttpServletRequest request, HttpServletResponse response,
                              Resume resume, ResumeDAO resumeDAO) throws IOException {
        String applicationPath = request.getServletContext().getRealPath("");
        String filePath = applicationPath + File.separator + resume.getFilePath();
        File file = new File(filePath);
        
        if (!file.exists()) {
            response.sendRedirect("myResume.jsp?error=File not found");
            return;
        }
        
        // Set content type for inline display
        String mimeType = getMimeType(resume.getFileType());
        response.setContentType(mimeType);
        response.setHeader("Content-Disposition", "inline; filename=\"" + resume.getFileName() + "\"");
        response.setContentLengthLong(file.length());
        
        // Increment view count
        resumeDAO.incrementViews(resume.getResumeId());
        
        // Write file to response
        try (FileInputStream inStream = new FileInputStream(file);
             OutputStream outStream = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
        }
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response,
                             Resume resume, ResumeDAO resumeDAO, int candidateId) throws IOException {
        
        // Delete file from disk
        String applicationPath = request.getServletContext().getRealPath("");
        String filePath = applicationPath + File.separator + resume.getFilePath();
        File file = new File(filePath);
        
        if (file.exists()) {
            file.delete();
        }
        
        // Delete from database
        boolean deleted = resumeDAO.deleteResume(resume.getResumeId(), candidateId);
        
        if (deleted) {
            // If deleted resume was primary, make another resume primary
            if (resume.isPrimary()) {
                var resumes = resumeDAO.getResumesByCandidateId(candidateId);
                if (!resumes.isEmpty()) {
                    resumeDAO.makePrimary(resumes.get(0).getResumeId(), candidateId);
                }
            }
            response.sendRedirect("myResume.jsp?success=Resume deleted successfully");
        } else {
            response.sendRedirect("myResume.jsp?error=Failed to delete resume");
        }
    }
    
    private void handleMakePrimary(HttpServletRequest request, HttpServletResponse response,
                                  int resumeId, int candidateId, ResumeDAO resumeDAO) throws IOException {
        boolean updated = resumeDAO.makePrimary(resumeId, candidateId);
        
        if (updated) {
            response.sendRedirect("myResume.jsp?success=Primary resume updated successfully");
        } else {
            response.sendRedirect("myResume.jsp?error=Failed to update primary resume");
        }
    }
    
    private String getMimeType(String fileType) {
        switch (fileType.toLowerCase()) {
            case "pdf":
                return "application/pdf";
            case "doc":
                return "application/msword";
            case "docx":
                return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            default:
                return "application/octet-stream";
        }
    }
}