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
public class TicketPurchase {
    private int purchaseId;
    private int userId;
    private int ticketId;
    private LocalDateTime purchaseDate;
    private double amount;

    public TicketPurchase() {}

    public TicketPurchase(int userId, int ticketId, LocalDateTime purchaseDate, double amount) {
        this.userId = userId;
        this.ticketId = ticketId;
        this.purchaseDate = purchaseDate;
        this.amount = amount;
    }

    public int getPurchaseId() { return purchaseId; }
    public void setPurchaseId(int purchaseId) { this.purchaseId = purchaseId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getTicketId() { return ticketId; }
    public void setTicketId(int ticketId) { this.ticketId = ticketId; }
    public LocalDateTime getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(LocalDateTime purchaseDate) { this.purchaseDate = purchaseDate; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
}

