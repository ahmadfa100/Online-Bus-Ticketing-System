<%-- 
    Document   : ticketHistory
    Created on : 14 Apr 2025, 3:54:17 PM
    Author     : Ahmad
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Ticket Orders | SwiftTransit</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css" />
  <link rel="stylesheet" href="CSS/ticketHistory.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
  <jsp:include page="Header.jsp" />

  <div class="history-container">
    <div class="page-header">
      <h2>Your Ticket Orders</h2>
      <p>View your purchase history and ticket details</p>
    </div>

    <c:choose>
      <c:when test="${empty tickets}">
        <div class="empty-state">
          <i class="fas fa-ticket-alt"></i>
          <h3>No Tickets Yet</h3>
          <p>You haven't purchased any tickets yet. Start your journey by booking your first trip!</p>
          <a href="homepage.jsp" class="btn-primary">Find Your Trip</a>
        </div>
      </c:when>
      
      <c:otherwise>
        <div class="cards-container">
          <c:forEach var="t" items="${tickets}" varStatus="loop">
            <div class="ticket-card" style="--i: ${loop.index};">
              <div class="card-header">
                <h3>Ticket #<span class="ticket-id">${t.ticketId}</span></h3>
                <i class="fas fa-ticket-alt ticket-icon"></i>
              </div>
              
              <div class="card-body">
                <div class="ticket-detail">
                  <span class="detail-label">Trip ID</span>
                  <span class="detail-value">${t.tripId}</span>
                </div>
                
                <div class="ticket-detail">
                  <span class="detail-label">Ticket Type</span>
                  <span class="detail-value">
                    <span class="ticket-type 
                      <c:choose>
                        <c:when test="${t.ticketType eq 'Monthly-Pass'}">monthly-pass</c:when>
                        <c:when test="${t.ticketType eq 'Student-Pass'}">student-pass</c:when>
                        <c:otherwise>one-trip</c:otherwise>
                      </c:choose>
                    ">
                      ${t.ticketType}
                    </span>
                  </span>
                </div>
                
                <div class="ticket-detail">
                  <span class="detail-label">Category</span>
                  <span class="detail-value">
                    <span class="ticket-category 
                      <c:if test="${t.travelCategory eq 'Premium'}">premium</c:if>
                      <c:if test="${t.travelCategory eq 'Economy'}">economy</c:if>
                    ">
                      ${t.travelCategory}
                    </span>
                  </span>
                </div>
                
                <div class="ticket-detail">
                  <span class="detail-label">Base Fare</span>
                  <span class="detail-value price base-fare">$${t.baseFare}</span>
                </div>
                
                <div class="ticket-detail">
                  <span class="detail-label">Final Fare</span>
                  <span class="detail-value price final-fare">$${t.finalFare}</span>
                </div>
                
                <div class="ticket-detail">
                  <span class="detail-label">Purchased On</span>
                  <span class="detail-value purchase-date">${t.purchaseDate}</span>
                </div>
              </div>
              
              <div class="card-footer">
                <button class="action-btn">
                  <i class="fas fa-print"></i> Print Ticket
                </button>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <jsp:include page="Footer.jsp" />
  
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Add animation to empty state button
      const findTripBtn = document.querySelector('.btn-primary');
      if (findTripBtn) {
        findTripBtn.addEventListener('mouseover', function() {
          this.style.animation = 'pulse 1.5s infinite';
        });
        
        findTripBtn.addEventListener('mouseout', function() {
          this.style.animation = 'none';
        });
      }
      
      const printButtons = document.querySelectorAll('.action-btn');
      printButtons.forEach(button => {
        button.addEventListener('click', function() {
          const card = this.closest('.ticket-card');
          
          // Enhanced print animation
          card.animate([
            { transform: 'scale(1)' },
            { transform: 'scale(1.05)', offset: 0.3 },
            { transform: 'scale(1.03)', offset: 0.8 },
            { transform: 'scale(1.02)' }
          ], {
            duration: 600,
            easing: 'ease-in-out'
          });
          
          setTimeout(() => {
            alert('Print functionality would open here');
          }, 300);
        });
      });
    });
  </script>
</body>
</html>