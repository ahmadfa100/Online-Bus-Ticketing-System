/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;
import java.time.LocalDateTime;
import java.time.LocalTime;


/**
 *
 * @author Ahmad
 */
public class TicketFactory {
    public static Ticket createTicket(
            String ticketType,
            String travelCategoryLabel,
            User user,
            LocalDateTime purchaseTime,
            int tripId) {

        TravelType travelType = "Inter-city".equalsIgnoreCase(travelCategoryLabel)
                                 ? new InterCityTravel()
                                 : new CityTravel();

        double baseFare = FareConfig
                .getInstance()
                .getBaseFare(ticketType, travelType.getLabel());

        Ticket ticket;
        switch (ticketType) {
            case "One-Trip":
                ticket = new OneTripTicket(travelType, baseFare, user.getUserId(), tripId);
                break;
            case "Daily Pass":
                ticket = new DailyPassTicket(travelType, baseFare, user.getUserId(), tripId);
                break;
            case "Weekly Pass":
                ticket = new WeeklyPassTicket(travelType, baseFare, user.getUserId(), tripId);
                break;
            case "Monthly Pass":
                ticket = new MonthlyPassTicket(travelType, baseFare, user.getUserId(), tripId);
                break;
            default:
                throw new IllegalArgumentException("Unknown ticket type: " + ticketType);
        }

        FareCalculator calc = new FareCalculator();
        calc.addStrategy(new RegularFareStrategy());
        if ("Student".equalsIgnoreCase(user.getStatus())) {
            calc.addStrategy(new StudentFareStrategy());
        } else if ("Senior".equalsIgnoreCase(user.getStatus())) {
            calc.addStrategy(new SeniorFareStrategy());
        }
        if ("One-Trip".equals(ticketType)
            && purchaseTime.toLocalTime().isAfter(LocalTime.of(19, 0))) {
            calc.addStrategy(new EveningFareStrategy());
        }

        double finalFare = calc.calculateFare(baseFare);
        ticket.setFinalFare(finalFare);

        ticket.setPurchaseDate(purchaseTime);

        return ticket;
    }
}
