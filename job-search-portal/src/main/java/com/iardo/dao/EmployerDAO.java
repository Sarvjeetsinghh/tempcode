package com.iardo.dao;

import com.iardo.model.Employer;
import com.iardo.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployerDAO {

    // Get employer by email
    public Employer getEmployerByEmail(String email) {
        Employer employer = null;

        String sql = "SELECT id, companyName, email, password, phone, industry, website, address, description "
                   + "FROM employers WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    employer = new Employer();

                    int id = rs.getInt("id");
                    System.out.println("🔍 Retrieved Employer ID from DB: " + id);

                    employer.setId(id);
                    employer.setCompanyName(rs.getString("companyName"));
                    employer.setEmail(rs.getString("email"));
                    employer.setPassword(rs.getString("password"));
                    employer.setPhone(rs.getString("phone"));
                    employer.setIndustry(rs.getString("industry"));
                    employer.setWebsite(rs.getString("website"));
                    employer.setAddress(rs.getString("address"));
                    employer.setDescription(rs.getString("description"));

                    System.out.println("✅ Employer object created:");
                    System.out.println("  ID: " + employer.getId());
                    System.out.println("  Company: " + employer.getCompanyName());
                } else {
                    System.out.println("❌ No employer found with email: " + email);
                }
            }

        } catch (Exception e) {
            System.err.println("❌ Exception in getEmployerByEmail:");
            e.printStackTrace();
        }

        return employer;
    }

    // Get employer by ID
    public Employer getEmployerById(int id) {
        Employer employer = null;

        String sql = "SELECT id, companyName, email, password, phone, industry, website, address, description "
                   + "FROM employers WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    employer = new Employer();
                    employer.setId(rs.getInt("id"));
                    employer.setCompanyName(rs.getString("companyName"));
                    employer.setEmail(rs.getString("email"));
                    employer.setPassword(rs.getString("password"));
                    employer.setPhone(rs.getString("phone"));
                    employer.setIndustry(rs.getString("industry"));
                    employer.setWebsite(rs.getString("website"));
                    employer.setAddress(rs.getString("address"));
                    employer.setDescription(rs.getString("description"));
                }
            }

        } catch (Exception e) {
            System.err.println("❌ Exception in getEmployerById:");
            e.printStackTrace();
        }

        return employer;
    }

    // Register employer
    public boolean registerEmployer(Employer employer) {
        String sql = "INSERT INTO employers (companyName, email, password, phone, industry, website, address, description) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, employer.getCompanyName());
            ps.setString(2, employer.getEmail());
            ps.setString(3, employer.getPassword());
            ps.setString(4, employer.getPhone());
            ps.setString(5, employer.getIndustry());
            ps.setString(6, employer.getWebsite());
            ps.setString(7, employer.getAddress());
            ps.setString(8, employer.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Update employer password
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE employers SET password = ? WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (Exception e) {
            System.err.println("❌ Exception in updatePassword:");
            e.printStackTrace();
        }

        return false;
    }

    // Update employer profile
    public boolean updateEmployerProfile(Employer employer) {
        String sql = "UPDATE employers SET companyName = ?, phone = ?, industry = ?, website = ?, "
                   + "address = ?, description = ? WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, employer.getCompanyName());
            ps.setString(2, employer.getPhone());
            ps.setString(3, employer.getIndustry());
            ps.setString(4, employer.getWebsite());
            ps.setString(5, employer.getAddress());
            ps.setString(6, employer.getDescription());
            ps.setString(7, employer.getEmail());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("❌ Exception in updateEmployerProfile:");
            e.printStackTrace();
        }

        return false;
    }

    // Check if email exists
    public boolean emailExists(String email) {
        String sql = "SELECT id FROM employers WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}