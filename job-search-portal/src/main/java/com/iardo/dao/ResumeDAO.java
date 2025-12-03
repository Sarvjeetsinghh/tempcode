package com.iardo.dao;

import com.iardo.model.Resume;
import com.iardo.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResumeDAO {
    
    // Add new resume
    public boolean addResume(Resume resume) {
        String sql = "INSERT INTO resumes (candidate_id, file_name, file_path, file_type, " +
                     "file_size, is_primary, views, downloads) VALUES (?, ?, ?, ?, ?, ?, 0, 0)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // If this is primary, make all other resumes non-primary first
            if (resume.isPrimary()) {
                makeAllNonPrimary(resume.getCandidateId());
            }
            
            pstmt.setInt(1, resume.getCandidateId());
            pstmt.setString(2, resume.getFileName());
            pstmt.setString(3, resume.getFilePath());
            pstmt.setString(4, resume.getFileType());
            pstmt.setLong(5, resume.getFileSize());
            pstmt.setBoolean(6, resume.isPrimary());
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all resumes for a candidate
    public List<Resume> getResumesByCandidateId(int candidateId) {
        List<Resume> resumes = new ArrayList<>();
        String sql = "SELECT * FROM resumes WHERE candidate_id = ? ORDER BY is_primary DESC, uploaded_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, candidateId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Resume resume = extractResumeFromResultSet(rs);
                resumes.add(resume);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return resumes;
    }
    
    // Get resume by ID
    public Resume getResumeById(int resumeId) {
        String sql = "SELECT * FROM resumes WHERE resume_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, resumeId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractResumeFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get primary resume for a candidate
    public Resume getPrimaryResume(int candidateId) {
        String sql = "SELECT * FROM resumes WHERE candidate_id = ? AND is_primary = true";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, candidateId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractResumeFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Make a resume primary
    public boolean makePrimary(int resumeId, int candidateId) {
        try (Connection conn = DBConnection.getConnection()) {
            // First, make all resumes non-primary
            makeAllNonPrimary(candidateId);
            
            // Then make this one primary
            String sql = "UPDATE resumes SET is_primary = true WHERE resume_id = ? AND candidate_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, resumeId);
            pstmt.setInt(2, candidateId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Make all resumes non-primary for a candidate
    private void makeAllNonPrimary(int candidateId) {
        String sql = "UPDATE resumes SET is_primary = false WHERE candidate_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, candidateId);
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Delete resume
    public boolean deleteResume(int resumeId, int candidateId) {
        String sql = "DELETE FROM resumes WHERE resume_id = ? AND candidate_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, resumeId);
            pstmt.setInt(2, candidateId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Increment view count
    public void incrementViews(int resumeId) {
        String sql = "UPDATE resumes SET views = views + 1 WHERE resume_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, resumeId);
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Increment download count
    public void incrementDownloads(int resumeId) {
        String sql = "UPDATE resumes SET downloads = downloads + 1 WHERE resume_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, resumeId);
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Get total statistics for a candidate
    public ResumeStats getResumeStats(int candidateId) {
        String sql = "SELECT SUM(views) as total_views, SUM(downloads) as total_downloads, " +
                     "COUNT(*) as total_resumes FROM resumes WHERE candidate_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, candidateId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return new ResumeStats(
                    rs.getInt("total_views"),
                    rs.getInt("total_downloads"),
                    rs.getInt("total_resumes")
                );
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return new ResumeStats(0, 0, 0);
    }
    
    // Helper method to extract Resume from ResultSet
    private Resume extractResumeFromResultSet(ResultSet rs) throws SQLException {
        Resume resume = new Resume();
        resume.setResumeId(rs.getInt("resume_id"));
        resume.setCandidateId(rs.getInt("candidate_id"));
        resume.setFileName(rs.getString("file_name"));
        resume.setFilePath(rs.getString("file_path"));
        resume.setFileType(rs.getString("file_type"));
        resume.setFileSize(rs.getLong("file_size"));
        resume.setIsPrimary(rs.getBoolean("is_primary"));
        resume.setViews(rs.getInt("views"));
        resume.setDownloads(rs.getInt("downloads"));
        resume.setUploadedAt(rs.getTimestamp("uploaded_at"));
        return resume;
    }
    
    // Inner class for statistics
    public static class ResumeStats {
        public int totalViews;
        public int totalDownloads;
        public int totalResumes;
        
        public ResumeStats(int totalViews, int totalDownloads, int totalResumes) {
            this.totalViews = totalViews;
            this.totalDownloads = totalDownloads;
            this.totalResumes = totalResumes;
        }
    }
}