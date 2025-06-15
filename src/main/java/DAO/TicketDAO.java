package DAO;

import Models.CityTravel;
import Models.DailyPassTicket;
import Models.InterCityTravel;
import Models.MonthlyPassTicket;
import Models.OneTripTicket;
import Models.Ticket;
import Models.TravelType;
import Models.WeeklyPassTicket;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletContext;

public class TicketDAO {
    private final DBConnectionManager dbManager;

    public TicketDAO(ServletContext context) {
        this.dbManager = new DBConnectionManager(context);
    }

   
    public int createTicket(Ticket ticket) {
        String sql = 
            "INSERT INTO tickets " +
            "(ticket_type, travel_category, base_fare, final_fare, " +
            " purchase_date, user_id, trip_id) " +
            "VALUES (?,?,?,?,?,?,?)";

        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
             
            ps.setString(1, ticket.getTicketType());
            ps.setString(2, ticket.getTravelCategory());
            ps.setDouble(3, ticket.getBaseFare());
            ps.setDouble(4, ticket.getFinalFare());
            ps.setTimestamp(5, Timestamp.valueOf(ticket.getPurchaseDate()));
            ps.setInt(6, ticket.getUserId());
            ps.setInt(7, ticket.getTripId());
            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

  
    public Ticket getTicketById(int ticketId) {
        String sql = "SELECT * FROM tickets WHERE ticket_id = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, ticketId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToTicket(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    
    public List<Ticket> getTicketsByUser(int userId) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM tickets WHERE user_id = ?";
        try (Connection conn = dbManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToTicket(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    
    private Ticket mapRowToTicket(ResultSet rs) throws SQLException {
        String type           = rs.getString("ticket_type");
        String travelCategory = rs.getString("travel_category");
        double baseFare       = rs.getDouble("base_fare");
        int    userId         = rs.getInt("user_id");
        int    tripId         = rs.getInt("trip_id");
        int    id             = rs.getInt("ticket_id");
        double finalFare      = rs.getDouble("final_fare");
        LocalDateTime purchaseDate = rs.getTimestamp("purchase_date").toLocalDateTime();

        TravelType travelType = "Inter-city".equalsIgnoreCase(travelCategory)
                                 ? new InterCityTravel()
                                 : new CityTravel();

        Ticket ticket;
        switch (type) {
            case "One-Trip":
                ticket = new OneTripTicket(travelType, baseFare, userId, tripId);
                break;
            case "Daily Pass":
                ticket = new DailyPassTicket(travelType, baseFare, userId, tripId);
                break;
            case "Weekly Pass":
                ticket = new WeeklyPassTicket(travelType, baseFare, userId, tripId);
                break;
            case "Monthly Pass":
                ticket = new MonthlyPassTicket(travelType, baseFare, userId, tripId);
                break;
            default:
                throw new IllegalArgumentException("Unknown ticket type: " + type);
        }

        ticket.setTicketId(id);
        ticket.setFinalFare(finalFare);
        ticket.setPurchaseDate(purchaseDate);

        return ticket;
    }
}
