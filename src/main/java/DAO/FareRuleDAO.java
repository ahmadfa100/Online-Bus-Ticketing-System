/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.FareRule;
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

public class FareRuleDAO {
    private DBConnectionManager dbManager;

    public FareRuleDAO(ServletContext context) {
        dbManager = new DBConnectionManager(context);
    }

    public List<FareRule> getAllRules() {
        List<FareRule> list = new ArrayList<>();
        String sql = "SELECT * FROM farerules";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                FareRule r = new FareRule(
                    rs.getInt("rule_id"),
                    rs.getString("ticket_type"),
                    rs.getString("travel_category"),
                    rs.getDouble("base_fare"),
                    rs.getDouble("student_discount"),
                    rs.getDouble("senior_discount"),
                    rs.getDouble("evening_discount")
                );
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public FareRule getRuleById(int id) {
        FareRule rule = null;
        String sql = "SELECT * FROM farerules WHERE rule_id = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rule = new FareRule(
                    rs.getInt("rule_id"),
                    rs.getString("ticket_type"),
                    rs.getString("travel_category"),
                    rs.getDouble("base_fare"),
                    rs.getDouble("student_discount"),
                    rs.getDouble("senior_discount"),
                    rs.getDouble("evening_discount")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rule;
    }

    public boolean insertRule(FareRule r) {
        String sql = "INSERT INTO farerules (ticket_type, travel_category, base_fare, student_discount, senior_discount, evening_discount) VALUES (?,?,?,?,?,?)";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getTicketType());
            ps.setString(2, r.getTravelCategory());
            ps.setDouble(3, r.getBaseFare());
            ps.setDouble(4, r.getStudentDiscount());
            ps.setDouble(5, r.getSeniorDiscount());
            ps.setDouble(6, r.getEveningDiscount());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRule(FareRule r) {
        String sql = "UPDATE farerules SET ticket_type=?, travel_category=?, base_fare=?, student_discount=?, senior_discount=?, evening_discount=? WHERE rule_id=?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getTicketType());
            ps.setString(2, r.getTravelCategory());
            ps.setDouble(3, r.getBaseFare());
            ps.setDouble(4, r.getStudentDiscount());
            ps.setDouble(5, r.getSeniorDiscount());
            ps.setDouble(6, r.getEveningDiscount());
            ps.setInt(7, r.getRuleId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRule(int id) {
        String sql = "DELETE FROM farerules WHERE rule_id = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

