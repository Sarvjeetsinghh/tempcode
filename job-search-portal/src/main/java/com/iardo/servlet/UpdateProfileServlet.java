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

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UpdateProfileServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads/profiles";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userType") == null 
            || !"candidate".equals(session.getAttribute("userType"))) {
            response.sendRedirect("login.jsp?error=Please+login+first!");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        
        try {
            // Get form parameters
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String category = request.getParameter("category");
            String dob = request.getParameter("dob");
            String experience = request.getParameter("experience");
            String skills = request.getParameter("skills");
            String employment = request.getParameter("employment");
            String education = request.getParameter("education");
            String projects = request.getParameter("projects");
            String certifications = request.getParameter("certifications");
            String achievements = request.getParameter("achievements");

            // First, get current candidate data to preserve existing profile picture
            CandidateDAO dao = new CandidateDAO();
            Candidate existingCandidate = dao.getCandidateByEmail(userEmail);
            
            // Handle file upload for profile picture
            String profilePicturePath = null;
            Part filePart = request.getPart("profilePicture");
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                
                // Validate file extension
                String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
                if (!fileExtension.matches("\\.(jpg|jpeg|png|gif)")) {
                    response.sendRedirect("editProfile.jsp?error=Only+image+files+allowed");
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
                    uploadDir.mkdirs();
                    System.out.println("✅ Upload directory created: " + uploadFilePath);
                }
                
                // Save the file
                String filePath = uploadFilePath + File.separator + uniqueFileName;
                filePart.write(filePath);
                
                // Store relative path for database
                profilePicturePath = UPLOAD_DIR + "/" + uniqueFileName;
                
                System.out.println("✅ Profile picture uploaded: " + profilePicturePath);
                
                // Delete old profile picture if exists
                if (existingCandidate != null && existingCandidate.getProfilePicture() != null 
                    && !existingCandidate.getProfilePicture().isEmpty()
                    && !existingCandidate.getProfilePicture().contains("default")) {
                    
                    String oldFilePath = applicationPath + File.separator + existingCandidate.getProfilePicture();
                    File oldFile = new File(oldFilePath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                        System.out.println("   Old profile picture deleted");
                    }
                }
            } else {
                // No new file uploaded, keep existing profile picture
                if (existingCandidate != null && existingCandidate.getProfilePicture() != null) {
                    profilePicturePath = existingCandidate.getProfilePicture();
                    System.out.println("ℹ️  Keeping existing profile picture");
                }
            }

            // Create candidate object with updated data
            Candidate candidate = new Candidate();
            candidate.setFullName(name);
            candidate.setEmail(userEmail);
            candidate.setPhone(phone);
            candidate.setGender(gender);
            candidate.setCategory(category);
            candidate.setDob(dob);
            candidate.setExperience(experience);
            candidate.setSkills(skills);
            candidate.setEmployment(employment);
            candidate.setEducation(education);
            candidate.setProjects(projects);
            candidate.setCertifications(certifications);
            candidate.setAchievements(achievements);
            
            // Set profile picture
            if (profilePicturePath != null && !profilePicturePath.isEmpty()) {
                candidate.setProfilePicture(profilePicturePath);
            }

            // Calculate profile completion percentage
            int completionPercentage = calculateProfileCompletion(candidate);
            candidate.setProfileCompletion(completionPercentage);

            System.out.println("📊 Profile completion: " + completionPercentage + "%");

            // Update in database
            boolean updated = dao.updateCandidateProfile(candidate);

            if (updated) {
                // Fetch updated candidate object
                Candidate updatedCandidate = dao.getCandidateByEmail(userEmail);
                
                // Update session attributes - SINGLE attribute name
                session.setAttribute("candidateName", name);
                session.setAttribute("candidate", updatedCandidate);  // Update session
                
                System.out.println("✅ Profile updated successfully for: " + userEmail);
                response.sendRedirect("candidateDashboard.jsp?success=Profile+updated+successfully");
            } else {
                System.out.println("❌ Failed to update profile");
                response.sendRedirect("editProfile.jsp?error=Failed+to+update+profile");
            }

        } catch (Exception e) {
            System.err.println("❌ Exception in UpdateProfileServlet:");
            e.printStackTrace();
            response.sendRedirect("editProfile.jsp?error=Server+error");
        }
    }

    /**
     * Calculate profile completion percentage
     */
    private int calculateProfileCompletion(Candidate candidate) {
        int totalFields = 14;
        int filledFields = 0;

        if (candidate.getFullName() != null && !candidate.getFullName().trim().isEmpty()) filledFields++;
        if (candidate.getEmail() != null && !candidate.getEmail().trim().isEmpty()) filledFields++;
        if (candidate.getPhone() != null && !candidate.getPhone().trim().isEmpty()) filledFields++;
        if (candidate.getGender() != null && !candidate.getGender().trim().isEmpty()) filledFields++;
        if (candidate.getCategory() != null && !candidate.getCategory().trim().isEmpty()) filledFields++;
        if (candidate.getDob() != null && !candidate.getDob().trim().isEmpty()) filledFields++;
        if (candidate.getExperience() != null && !candidate.getExperience().trim().isEmpty()) filledFields++;
        if (candidate.getSkills() != null && !candidate.getSkills().trim().isEmpty()) filledFields++;
        if (candidate.getEmployment() != null && !candidate.getEmployment().trim().isEmpty()) filledFields++;
        if (candidate.getEducation() != null && !candidate.getEducation().trim().isEmpty()) filledFields++;
        if (candidate.getProjects() != null && !candidate.getProjects().trim().isEmpty()) filledFields++;
        if (candidate.getCertifications() != null && !candidate.getCertifications().trim().isEmpty()) filledFields++;
        if (candidate.getAchievements() != null && !candidate.getAchievements().trim().isEmpty()) filledFields++;
        if (candidate.getProfilePicture() != null && !candidate.getProfilePicture().trim().isEmpty()) filledFields++;

        return (int) ((filledFields * 100.0) / totalFields);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("editProfile.jsp");
    }
}