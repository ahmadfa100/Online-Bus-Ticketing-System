<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Available Trips</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary: #4361ee;
      --primary-light: #eef1ff;
      --success: #28a745;
      --warning: #ffc107;
      --danger: #dc3545;
      --dark: #343a40;
      --light: #f8f9fa;
      --border: #dee2e6;
      --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }
    
    body {
      background-color: #f5f7fa;
      font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
      color: #333;
      line-height: 1.6;
      margin: 0;
      padding: 0;
    }
    
    .trips-container {
      max-width: 1400px;
      margin: 2rem auto;
      padding: 0 1.5rem;
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
      gap: 1.5rem;
    }
    
    .trip-card {
      background: #ffffff;
      border-radius: 12px;
      box-shadow: var(--card-shadow);
      overflow: hidden;
      display: flex;
      flex-direction: column;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .trip-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0,0,0,0.12);
    }
    
    .card-header {
      background: var(--primary);
      color: white;
      padding: 1.25rem;
      position: relative;
    }
    
    .travel-type {
      position: absolute;
      top: 1rem;
      right: 1rem;
      background: rgba(255, 255, 255, 0.2);
      padding: 0.25rem 0.75rem;
      border-radius: 50px;
      font-size: 0.8rem;
      font-weight: 500;
    }
    
    .route {
      display: flex;
      align-items: center;
      margin-bottom: 0.5rem;
      font-size: 1.2rem;
      font-weight: 600;
    }
    
    .route .arrow {
      margin: 0 0.75rem;
      font-size: 1.5rem;
    }
    
    .trip-info {
      padding: 1.5rem;
      flex-grow: 1;
    }
    
    .info-row {
      display: flex;
      justify-content: space-between;
      padding: 0.75rem 0;
      border-bottom: 1px solid var(--border);
    }
    
    .info-row:last-child {
      border-bottom: none;
    }
    
    .info-label {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      color: #6c757d;
      font-weight: 500;
    }
    
    .info-value {
      font-weight: 600;
      color: var(--dark);
      text-align: right;
    }
    
    .duration {
      color: var(--primary);
      font-weight: 600;
    }
    
    .trip-actions {
      display: flex;
      gap: 0.75rem;
      padding: 1rem 1.5rem;
      background: var(--light);
      border-top: 1px solid var(--border);
    }
    
    .btn {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      padding: 0.8rem;
      font-weight: 500;
      border-radius: 8px;
      cursor: pointer;
      transition: all 0.2s ease;
      border: none;
      text-decoration: none;
      text-align: center;
    }
    
    .btn.estimate {
      background: var(--warning);
      color: var(--dark);
    }
    
    .btn.estimate:hover {
      background: #e0a800;
      transform: translateY(-2px);
    }
    
    .btn.buy {
      background: var(--success);
      color: white;
    }
    
    .btn.buy:hover {
      background: #218838;
      transform: translateY(-2px);
    }
    
    .no-trips {
      grid-column: 1 / -1;
      text-align: center;
      padding: 3rem;
      background: white;
      border-radius: 12px;
      box-shadow: var(--card-shadow);
    }
    
    .no-trips i {
      font-size: 3rem;
      color: #6c757d;
      margin-bottom: 1rem;
    }
    
    .no-trips h3 {
      color: var(--dark);
      margin-bottom: 0.5rem;
    }
    
    .no-trips p {
      color: #6c757d;
      max-width: 500px;
      margin: 0 auto;
    }
    
    @media (max-width: 768px) {
      .trips-container {
        grid-template-columns: 1fr;
      }
      
      .trip-actions {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
<jsp:include page="Header.jsp" />

<div class="trips-container">
  <c:choose>
    <c:when test="${not empty tripList}">
      <c:forEach var="trip" items="${tripList}">
        <div class="trip-card">
          <div class="card-header">
            <div class="travel-type">${trip.travelType}</div>
            <div class="route">
              <span>${trip.origin}</span>
              <span class="arrow"><i class="fas fa-arrow-right"></i></span>
              <span>${trip.destination}</span>
            </div>
          </div>
          
          <div class="trip-info">
            <div class="info-row">
              <div class="info-label">
                <i class="fas fa-clock"></i>
                <span>Departure</span>
              </div>
              <div class="info-value">${trip.departureTime}</div>
            </div>
            
            <div class="info-row">
              <div class="info-label">
                <i class="fas fa-flag-checkered"></i>
                <span>Arrival</span>
              </div>
              <div class="info-value">${trip.arrivalTime}</div>
            </div>
            
            <div class="info-row">
              <div class="info-label">
                <i class="fas fa-hourglass-half"></i>
                <span>Duration</span>
              </div>
              <div class="info-value duration">2h 30m</div>
            </div>
            
            <div class="info-row">
              <div class="info-label">
                <i class="fas fa-chair"></i>
                <span>Available Seats</span>
              </div>
              <div class="info-value">${trip.availableSeats}</div>
            </div>
          </div>
          
          <div class="trip-actions">
            <form action="EstimateFareController" method="get" style="flex:1">
              <input type="hidden" name="tripId" value="${trip.tripId}" />
              <button type="submit" class="btn estimate">
                <i class="fas fa-calculator"></i> Estimate Fare
              </button>
            </form>
            
            <form action="PurchaseController" method="post" style="flex:1">
              <input type="hidden" name="tripId" value="${trip.tripId}" />
              <input type="hidden" name="ticketType" value="One-Trip" />
              <button type="submit" class="btn buy">
                <i class="fas fa-ticket-alt"></i> Buy Ticket
              </button>
            </form>
          </div>
        </div>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <div class="no-trips">
        <i class="fas fa-bus-slash"></i>
        <h3>No Trips Available</h3>
        <p>We don't have any scheduled trips at the moment. Please check back later for updates on our bus schedules.</p>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<jsp:include page="Footer.jsp" />
</body>
</html>