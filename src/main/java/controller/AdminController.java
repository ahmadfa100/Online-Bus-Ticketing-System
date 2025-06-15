/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.FareRuleDAO;
import DAO.TripDAO;
import Models.FareRule;
import Models.Trip;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author Ahmad
 */
@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {
    private TripDAO      tripDao;
    private FareRuleDAO  fareRuleDao;

    @Override
    public void init() throws ServletException {
        ServletContext ctx = getServletContext();
        tripDao     = new TripDAO(ctx);
        fareRuleDao = new FareRuleDAO(ctx);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String tab    = req.getParameter("tab");

        if ("editTrip".equals(action)) {
            int id = Integer.parseInt(req.getParameter("tripId"));
            req.setAttribute("editTrip", tripDao.getTripById(id));
        }

        req.setAttribute("tripList",  tripDao.getAllTrips());
        req.setAttribute("fareRules", fareRuleDao.getAllRules());
        req.setAttribute("activeTab", tab == null ? "trips" : tab);

        req.getRequestDispatcher("AdminDashboard.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "addTrip":
                handleAddTrip(req, resp);
                return;
            case "editTrip":
                handleEditTrip(req, resp);
                return;
            case "deleteTrip":
                handleDeleteTrip(req, resp);
                return;
            case "updateFareRules":
                handleUpdateFareRules(req);
                resp.sendRedirect(req.getContextPath() + "/AdminController?tab=fares");
                return;
            default:
        }

        resp.sendRedirect(req.getContextPath() + "/AdminController");
    }

    private void handleAddTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String origin      = request.getParameter("origin");
            String destination = request.getParameter("destination");
            LocalDateTime departure = LocalDateTime.parse(request.getParameter("departureTime"));
            LocalDateTime arrival   = LocalDateTime.parse(request.getParameter("arrivalTime"));
            String travelType = request.getParameter("travelType");
            int seats         = Integer.parseInt(request.getParameter("availableSeats"));

            if (seats < 1) {
                request.setAttribute("errorMessage", "Available seats must be at least 1.");
                reloadDashboard(request, response, null);
                return;
            }

            Trip newTrip = new Trip(0, origin, destination,
                                    departure, arrival,
                                    travelType, seats);

            boolean ok = tripDao.insertTrip(newTrip);
            if (!ok) log("Failed to insert trip: " + newTrip);
        } catch (Exception e) {
            log("Error in handleAddTrip", e);
        }
        response.sendRedirect(request.getContextPath() + "/AdminController");
    }

    private void handleEditTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("tripId"));
            Trip t = tripDao.getTripById(id);

            t.setOrigin(request.getParameter("origin"));
            t.setDestination(request.getParameter("destination"));
            t.setDepartureTime(LocalDateTime.parse(request.getParameter("departureTime")));
            t.setArrivalTime(LocalDateTime.parse(request.getParameter("arrivalTime")));
            t.setTravelType(request.getParameter("travelType"));

            int seats = Integer.parseInt(request.getParameter("availableSeats"));
            if (seats < 1) {
                request.setAttribute("errorMessage", "Available seats must be at least 1.");
                reloadDashboard(request, response, t);
                return;
            }
            t.setAvailableSeats(seats);

            boolean ok = tripDao.updateTrip(t);
            if (!ok) log("Failed to update trip " + id);
        } catch (Exception e) {
            log("Error in handleEditTrip", e);
        }
        response.sendRedirect(request.getContextPath() + "/AdminController");
    }

    private void handleDeleteTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("tripId"));
            boolean ok = tripDao.deleteTrip(id);
            if (!ok) log("Failed to delete trip " + id);
        } catch (Exception e) {
            log("Error in handleDeleteTrip", e);
        }
        response.sendRedirect(request.getContextPath() + "/AdminController");
    }

    private void handleUpdateFareRules(HttpServletRequest req) {
        List<FareRule> rules = fareRuleDao.getAllRules();
        for (FareRule r : rules) {
            int id = r.getRuleId();
            try {
                double base    = Double.parseDouble(req.getParameter("baseFare_"    + id));
                double studPct = Double.parseDouble(req.getParameter("studentDisc_" + id));
                double srPct   = Double.parseDouble(req.getParameter("seniorDisc_"  + id));
                double evePct  = Double.parseDouble(req.getParameter("eveningDisc_"+ id));

                r.setBaseFare(base);
                r.setStudentDiscount(studPct);
                r.setSeniorDiscount(srPct);
                r.setEveningDiscount(evePct);

                fareRuleDao.updateRule(r);
            } catch (NumberFormatException nfe) {
                log("Invalid number for fare rule " + id, nfe);
            }
        }
    }

  
    private void reloadDashboard(HttpServletRequest req, HttpServletResponse resp, Trip editTrip)
            throws ServletException, IOException {
        req.setAttribute("editTrip", editTrip);
        req.setAttribute("tripList",  tripDao.getAllTrips());
        req.setAttribute("fareRules", fareRuleDao.getAllRules());
        req.setAttribute("activeTab", "trips");
        req.getRequestDispatcher("AdminDashboard.jsp").forward(req, resp);
    }

    @Override
    public String getServletInfo() {
        return "AdminController for trip management";
    }
}
