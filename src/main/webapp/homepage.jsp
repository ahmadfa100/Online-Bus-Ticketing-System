<%-- 
    Document   : homepage
    Created on : 16 Apr 2025, 10:12:08 PM
    Author     : Ahmad
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.FareConfig" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    FareConfig fareConfig = FareConfig.getInstance();
    pageContext.setAttribute("fareConfig", fareConfig);
    
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SwiftTransit | Online Bus Ticketing</title>
  <link rel="icon" href="images/bus_logo.svg" type="image/svg+xml">
  <link rel="stylesheet" href="CSS/header.css">
  <link rel="stylesheet" href="CSS/homepage.css">
  <link rel="stylesheet" href="CSS/footer.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    /* Dynamic hero image */
    .hero-section {
      background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.3)), 
                  url('<%= contextPath %>/images/bus2.jpg') no-repeat center center;
      background-size: cover;
    }
    
    .hero-section.no-image {
      background: linear-gradient(to right, #2563eb, #1d4ed8);
    }
  </style>
</head>
<body>
  <jsp:include page="Header.jsp" />

  <div class="hero-section">
    <div class="hero-overlay">
      <div class="hero-content">
        <h1>Travel Smarter, Journey Better</h1>
        <p>Book bus tickets in seconds with our seamless platform</p>
        <a href="#trip-search" class="btn btn-primary">Book Your Journey</a>
      </div>
    </div>
  </div>

  <jsp:include page="tripSearch.jsp" />

  <section class="features-section">
    <div class="container">
      <div class="feature-card">
        <div class="feature-icon">🚌</div>
        <h3>Wide Network</h3>
        <p>Connect to hundreds of destinations nationwide</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">💰</div>
        <h3>Best Prices</h3>
        <p>Guaranteed lowest fares with no hidden charges</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🔒</div>
        <h3>Secure Booking</h3>
        <p>Your data is protected with bank-grade security</p>
      </div>
    </div>
  </section>

<section class="trips-section">
  <div class="container">
    <div class="section-header">
      <h2>Popular Routes</h2>
      <a href="#" class="view-all">View All Routes →</a>
    </div>
    
    <div class="trips-container">
      <c:choose>
        <c:when test="${not empty allTrips}">
          <c:forEach var="trip" items="${allTrips}">
            <div class="trip-card">
              <div class="trip-header">
                <span class="badge ${trip.travelType eq 'Premium' ? 'premium' : 'economy'}">
                  <i class="fas fa-${trip.travelType eq 'Premium' ? 'crown' : 'bus'}"></i> ${trip.travelType}
                </span>
                <div class="trip-timing">
                  <div class="time-group">
                    <span class="time-label">Departure</span>
                    <span class="departure">${trip.departureTime}</span>
                  </div>
                  <div class="duration">
                    <i class="fas fa-clock"></i> ${trip.departureTime} hrs
                  </div>
                  <div class="time-group">
                    <span class="time-label">Arrival</span>
                    <span class="arrival">${trip.arrivalTime}</span>
                  </div>
                </div>
              </div>
              
              <div class="trip-route">
                <div class="route-point">
                  <div class="point-marker start"></div>
                  <span class="city">${trip.origin}</span>
                </div>
                <div class="route-line">
                  <div class="animated-bus">
                    <i class="fas fa-bus"></i>
                  </div>
                </div>
                <div class="route-point">
                  <div class="point-marker end"></div>
                  <span class="city">${trip.destination}</span>
                </div>
              </div>
              
              <div class="trip-meta">
                <div class="meta-item ${trip.availableSeats < 10 ? 'low-seats' : ''}">
                  <i class="fas fa-chair"></i>
                  <span>${trip.availableSeats} Seats</span>
                </div>
                <div class="meta-item">
                  <i class="fas fa-tag"></i>
                  <span>From RM${fareConfig.getBaseFare('One-Trip', trip.travelType)}</span>
                </div>
              </div>
              
              <div class="trip-actions">
                <a href="${pageContext.request.contextPath}/FareEstimationController?tripId=${trip.tripId}"
                   class="btn btn-outline">
                  <i class="fas fa-info-circle"></i> Details
                </a>
                <form action="${pageContext.request.contextPath}/PurchaseController" method="post">
                  <input type="hidden" name="tripId" value="${trip.tripId}"/>
                  <input type="hidden" name="ticketType" value="One-Trip"/>
                  <input type="hidden" name="travelType" value="${trip.travelType}"/>
                  <input type="hidden" name="finalFare"
                         value="${fareConfig.getBaseFare('One-Trip', trip.travelType)}"/>
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-ticket-alt"></i> Book Now
                  </button>
                </form>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="no-trips">
            <img src="images/no-trips.svg" alt="No trips available">
            <h3>No trips available at the moment</h3>
            <p>Check back later or try different search parameters</p>
            <a href="#" class="btn btn-outline">Refresh Routes</a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</section>

  <jsp:include page="Footer.jsp" />
  
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const cards = document.querySelectorAll('.trip-card');
      cards.forEach((card, index) => {
        setTimeout(() => {
          card.style.opacity = '1';
          card.style.transform = 'translateY(0)';
        }, 150 * index);
      });
    });
  </script>
</body>
</html>