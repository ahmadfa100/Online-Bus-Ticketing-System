<%-- 
    Document   : fareEstimation
    Created on : 14 Apr 2025, 3:54:05 PM
    Author     : Ahmad
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Models.FareConfig" %>
<%
    FareConfig fareConfig = FareConfig.getInstance();
    pageContext.setAttribute("fareConfig", fareConfig);
%>
<!DOCTYPE html>
<html>
<head>
  <title>Fare Estimation</title>
  <link rel="stylesheet" href="CSS/header.css" />
  <link rel="stylesheet" href="CSS/fareEstimation.css" />
  <link rel="stylesheet" href="CSS/footer.css" />
</head>
<body>
  <jsp:include page="Header.jsp" />

  <div class="estimation-container">
    <h2>Fare Estimation</h2>

    <c:if test="${empty sessionScope.currentUser}">
      <p>Please <a href="login.jsp">login</a> to estimate fares.</p>
    </c:if>

    <c:if test="${not empty sessionScope.currentUser}">
      <div class="trip-info">
        <p><strong>Trip:</strong> ${trip.origin} &rarr; ${trip.destination}</p>
        <p><strong>Departure:</strong> ${trip.departureTime}</p>
        <p><strong>Arrival:</strong> ${trip.arrivalTime}</p>
        <p><strong>Type:</strong> ${trip.travelType}</p>
      </div>

      <form action="${pageContext.request.contextPath}/TicketController" method="post">
        <input type="hidden" name="action" value="estimate" />
        <input type="hidden" name="tripId" value="${trip.tripId}" />
        <input type="hidden" name="travelType" value="${trip.travelType}" />

        <div class="form-group">
          <label for="ticketType">Ticket Type:</label>
          <select id="ticketType" name="ticketType">
            <option value="One-Trip">One-Trip</option>
            <option value="Daily Pass">Daily Pass</option>
            <option value="Weekly Pass">Weekly Pass</option>
            <option value="Monthly Pass">Monthly Pass</option>
          </select>
        </div>

        <button type="submit" class="btn btn-primary">Calculate Fare</button>
      </form>

      <c:if test="${not empty estimatedFare}">
        <div class="fare-result">
          <h3>Estimated Fare: ${estimatedFare}</h3>
        </div>

        <form action="${pageContext.request.contextPath}/PurchaseController"
              method="post" class="inline-form">
          <input type="hidden" name="tripId"     value="${trip.tripId}" />
          <input type="hidden" name="ticketType" value="${ticket.ticketType}" />
          <input type="hidden" name="travelType" value="${ticket.travelCategory}" />
          <input type="hidden" name="finalFare"   value="${estimatedFare}" />

          <button type="submit" class="btn btn-success">
            Purchase Ticket
          </button>
        </form>
      </c:if>
    </c:if>
  </div>

  <jsp:include page="Footer.jsp" />
</body>
</html>