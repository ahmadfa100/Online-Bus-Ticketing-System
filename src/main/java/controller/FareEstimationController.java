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

/**
 *
 * @author Ahmad
 */
@WebServlet(name = "FareEstimationController", urlPatterns = {"/FareEstimationController"})
public class FareEstimationController extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FareEstimationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FareEstimationController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
              String idStr = request.getParameter("tripId");
        if (idStr != null) {
            int tripId = Integer.parseInt(idStr);
            Trip trip = new TripDAO(getServletContext()).getTripById(tripId);
            request.setAttribute("trip", trip);
        }
        request.getRequestDispatcher("/fareEstimation.jsp")
           .forward(request, response);
    
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
