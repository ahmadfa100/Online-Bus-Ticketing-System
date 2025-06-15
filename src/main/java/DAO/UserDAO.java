/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.User;
import jakarta.servlet.ServletContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ahmad
 */
public class UserDAO {
    private DBConnectionManager dbManager;

    public UserDAO(ServletContext context) {
        dbManager = new DBConnectionManager(context);
    }

    public User getUserByUsername(String username) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO Users (username, password, email, role, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET username=?, password=?, email=?, role=?, status=? WHERE user_id=?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getStatus());
            ps.setInt(6, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User getUserByEmail(String email) {
    User user = null;
    String sql = "SELECT * FROM Users WHERE email = ?";
    try (Connection conn = dbManager.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            user = new User();
            user.setUserId(rs.getInt("user_id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));
            user.setStatus(rs.getString("status"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return user;
}

    
    
}