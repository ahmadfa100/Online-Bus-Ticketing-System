<%-- 
    Document   : Tickets
    Created on : 24 Apr 2025, 7:12:41 AM
    Author     : Ahmad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>All Trips</title>
  <link rel="stylesheet" href="CSS/Trips.css">
</head>
<body>
<jsp:include page="Header.jsp" />

<div class="trips-container">
  <c:choose>
    <c:when test="${not empty tripList}">
      <c:forEach var="trip" items="${tripList}">
        <div class="trip-card">
          <div class="trip-info">
            <div class="route">
              <span class="label">From:</span> <span class="value">${trip.origin}</span>
              <span class="arrow">→</span>
              <span class="label">To:</span> <span class="value">${trip.destination}</span>
            </div>
            <div class="times">
              <div><span class="label">Departure:</span> <span class="value">${trip.departureTime}</span></div>
              <div><span class="label">Arrival:</span> <span class="value">${trip.arrivalTime}</span></div>
            </div>
          </div>
          <div class="trip-actions">
            <form action="EstimateFareController" method="get">
              <input type="hidden" name="tripId" value="${trip.tripId}" />
              <button type="submit" class="btn estimate">Estimate Fare</button>
            </form>
            <form action="PurchaseController" method="post">
              <input type="hidden" name="tripId" value="${trip.tripId}" />
              <input type="hidden" name="ticketType" value="One-Trip" />
              <button type="submit" class="btn buy">Buy One-Trip</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <div class="no-trips">No trips available. Please check back later.</div>
    </c:otherwise>
  </c:choose>
</div>

<jsp:include page="Footer.jsp" />

<style>

</style>
</html>
