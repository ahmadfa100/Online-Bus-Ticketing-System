/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.time.LocalDateTime;

/**
 *
 * @author Ahmad
 */


public abstract class Ticket {
    private int ticketId;
    private TravelType travelType;
    private double baseFare;
    private double finalFare;
    private LocalDateTime purchaseDate;
    private int userId;
    private int tripId;

    protected Ticket(TravelType travelType, double baseFare, int userId, int tripId) {
        this.travelType = travelType;
        this.baseFare   = baseFare;
        this.userId     = userId;
        this.tripId     = tripId;
    }

    public abstract String getTicketType();

    public TravelType getTravelType() {
        return travelType;
    }

    public String getTravelCategory() {
        return travelType.getLabel();
    }

    public double getBaseFare() {
        return baseFare;
    }
    public double getFinalFare() {
        return finalFare;
    }
    public void setFinalFare(double f) {
        this.finalFare = f;
    }

    public int getUserId() {
        return userId;
    }
    public int getTripId() {
        return tripId;
    }

    public int getTicketId() {
        return ticketId;
    }
    public void setTicketId(int id) {
        this.ticketId = id;
    }

    public LocalDateTime getPurchaseDate() {
        return purchaseDate;
    }
    public void setPurchaseDate(LocalDateTime purchaseDate) {
        this.purchaseDate = purchaseDate;
    }
}