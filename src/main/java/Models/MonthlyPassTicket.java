/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Ahmad
 */
public class MonthlyPassTicket extends Ticket {
    public MonthlyPassTicket(TravelType travelType, double baseFare, int userId, int tripId) {
        super(travelType, baseFare, userId, tripId);
    }
    @Override
    public String getTicketType() {
        return "Monthly Pass";
    }
}

