/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Ahmad
 */

import jakarta.servlet.ServletContext;
import Models.TicketPurchase;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TicketPurchaseDAO {
    private DBConnectionManager dbManager;

    public TicketPurchaseDAO(ServletContext context) {
        dbManager = new DBConnectionManager(context);
    }

    public boolean recordPurchase(TicketPurchase p) {
        String sql = "INSERT INTO ticketpurchases (user_id, ticket_id, purchase_date, amount) VALUES (?,?,?,?)";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getUserId());
            ps.setInt(2, p.getTicketId());
            ps.setTimestamp(3, Timestamp.valueOf(p.getPurchaseDate()));
            ps.setDouble(4, p.getAmount());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<TicketPurchase> getPurchasesByUser(int userId) {
        List<TicketPurchase> list = new ArrayList<>();
        String sql = "SELECT * FROM ticketpurchases WHERE user_id = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TicketPurchase p = new TicketPurchase(
                    rs.getInt("user_id"),
                    rs.getInt("ticket_id"),
                    rs.getTimestamp("purchase_date").toLocalDateTime(),
                    rs.getDouble("amount")
                );
                p.setPurchaseId(rs.getInt("purchase_id"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<TicketPurchase> getAllPurchases() {
        List<TicketPurchase> list = new ArrayList<>();
        String sql = "SELECT * FROM ticketpurchases";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                TicketPurchase p = new TicketPurchase(
                    rs.getInt("user_id"),
                    rs.getInt("ticket_id"),
                    rs.getTimestamp("purchase_date").toLocalDateTime(),
                    rs.getDouble("amount")
                );
                p.setPurchaseId(rs.getInt("purchase_id"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
