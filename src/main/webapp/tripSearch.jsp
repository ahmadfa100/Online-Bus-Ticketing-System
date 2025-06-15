<%-- 
    Document   : tripSearch
    Created on : 16 Apr 2025, 2:33:00 PM
    Author     : Ahmad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Models.FareConfig" %>

<%
    FareConfig fareConfig = FareConfig.getInstance();
    pageContext.setAttribute("fareConfig", fareConfig);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search & View Trips | TransitHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/CSS/tripSearch.css">

</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Find Your Perfect Journey</h1>
            <p>Search, compare, and book trips with our easy-to-use platform</p>
        </div>
        
        <div class="search-card">
            <h2><i class="fas fa-search"></i> Search Trips</h2>
            <form class="search-form" action="TripController" method="GET">
                <input type="hidden" name="action" value="search">
                
                <div class="input-group">
                    <label for="fromLocation"><i class="fas fa-map-marker-alt"></i> From</label>
                    <input type="text" id="fromLocation" name="fromLocation" placeholder="Departure location" required>
                </div>
                
                <div class="input-group">
                    <label for="toLocation"><i class="fas fa-map-marker-alt"></i> To</label>
                    <input type="text" id="toLocation" name="toLocation" placeholder="Destination" required>
                </div>
                
                <div class="input-group">
                    <label for="travelDate"><i class="far fa-calendar-alt"></i> Date</label>
                    <input type="date" id="travelDate" name="travelDate" required>
                </div>
                
                <div class="input-group">
                    <label for="travelType"><i class="fas fa-route"></i> Trip Type</label>
                    <select id="travelType" name="travelType" required>
                        <option value="City">City Trip</option>
                        <option value="Inter-city">Inter-city Trip</option>
                    </select>
                </div>
                
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i> Search Trips
                </button>
            </form>
        </div>
        
        <c:if test="${not empty tripList}">
            <div class="results-section">
                <h2 class="section-title"><i class="fas fa-bus"></i> Available Trips</h2>
                
                <div class="trips-container">
                    <c:forEach var="trip" items="${tripList}">
                        <div class="trip-card">
                            <div class="trip-header">
                                <div class="trip-id">ID: ${trip.tripId}</div>
                                <div class="trip-type">${trip.travelType}</div>
                            </div>
                            
                            <div class="trip-info">
                                <div class="route-info">
                                    <div>
                                        <div class="route-label"><i class="fas fa-flag"></i> Departure</div>
                                        <div class="route-value">${trip.origin}</div>
                                    </div>
                                    <div class="route-arrow">
                                        <i class="fas fa-long-arrow-alt-right fa-2x" style="color: #cbd5e1;"></i>
                                    </div>
                                </div>
                                
                                <div class="route-info">
                                    <div>
                                        <div class="route-label"><i class="fas fa-map-pin"></i> Destination</div>
                                        <div class="route-value">${trip.destination}</div>
                                    </div>
                                </div>
                                
                                <div class="time-info">
                                    <div class="time-group">
                                        <div class="time-label">Departure</div>
                                        <div class="time-value">${trip.departureTime}</div>
                                    </div>
                                    
                                    <div class="time-group">
                                        <div class="time-label">Arrival</div>
                                        <div class="time-value">${trip.arrivalTime}</div>
                                    </div>
                                </div>
                                
                                <div class="duration">
                                    <i class="far fa-clock"></i> Trip Duration: Approx. 2h 15m
                                </div>
                            </div>
                            
                            <div class="trip-actions">
                                <form action="${pageContext.request.contextPath}/FareEstimationController" method="get">
                                    <input type="hidden" name="tripId" value="${trip.tripId}" />
                                    <button type="submit" class="btn estimate">
                                        <i class="fas fa-calculator"></i> Estimate Fare
                                    </button>
                                </form>
                                
                                <form action="${pageContext.request.contextPath}/PurchaseController" method="post">
                                    <input type="hidden" name="tripId" value="${trip.tripId}"/>
                                    <input type="hidden" name="ticketType" value="One-Trip"/>
                                    <input type="hidden" name="travelType" value="${trip.travelType}"/>
                                    <input type="hidden" name="finalFare" value="${fareConfig.getBaseFare('One-Trip', trip.travelType)}"/>
                                    <button type="submit" class="btn buy">
                                        <i class="fas fa-ticket-alt"></i> Buy Ticket
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty tripList && param.action == 'search'}">
            <div class="no-results">
                <i class="fas fa-search-location"></i>
                <h3>No Trips Found</h3>
                <p>We couldn't find any trips matching your search criteria. Please try different locations or dates.</p>
            </div>
        </c:if>
        
        <c:if test="${empty sessionScope.currentUser}">
            <div class="login-prompt">
                <p><i class="fas fa-exclamation-circle"></i> You need to be logged in to purchase tickets</p>
                <a href="login.jsp" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login to Your Account
                </a>
            </div>
        </c:if>
    </div>
</body>
</html>