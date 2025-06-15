/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Ahmad
 */
public class FareRule {
    private int ruleId;
    private String ticketType;        
    private String travelCategory;    
    private double baseFare;
    private double studentDiscount;   
    private double seniorDiscount;    
    private double eveningDiscount;   

    public FareRule() {}

    public FareRule(int ruleId, String ticketType, String travelCategory,
                    double baseFare, double studentDiscount,
                    double seniorDiscount, double eveningDiscount) {
        this.ruleId = ruleId;
        this.ticketType = ticketType;
        this.travelCategory = travelCategory;
        this.baseFare = baseFare;
        this.studentDiscount = studentDiscount;
        this.seniorDiscount = seniorDiscount;
        this.eveningDiscount = eveningDiscount;
    }

    public int getRuleId() { return ruleId; }
    public void setRuleId(int ruleId) { this.ruleId = ruleId; }
    public String getTicketType() { return ticketType; }
    public void setTicketType(String ticketType) { this.ticketType = ticketType; }
    public String getTravelCategory() { return travelCategory; }
    public void setTravelCategory(String travelCategory) { this.travelCategory = travelCategory; }
    public double getBaseFare() { return baseFare; }
    public void setBaseFare(double baseFare) { this.baseFare = baseFare; }
    public double getStudentDiscount() { return studentDiscount; }
    public void setStudentDiscount(double studentDiscount) { this.studentDiscount = studentDiscount; }
    public double getSeniorDiscount() { return seniorDiscount; }
    public void setSeniorDiscount(double seniorDiscount) { this.seniorDiscount = seniorDiscount; }
    public double getEveningDiscount() { return eveningDiscount; }
    public void setEveningDiscount(double eveningDiscount) { this.eveningDiscount = eveningDiscount; }
}

