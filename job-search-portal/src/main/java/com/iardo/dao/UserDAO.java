package com.iardo.dao;


import java.sql.*;

import com.iardo.model.User;
import com.iardo.util.DBConnection;

public class UserDAO {
    private Connection con;

    public UserDAO() {
        con = DBConnection.getConnection();
    }

    public boolean register(User user) {
        String query = "INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User login(String email, String password) {
        String query = "SELECT * FROM users WHERE email=? AND password=?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
