/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Ahmad
 */

import Models.Trip;
import jakarta.servlet.ServletContext;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TripDAO {
    private DBConnectionManager dbManager;

    public TripDAO(ServletContext context) {
        dbManager = new DBConnectionManager(context);
    }

    public List<Trip> searchTrips(String origin, String destination, LocalDate departureDate, String travelType) {
        List<Trip> list = new ArrayList<>();
        String sql = "SELECT * FROM trips WHERE origin=? AND destination=? AND DATE(departure_time)=? AND travel_type=?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, origin);
            ps.setString(2, destination);
            ps.setDate(3, Date.valueOf(departureDate));
            ps.setString(4, travelType);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Trip t = new Trip(
                    rs.getInt("trip_id"),
                    rs.getString("origin"),
                    rs.getString("destination"),
                    rs.getTimestamp("departure_time").toLocalDateTime(),
                    rs.getTimestamp("arrival_time").toLocalDateTime(),
                    rs.getString("travel_type"),
                    rs.getInt("available_seats")
                );
                list.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Trip getTripById(int tripId) {
        Trip t = null;
        String sql = "SELECT * FROM trips WHERE trip_id = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tripId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                t = new Trip(
                    rs.getInt("trip_id"),
                    rs.getString("origin"),
                    rs.getString("destination"),
                    rs.getTimestamp("departure_time").toLocalDateTime(),
                    rs.getTimestamp("arrival_time").toLocalDateTime(),
                    rs.getString("travel_type"),
                    rs.getInt("available_seats")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return t;
    }

    public boolean insertTrip(Trip trip) {
        String sql = "INSERT INTO trips (origin,destination,departure_time,arrival_time,travel_type,available_seats) VALUES (?,?,?,?,?,?)";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trip.getOrigin());
            ps.setString(2, trip.getDestination());
            ps.setTimestamp(3, Timestamp.valueOf(trip.getDepartureTime()));
            ps.setTimestamp(4, Timestamp.valueOf(trip.getArrivalTime()));
            ps.setString(5, trip.getTravelType());
            ps.setInt(6, trip.getAvailableSeats());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSeats(int tripId, int newCount) {
        String sql = "UPDATE trips SET available_seats = ? WHERE trip_id = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newCount);
            ps.setInt(2, tripId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTrip(Trip trip) {
        String sql = "UPDATE trips SET origin=?, destination=?, departure_time=?, arrival_time=?, travel_type=?, available_seats=? WHERE trip_id=?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trip.getOrigin());
            ps.setString(2, trip.getDestination());
            ps.setTimestamp(3, Timestamp.valueOf(trip.getDepartureTime()));
            ps.setTimestamp(4, Timestamp.valueOf(trip.getArrivalTime()));
            ps.setString(5, trip.getTravelType());
            ps.setInt(6, trip.getAvailableSeats());
            ps.setInt(7, trip.getTripId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

public boolean deleteTrip(int tripId) {
    Connection conn = null;
    try {
      conn = dbManager.getConnection();
      conn.setAutoCommit(false);

      try (PreparedStatement p1 = conn.prepareStatement(
            "DELETE FROM tickets WHERE trip_id = ?")) {
        p1.setInt(1, tripId);
        p1.executeUpdate();
      }

      int rows = 0;
      try (PreparedStatement p2 = conn.prepareStatement(
            "DELETE FROM trips WHERE trip_id = ?")) {
        p2.setInt(1, tripId);
        rows = p2.executeUpdate();
      }

      conn.commit();
      return rows > 0;
    } catch (SQLException e) {
      if (conn != null) try { conn.rollback(); } catch (SQLException ex) { }
      e.printStackTrace();
      return false;
    } finally {
      if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ex) { }
    }
}

    
public List<Trip> getAllTrips() {
    List<Trip> list = new ArrayList<>();
    String sql = "SELECT * FROM trips";
    try (Connection conn = dbManager.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(new Trip(
                rs.getInt("trip_id"),
                rs.getString("origin"),
                rs.getString("destination"),
                rs.getTimestamp("departure_time").toLocalDateTime(),
                rs.getTimestamp("arrival_time").toLocalDateTime(),
                rs.getString("travel_type"),
                rs.getInt("available_seats")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}


    
}

