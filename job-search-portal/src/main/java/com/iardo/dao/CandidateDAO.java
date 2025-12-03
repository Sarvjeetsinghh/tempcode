package com.iardo.dao;

import com.iardo.model.Candidate;
import com.iardo.util.DBConnection;
import java.sql.*;

public class CandidateDAO {

    // Register new candidate
    public boolean registerCandidate(Candidate c) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO candidates(name, email, password, phone, gender, category, registrationDate) VALUES(?,?,?,?,?,?, NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, c.getFullName());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getPassword());
            ps.setString(4, c.getPhone());
            ps.setString(5, c.getGender());
            ps.setString(6, c.getCategory());

            int i = ps.executeUpdate();
            status = (i > 0);

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public Candidate getCandidateByEmail(String email) {
        Candidate c = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM candidates WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Candidate();
                c.setId(rs.getInt("id"));
                c.setFullName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPassword(rs.getString("password"));
                c.setPhone(rs.getString("phone"));
                c.setGender(rs.getString("gender"));
                c.setCategory(rs.getString("category"));
                c.setDob(rs.getString("dob"));
                c.setExperience(rs.getString("experience"));
                
                // FIX: Use consistent column name 'profilePicture'
                c.setProfilePicture(rs.getString("profilePicture"));
                c.setCv(rs.getString("cv"));
                c.setRegistrationDate(rs.getString("registrationDate"));

                // New fields
                c.setSkills(rs.getString("skills"));
                c.setEmployment(rs.getString("employment"));
                c.setEducation(rs.getString("education"));
                c.setProjects(rs.getString("projects"));
                c.setCertifications(rs.getString("certifications"));
                c.setAchievements(rs.getString("achievements"));
                c.setProfileCompletion(rs.getInt("profileCompletion"));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            System.err.println("Error in getCandidateByEmail:");
            e.printStackTrace();
        }
        return c;
    }

    // Get candidate by ID
    public Candidate getCandidateById(int id) {
        Candidate c = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM candidates WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Candidate();
                c.setId(id);
                c.setFullName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                c.setGender(rs.getString("gender"));
                c.setCategory(rs.getString("category"));
                c.setDob(rs.getString("dob"));
                c.setExperience(rs.getString("experience"));
                
                // FIX: Use consistent column name 'profilePicture'
                c.setProfilePicture(rs.getString("profilePicture"));
                c.setSkills(rs.getString("skills"));
                c.setEmployment(rs.getString("employment"));
                c.setEducation(rs.getString("education"));
                c.setProjects(rs.getString("projects"));
                c.setCertifications(rs.getString("certifications"));
                c.setAchievements(rs.getString("achievements"));
                c.setProfileCompletion(rs.getInt("profileCompletion"));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            System.err.println("Error in getCandidateById:");
            e.printStackTrace();
        }
        return c;
    }

    // Update candidate profile
    public boolean updateCandidateProfile(Candidate c) {
        boolean status = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            
            // FIX: Use consistent column name 'profilePicture' (not profile_picture)
            String sql;
            if (c.getProfilePicture() != null && !c.getProfilePicture().isEmpty()) {
                sql = "UPDATE candidates SET name=?, phone=?, gender=?, category=?, dob=?, " +
                      "experience=?, skills=?, employment=?, education=?, projects=?, " +
                      "certifications=?, achievements=?, profilePicture=?, profileCompletion=? " +
                      "WHERE email=?";
            } else {
                sql = "UPDATE candidates SET name=?, phone=?, gender=?, category=?, dob=?, " +
                      "experience=?, skills=?, employment=?, education=?, projects=?, " +
                      "certifications=?, achievements=?, profileCompletion=? " +
                      "WHERE email=?";
            }

            ps = conn.prepareStatement(sql);
            
            int paramIndex = 1;
            ps.setString(paramIndex++, c.getFullName());
            ps.setString(paramIndex++, c.getPhone());
            ps.setString(paramIndex++, c.getGender());
            ps.setString(paramIndex++, c.getCategory());
            ps.setString(paramIndex++, c.getDob());
            
            // FIX: Truncate experience to avoid data truncation error
            String experience = c.getExperience();
            if (experience != null && experience.length() > 50) {
                experience = experience.substring(0, 50);
            }
            ps.setString(paramIndex++, experience);
            
            ps.setString(paramIndex++, c.getSkills());
            ps.setString(paramIndex++, c.getEmployment());
            ps.setString(paramIndex++, c.getEducation());
            ps.setString(paramIndex++, c.getProjects());
            ps.setString(paramIndex++, c.getCertifications());
            ps.setString(paramIndex++, c.getAchievements());
            
            if (c.getProfilePicture() != null && !c.getProfilePicture().isEmpty()) {
                ps.setString(paramIndex++, c.getProfilePicture());
            }
            
            ps.setInt(paramIndex++, c.getProfileCompletion());
            ps.setString(paramIndex++, c.getEmail());

            int rowsUpdated = ps.executeUpdate();
            status = (rowsUpdated > 0);

            System.out.println("Update query executed. Rows affected: " + rowsUpdated);

        } catch (SQLException e) {
            System.err.println("SQL Exception in updateCandidateProfile:");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Exception in updateCandidateProfile:");
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return status;
    }

    // Update CV
    public boolean updateCV(String email, String cvPath) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE candidates SET cv=? WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, cvPath);
            ps.setString(2, email);

            int i = ps.executeUpdate();
            status = (i > 0);

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Update profile picture only
    public boolean updateProfilePicture(String email, String picturePath) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE candidates SET profilePicture=? WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, picturePath);
            ps.setString(2, email);

            int i = ps.executeUpdate();
            status = (i > 0);

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Update password
    public boolean updatePassword(String email, String newPassword) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE candidates SET password=? WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int i = ps.executeUpdate();
            status = (i > 0);

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Check if email already exists (for registration validation)
    public boolean emailExists(String email) {
        boolean exists = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT id FROM candidates WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            exists = rs.next();

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    // Delete candidate (optional - for admin features)
    public boolean deleteCandidate(int id) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM candidates WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int i = ps.executeUpdate();
            status = (i > 0);

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

}