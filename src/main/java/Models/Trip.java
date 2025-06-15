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
public class Trip {
    private int tripId;
    private String origin;
    private String destination;
    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;
    private String travelType;    
    private int availableSeats;

    public Trip() {}

    public Trip(int tripId, String origin, String destination,
                LocalDateTime departureTime, LocalDateTime arrivalTime,
                String travelType, int availableSeats) {
        this.tripId = tripId;
        this.origin = origin;
        this.destination = destination;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.travelType = travelType;
        this.availableSeats = availableSeats;
    }

    public int getTripId() { return tripId; }
    public void setTripId(int tripId) { this.tripId = tripId; }
    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }
    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }
    public LocalDateTime getDepartureTime() { return departureTime; }
    public void setDepartureTime(LocalDateTime departureTime) { this.departureTime = departureTime; }
    public LocalDateTime getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(LocalDateTime arrivalTime) { this.arrivalTime = arrivalTime; }
    public String getTravelType() { return travelType; }
    public void setTravelType(String travelType) { this.travelType = travelType; }
    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
}

