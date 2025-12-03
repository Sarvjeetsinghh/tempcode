package com.iardo.servlet;

import com.iardo.dao.CandidateDAO;
import com.iardo.dao.ResumeDAO;
import com.iardo.model.Candidate;
import com.iardo.model.Resume;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/uploadResume")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class ResumeUploadServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "resumes";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;
    
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
            Part filePart = request.getPart("resumeFile");
            
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect("myResume.jsp?error=Please select a file to upload");
                return;
            }
            
            if (filePart.getSize() > MAX_FILE_SIZE) {
                response.sendRedirect("myResume.jsp?error=File size must be less than 5MB");
                return;
            }
            
            String fileName = getFileName(filePart);
            String fileExtension = getFileExtension(fileName);
            
            if (!isValidFileType(fileExtension)) {
                response.sendRedirect("myResume.jsp?error=Invalid file type. Only PDF, DOC, and DOCX are allowed");
                return;
            }
            
            String uniqueFileName = System.currentTimeMillis() + "_" + 
                                   candidate.getId() + "_" + fileName;
            
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            String filePath = uploadPath + File.separator + uniqueFileName;
            Files.copy(filePart.getInputStream(), 
                      Paths.get(filePath), 
                      StandardCopyOption.REPLACE_EXISTING);
            
            ResumeDAO resumeDAO = new ResumeDAO();
            
            // Check if user wants to make this primary or if this is their first resume
            String makePrimaryParam = request.getParameter("makePrimary");
            boolean isPrimary = "true".equals(makePrimaryParam) || 
                               resumeDAO.getResumesByCandidateId(candidate.getId()).isEmpty();
            
            Resume resume = new Resume();
            resume.setCandidateId(candidate.getId());
            resume.setFileName(fileName);
            resume.setFilePath(UPLOAD_DIR + "/" + uniqueFileName);
            resume.setFileType(fileExtension);
            resume.setFileSize(filePart.getSize());
            resume.setIsPrimary(isPrimary);
            
            boolean uploaded = resumeDAO.addResume(resume);
            
            if (uploaded) {
                response.sendRedirect("myResume.jsp?success=Resume uploaded successfully");
            } else {
                new File(filePath).delete();
                response.sendRedirect("myResume.jsp?error=Failed to save resume");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myResume.jsp?error=" + e.getMessage());
        }
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
    private String getFileExtension(String fileName) {
        if (fileName == null) return "";
        int dotIndex = fileName.lastIndexOf('.');
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex + 1).toLowerCase();
    }
    
    private boolean isValidFileType(String extension) {
        return extension.equals("pdf") || 
               extension.equals("doc") || 
               extension.equals("docx");
    }
}