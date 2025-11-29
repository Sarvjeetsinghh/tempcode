package com.iardo.dao;

import com.iardo.model.Job;
import com.iardo.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    /**
     * Get all jobs posted by a specific employer
     */
    public List<Job> getJobsByEmployer(int employerId) {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE employerId = ? ORDER BY postedDate DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, employerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setEmployerId(rs.getInt("employerId"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setJobType(rs.getString("jobType"));
                job.setSalary(rs.getString("salary"));
                job.setExperience(rs.getString("experience"));
                job.setSkills(rs.getString("skills"));
                job.setStatus(rs.getString("status"));
                job.setPostedDate(rs.getTimestamp("postedDate"));
                job.setDeadline(rs.getTimestamp("deadline"));

                jobs.add(job);
            }

            System.out.println("✅ Fetched " + jobs.size() + " jobs for employer ID: " + employerId);

        } catch (SQLException e) {
            System.err.println("❌ Error fetching jobs for employer: " + employerId);
            e.printStackTrace();
        }

        return jobs;
    }

    /**
     * Get all active jobs
     */
    public List<Job> getAllActiveJobs() {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE status = 'Active' ORDER BY postedDate DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Job job = extractJobFromResultSet(rs);
                jobs.add(job);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching active jobs");
            e.printStackTrace();
        }

        return jobs;
    }

    /**
     * Get job by ID
     */
    public Job getJobById(int jobId) {
        String sql = "SELECT * FROM jobs WHERE id = ?";
        Job job = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                job = extractJobFromResultSet(rs);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching job ID: " + jobId);
            e.printStackTrace();
        }

        return job;
    }

    /**
     * Add new job (alias for createJob)
     */
    public boolean addJob(Job job) {
        return createJob(job);
    }

    /**
     * Create new job
     */
    public boolean createJob(Job job) {
        String sql = "INSERT INTO jobs (employerId, title, description, location, jobType, " +
                     "salary, experience, skills, status, postedDate, deadline) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, job.getEmployerId());
            ps.setString(2, job.getTitle());
            ps.setString(3, job.getDescription());
            ps.setString(4, job.getLocation());
            ps.setString(5, job.getJobType());
            ps.setString(6, job.getSalary());
            ps.setString(7, job.getExperience());
            ps.setString(8, job.getSkills());
            ps.setString(9, job.getStatus());
            ps.setTimestamp(10, job.getDeadline());

            int rowsInserted = ps.executeUpdate();
            System.out.println("✅ Job created: " + job.getTitle());
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error creating job");
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update job
     */
    public boolean updateJob(Job job) {
        String sql = "UPDATE jobs SET title=?, description=?, location=?, jobType=?, " +
                     "salary=?, experience=?, skills=?, status=?, deadline=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, job.getTitle());
            ps.setString(2, job.getDescription());
            ps.setString(3, job.getLocation());
            ps.setString(4, job.getJobType());
            ps.setString(5, job.getSalary());
            ps.setString(6, job.getExperience());
            ps.setString(7, job.getSkills());
            ps.setString(8, job.getStatus());
            ps.setTimestamp(9, job.getDeadline());
            ps.setInt(10, job.getId());

            int rowsUpdated = ps.executeUpdate();
            System.out.println("✅ Job updated: ID " + job.getId());
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error updating job");
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete job
     */
    public boolean deleteJob(int jobId) {
        String sql = "DELETE FROM jobs WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, jobId);
            int rowsDeleted = ps.executeUpdate();
            System.out.println("✅ Job deleted: ID " + jobId);
            return rowsDeleted > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error deleting job");
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Search jobs by keyword
     */
    public List<Job> searchJobs(String keyword) {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE status = 'Active' AND " +
                     "(title LIKE ? OR description LIKE ? OR skills LIKE ?) " +
                     "ORDER BY postedDate DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                jobs.add(extractJobFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("❌ Error searching jobs");
            e.printStackTrace();
        }

        return jobs;
    }

    /**
     * Helper method to extract Job from ResultSet
     */
    private Job extractJobFromResultSet(ResultSet rs) throws SQLException {
        Job job = new Job();
        job.setId(rs.getInt("id"));
        job.setEmployerId(rs.getInt("employerId"));
        job.setTitle(rs.getString("title"));
        job.setDescription(rs.getString("description"));
        job.setLocation(rs.getString("location"));
        job.setJobType(rs.getString("jobType"));
        job.setSalary(rs.getString("salary"));
        job.setExperience(rs.getString("experience"));
        job.setSkills(rs.getString("skills"));
        job.setStatus(rs.getString("status"));
        job.setPostedDate(rs.getTimestamp("postedDate"));
        job.setDeadline(rs.getTimestamp("deadline"));
        return job;
    }
}