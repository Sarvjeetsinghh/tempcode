package com.iardo.dao;

import java.sql.*;
import java.util.*;

import com.iardo.model.Job;
import com.iardo.util.DBConnection;

public class JobDAO {
    private Connection con;

    public JobDAO() {
        con = DBConnection.getConnection();
    }

    public boolean addJob(Job job) {
        boolean result = false;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO jobs (title, description, company, location, salary, website, posted_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, job.getTitle());
            ps.setString(2, job.getDescription());
            ps.setString(3, job.getCompany());
            ps.setString(4, job.getLocation());
            ps.setDouble(5, job.getSalary());
            ps.setString(6, job.getWebsite());
         

            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Job> getAllJobs() {
        List<Job> list = new ArrayList<>();
        String query = "SELECT * FROM jobs ORDER BY post_date DESC";
        try (Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                Job j = new Job();
                j.setId(rs.getInt("id"));
                j.setTitle(rs.getString("title"));
                j.setDescription(rs.getString("description"));
                j.setCompany(rs.getString("company"));
                j.setLocation(rs.getString("location"));
                j.setSalary(rs.getDouble("salary"));
                list.add(j);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

	public List<Job> getJobsByLocation(String location) {
		List<Job> jobs = new ArrayList<>();
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement("SELECT * FROM jobs WHERE location = ?");
	        ps.setString(1, location);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Job job = new Job();
	            job.setId(rs.getInt("id"));
	            job.setTitle(rs.getString("title"));
	            job.setDescription(rs.getString("description"));
	            job.setLocation(rs.getString("location"));
	            jobs.add(job);
	        }
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return jobs;
	}
	
	
}

