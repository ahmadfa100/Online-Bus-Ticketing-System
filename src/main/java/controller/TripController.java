/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.TripDAO;
import Models.Trip;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author Ahmad
 */
@WebServlet(name = "TripController", urlPatterns = {"/TripController"})
public class TripController extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    TripDAO dao = new TripDAO(getServletContext());

    if ("search".equalsIgnoreCase(action)) {
        handleSearch(request, response);
    } else {
        List<Trip> allTrips = dao.getAllTrips();
        request.setAttribute("allTrips", allTrips);
        request.getRequestDispatcher("homepage.jsp")
               .forward(request, response);
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String origin      = request.getParameter("fromLocation");
        String destination = request.getParameter("toLocation");
        LocalDate date     = LocalDate.parse(request.getParameter("travelDate"));
        String travelType  = request.getParameter("travelType");

        TripDAO dao = new TripDAO(getServletContext());
        List<Trip> trips = dao.searchTrips(origin, destination, date, travelType);

        request.setAttribute("tripList", trips);
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }
}