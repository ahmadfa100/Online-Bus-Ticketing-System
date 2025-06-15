/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import jakarta.servlet.ServletContext;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Ahmad
 */
public class FareConfig {

    private static FareConfig instance;

    private final Map<String, Double> baseFares     = new HashMap<>();
    private final Map<String, Double> discountRates = new HashMap<>();

    private FareConfig() { }

   
    public static synchronized FareConfig getInstance() {
        if (instance == null) {
            instance = new FareConfig();
        }
        return instance;
    }

  
    public void loadFromContext(ServletContext ctx) {
        String[] fareKeys = {
            "OneTrip.City",      "OneTrip.InterCity",
            "DailyPass.City",    "DailyPass.InterCity",
            "WeeklyPass.City",   "WeeklyPass.InterCity",
            "MonthlyPass.City",  "MonthlyPass.InterCity"
        };

        for (String fk : fareKeys) {
            String raw = ctx.getInitParameter("fare." + fk);
            if (raw == null) continue;

            String[] parts = fk.split("\\.");
            String typeKey = parts[0];
            String catKey  = parts[1];

            String ticketType;
            switch (typeKey) {
                case "OneTrip":     ticketType = "One-Trip";    break;
                case "DailyPass":   ticketType = "Daily Pass";  break;
                case "WeeklyPass":  ticketType = "Weekly Pass"; break;
                case "MonthlyPass": ticketType = "Monthly Pass";break;
                default:            ticketType = typeKey;       break;
            }

            String travelCategory = "InterCity".equals(catKey)
                                  ? "Inter-city"
                                  : "City";

            String mapKey = ticketType + "|" + travelCategory;
            baseFares.put(mapKey, Double.parseDouble(raw));
        }

        String[] discKeys = { "student", "senior", "evening" };
        for (String dk : discKeys) {
            String raw = ctx.getInitParameter("discount." + dk);
            if (raw == null) continue;
            String label = dk.substring(0,1).toUpperCase() + dk.substring(1);
            discountRates.put(label, Double.parseDouble(raw));
        }
    }

    public double getBaseFare(String ticketType, String travelCategory) {
        String key = ticketType + "|" + travelCategory;
        return baseFares.getOrDefault(key, 0.0);
    }

    public double getDiscountRate(String userCategory) {
        return discountRates.getOrDefault(userCategory, 0.0);
    }
}
