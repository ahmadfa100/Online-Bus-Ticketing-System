<%--
    Document   : adminDashboard
    Created on : 14 Apr 2025, 3:54:27 PM
    Author     : Ahmad
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="active" value= "${activeTab}" />

<jsp:include page="Header.jsp" />

<link rel="stylesheet" href="<c:url value='/CSS/adminDashboard.css'/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<div class="admin-dashboard container">
  <div class="dashboard-header">
    <h2 class="dashboard-title"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h2>
    <div class="dashboard-actions">
      <div class="user-info">
        <i class="fas fa-user-circle"></i> Admin
      </div>
    </div>
  </div>

  <div class="dashboard-tabs">
    <button id="tab-trips" class="tab-button ${active == 'trips' ? 'active' : ''}" data-tab="trips">
      <i class="fas fa-route"></i> Manage Trips
    </button>
    <button id="tab-fares" class="tab-button ${active == 'fares' ? 'active' : ''}" data-tab="fares">
      <i class="fas fa-tag"></i> Fare Rules
    </button>
    <button id="tab-reports" class="tab-button ${active == 'reports' ? 'active' : ''}" data-tab="reports">
      <i class="fas fa-chart-line"></i> Reports
    </button>
  </div>

  <div class="dashboard-content">
    <div id="section-trips" class="dashboard-section">
      <c:if test="${not empty editTrip}">
        <div class="card form-card">
          <div class="card-header">
            <h3><i class="fas fa-edit"></i> Edit Trip #${editTrip.tripId}</h3>
          </div>
          <div class="card-body">
            <form action="${pageContext.request.contextPath}/AdminController" method="post">
              <input type="hidden" name="action" value="editTrip" />
              <input type="hidden" name="tripId" value="${editTrip.tripId}" />
              <div class="form-grid">
                <div class="form-group">
                  <label>Origin</label>
                  <input type="text" name="origin" value="${editTrip.origin}" required />
                </div>
                <div class="form-group">
                  <label>Destination</label>
                  <input type="text" name="destination" value="${editTrip.destination}" required />
                </div>
                <div class="form-group">
                  <label>Departure Time</label>
                  <input type="datetime-local" name="departureTime" value="${editTrip.departureTime}" required />
                </div>
                <div class="form-group">
                  <label>Arrival Time</label>
                  <input type="datetime-local" name="arrivalTime" value="${editTrip.arrivalTime}" required />
                </div>
                <div class="form-group">
                  <label>Travel Type</label>
                  <div class="select-wrapper">
                    <select name="travelType">
                      <option value="City" ${editTrip.travelType == 'City' ? 'selected':''}>City</option>
                      <option value="Inter-city" ${editTrip.travelType == 'Inter-city' ? 'selected':''}>Inter-city</option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label>Available Seats</label>
                  <input type="number" name="availableSeats" min="1" value="${editTrip.availableSeats}" required />
                </div>
              </div>
              <div class="form-actions">
                <button type="submit" class="btn primary"><i class="fas fa-save"></i> Update Trip</button>
                <a href="${pageContext.request.contextPath}/AdminController" class="btn secondary"><i class="fas fa-times"></i> Cancel</a>
              </div>
            </form>
          </div>
        </div>
      </c:if>

      <div class="card">
        <div class="card-header">
          <h3><i class="fas fa-list"></i> Available Trips</h3>
          <div class="card-actions">
            <button class="btn icon" id="refresh-trips"><i class="fas fa-sync-alt"></i></button>
          </div>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="data-table">
              <thead>
                <tr>
                  <th>ID</th><th>Origin</th><th>Destination</th>
                  <th>Departure</th><th>Arrival</th><th>Type</th>
                  <th>Seats</th><th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="trip" items="${tripList}">
                  <tr>
                    <td>${trip.tripId}</td>
                    <td>${trip.origin}</td>
                    <td>${trip.destination}</td>
                    <td>${trip.departureTime}</td>
                    <td>${trip.arrivalTime}</td>
                    <td><span class="badge ${trip.travelType == 'City' ? 'badge-blue' : 'badge-green'}">${trip.travelType}</span></td>
                    <td><span class="badge ${trip.availableSeats > 20 ? 'badge-green' : trip.availableSeats > 10 ? 'badge-orange' : 'badge-red'}">${trip.availableSeats}</span></td>
                    <td class="actions">
                      <c:url var="editUrl" value="/AdminController">
                        <c:param name="action" value="editTrip" />
                        <c:param name="tripId" value="${trip.tripId}" />
                      </c:url>
                      <a href="${editUrl}" class="btn icon primary" title="Edit"><i class="fas fa-edit"></i></a>
                      <form method="post" action="${pageContext.request.contextPath}/AdminController">
                        <input type="hidden" name="action" value="deleteTrip" />
                        <input type="hidden" name="tripId" value="${trip.tripId}" />
                        <button type="submit" class="btn icon danger" title="Delete" onclick="return confirm('Delete this trip?');">
                          <i class="fas fa-trash-alt"></i>
                        </button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <c:if test="${empty editTrip}">
        <div class="card form-card">
          <div class="card-header">
            <h3><i class="fas fa-plus-circle"></i> Add New Trip</h3>
          </div>
          <div class="card-body">
            <form action="${pageContext.request.contextPath}/AdminController" method="post">
              <input type="hidden" name="action" value="addTrip" />
              <div class="form-grid">
                <div class="form-group">
                  <label>Origin</label>
                  <input type="text" name="origin" required />
                </div>
                <div class="form-group">
                  <label>Destination</label>
                  <input type="text" name="destination" required />
                </div>
                <div class="form-group">
                  <label>Departure Time</label>
                  <input type="datetime-local" name="departureTime" required />
                </div>
                <div class="form-group">
                  <label>Arrival Time</label>
                  <input type="datetime-local" name="arrivalTime" required />
                </div>
                <div class="form-group">
                  <label>Travel Type</label>
                  <div class="select-wrapper">
                    <select name="travelType">
                      <option value="City">City</option>
                      <option value="Inter-city">Inter-city</option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label>Available Seats</label>
                  <input type="number" name="availableSeats" min="1" required />
                </div>
              </div>
              <div class="form-actions">
                <button type="submit" class="btn primary"><i class="fas fa-plus"></i> Add Trip</button>
              </div>
            </form>
          </div>
        </div>
      </c:if>
    </div> 

    <div id="section-fares" class="dashboard-section ${active == 'fares' ? '' : 'hidden'}">
      <div class="card">
        <div class="card-header">
          <h3><i class="fas fa-money-bill-wave"></i> Fare Rules</h3>
          <p class="card-subtitle">Set pricing rules for different ticket types</p>
        </div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/AdminController" method="post">
            <input type="hidden" name="action" value="updateFareRules" />
            <div class="table-responsive">
              <table class="data-table">
                <thead>
                  <tr>
                    <th>Ticket Type</th>
                    <th>Travel Category</th>
                    <th>Base Fare ($)</th>
                    <th>Student Disc (%)</th>
                    <th>Senior Disc (%)</th>
                    <th>Evening Disc (%)</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="rule" items="${fareRules}">
                    <tr>
                      <td>${rule.ticketType}</td>
                      <td>${rule.travelCategory}</td>
                      <td>
                        <div class="input-with-icon">
                          <i class="fas fa-dollar-sign"></i>
                          <input type="number" step="0.01" min="0"
                                 name="baseFare_${rule.ruleId}"
                                 value="${rule.baseFare}" required/>
                        </div>
                      </td>
                      <td>
                        <div class="input-with-icon">
                          <i class="fas fa-percent"></i>
                          <input type="number" step="0.01" min="0" max="100"
                                 name="studentDisc_${rule.ruleId}"
                                 value="${rule.studentDiscount}" required/>
                        </div>
                      </td>
                      <td>
                        <div class="input-with-icon">
                          <i class="fas fa-percent"></i>
                          <input type="number" step="0.01" min="0" max="100"
                                 name="seniorDisc_${rule.ruleId}"
                                 value="${rule.seniorDiscount}" required/>
                        </div>
                      </td>
                      <td>
                        <div class="input-with-icon">
                          <i class="fas fa-percent"></i>
                          <input type="number" step="0.01" min="0" max="100"
                                 name="eveningDisc_${rule.ruleId}"
                                 value="${rule.eveningDiscount}" required/>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <div class="form-actions">
              <button type="submit" class="btn primary"><i class="fas fa-save"></i> Save Changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <div id="section-reports" class="dashboard-section ${active == 'reports' ? '' : 'hidden'}">
      <div class="card">
        <div class="card-header">
          <h3><i class="fas fa-chart-pie"></i> Sales Reports</h3>
          <p class="card-subtitle">Generate reports for specific time periods</p>
        </div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/AdminController" method="get" class="report-form">
            <input type="hidden" name="action" value="generateReport" />
            <div class="form-grid">
              <div class="form-group">
                <label>Select Period</label>
                <div class="select-wrapper">
                  <select name="period">
                    <option value="daily">Daily</option>
                    <option value="weekly">Weekly</option>
                    <option value="monthly">Monthly</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label>From Date</label>
                <input type="date" name="fromDate" required/>
              </div>
              <div class="form-group">
                <label>To Date</label>
                <input type="date" name="toDate" required/>
              </div>
              <div class="form-group form-action">
                <button type="submit" class="btn primary"><i class="fas fa-chart-bar"></i> Generate Report</button>
              </div>
            </div>
          </form>
          
          <c:if test="${not empty reportData}">
            <div class="report-summary">
              <div class="summary-card">
                <div class="summary-icon bg-blue">
                  <i class="fas fa-ticket-alt"></i>
                </div>
                <div class="summary-content">
                  <span class="summary-label">Total Tickets Sold</span>
                  <span class="summary-value">${totalTickets}</span>
                </div>
              </div>
              <div class="summary-card">
                <div class="summary-icon bg-green">
                  <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="summary-content">
                  <span class="summary-label">Total Revenue</span>
                  <span class="summary-value">$${totalRevenue}</span>
                </div>
              </div>
            </div>
            
            <div class="table-responsive">
              <table class="data-table">
                <thead>
                  <tr><th>Period</th><th>Tickets Sold</th><th>Revenue</th></tr>
                </thead>
                <tbody>
                  <c:forEach var="row" items="${reportData}">
                    <tr>
                      <td>${row.period}</td>
                      <td>${row.ticketsSold}</td>
                      <td>$${row.revenue}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div> 

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const tabs = document.querySelectorAll('.tab-button');
    const sections = document.querySelectorAll('.dashboard-section');
    
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        tabs.forEach(t => t.classList.remove('active'));
        tab.classList.add('active');
        
        const targetId = tab.getAttribute('data-tab');
        sections.forEach(section => {
          if(section.id === `section-${targetId}`) {
            section.classList.remove('hidden');
            section.scrollIntoView({ behavior: 'smooth', block: 'start' });
          } else {
            section.classList.add('hidden');
          }
        });
        
        fetch(`${pageContext.request.contextPath}/AdminController?action=setActiveTab&tab=${targetId}`, {
          method: 'GET'
        });
      });
    });
    
    document.getElementById('refresh-trips')?.addEventListener('click', () => {
      window.location.reload();
    });
    
    const activeSection = document.querySelector('.dashboard-section:not(.hidden)');
    if(activeSection) {
      setTimeout(() => {
        activeSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }, 300);
    }
  });
</script>

<jsp:include page="Footer.jsp" />