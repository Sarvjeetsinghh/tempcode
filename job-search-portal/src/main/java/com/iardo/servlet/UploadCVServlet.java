package com.iardo.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import com.iardo.dao.CandidateDAO;
import com.iardo.model.Candidate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/UploadCVServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 15,       // 15MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UploadCVServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads/cvs";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userType") == null 
            || !"candidate".equals(session.getAttribute("userType"))) {
            response.sendRedirect("login.jsp?error=Please login first!");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        
        try {
            // Get the uploaded file part
            Part filePart = request.getPart("cvFile");
            
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect("uploadCV.jsp?error=Please select a CV file to upload!");
                return;
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Validate file extension (only PDF, DOC, DOCX)
            String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
            if (!fileExtension.matches("\\.(pdf|doc|docx)")) {
                response.sendRedirect("uploadCV.jsp?error=Only PDF, DOC, and DOCX files are allowed!");
                return;
            }
            
            // Check file size (max 15MB)
            if (filePart.getSize() > 15 * 1024 * 1024) {
                response.sendRedirect("uploadCV.jsp?error=File size must be less than 15MB!");
                return;
            }
            
            // Generate unique filename
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            
            // Get the real path to save files
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            // Create directory if it doesn't exist
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                System.out.println("CV upload directory created: " + created + " at " + uploadFilePath);
            }
            
            // Get existing candidate to check for old CV
            CandidateDAO dao = new CandidateDAO();
            Candidate existingCandidate = dao.getCandidateByEmail(userEmail);
            
            // Delete old CV file if exists
            if (existingCandidate != null && existingCandidate.getCv() != null 
                && !existingCandidate.getCv().isEmpty()) {
                
                String oldFilePath = applicationPath + File.separator + existingCandidate.getCv();
                File oldFile = new File(oldFilePath);
                if (oldFile.exists()) {
                    boolean deleted = oldFile.delete();
                    System.out.println("Old CV deleted: " + deleted);
                }
            }
            
            // Save the new file
            String filePath = uploadFilePath + File.separator + uniqueFileName;
            filePart.write(filePath);
            
            // Store relative path for database (for web access)
            String cvPath = UPLOAD_DIR + "/" + uniqueFileName;
            
            System.out.println("✅ CV uploaded successfully!");
            System.out.println("   File saved at: " + filePath);
            System.out.println("   Database path: " + cvPath);

            // Update CV path in database
            boolean updated = dao.updateCV(userEmail, cvPath);

            if (updated) {
                System.out.println("✅ CV path updated in database for: " + userEmail);
                response.sendRedirect("candidateDashboard.jsp?success=CV uploaded successfully!");
            } else {
                System.out.println("❌ Failed to update CV in database for: " + userEmail);
                response.sendRedirect("uploadCV.jsp?error=Failed to save CV. Please try again.");
            }

        } catch (Exception e) {
            System.err.println("❌ Exception in UploadCVServlet:");
            e.printStackTrace();
            response.sendRedirect("uploadCV.jsp?error=Server error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to upload CV page
        response.sendRedirect("uploadCV.jsp");
    }
}