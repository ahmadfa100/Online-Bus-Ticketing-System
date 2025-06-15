<%--
    Document   : adminDashboard
    Created on : 14 Apr 2025, 3:54:27â€‰PM
    Author     : Ahmad
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="active" value= "${activeTab}" />

<jsp:include page="Header.jsp" />

<link rel="stylesheet" href="<c:url value='/CSS/adminDashboard.css'/>">
<link rel="stylesheet" href="<c:url value='/CSS/header.css'/>">
<link rel="stylesheet" href="<c:url value='/CSS/footer.css'/>">

<div class="admin-dashboard container">
  <h2 class="dashboard-title">Admin Dashboard</h2>

  <div class="dashboard-tabs">
    <button id="tab-trips"
            class="tab-button ${active == 'trips' ? 'active' : ''}"
            data-tab="trips">
      Manage Trips
    </button>
    <button id="tab-fares"
            class="tab-button ${active == 'fares' ? 'active' : ''}"
            data-tab="fares">
      Set Fare Rules
    </button>
    <button id="tab-reports"
            class="tab-button ${active == 'reports' ? 'active' : ''}"
            data-tab="reports">
      Reports
    </button>
  </div>

        <div id="section-trips" class="dashboard-section">
    <!-- EDIT Trip Form -->
    <c:if test="${not empty editTrip}">
      <div class="card form-card">
        <h3>Edit Trip #${editTrip.tripId}</h3>
        <form action="${pageContext.request.contextPath}/AdminController" method="post">
          <input type="hidden" name="action" value="editTrip" />
          <input type="hidden" name="tripId" value="${editTrip.tripId}" />
          <div class="form-grid">
            <label>Origin
              <input type="text" name="origin" value="${editTrip.origin}" required />
            </label>
            <label>Destination
              <input type="text" name="destination" value="${editTrip.destination}" required />
            </label>
            <label>Departure Time
              <input type="datetime-local" name="departureTime" value="${editTrip.departureTime}" required />
            </label>
            <label>Arrival Time
              <input type="datetime-local" name="arrivalTime" value="${editTrip.arrivalTime}" required />
            </label>
            <label>Travel Type
              <select name="travelType">
                <option value="City" ${editTrip.travelType == 'City' ? 'selected':''}>City</option>
                <option value="Inter-city" ${editTrip.travelType == 'Inter-city' ? 'selected':''}>Inter-city</option>
              </select>
            </label>
            <label>Seats
              <input type="number" name="availableSeats" min="1" value="${editTrip.availableSeats}" required />
            </label>
          </div>
          <button type="submit" class="btn primary">Update Trip</button>
          <a href="${pageContext.request.contextPath}/AdminController" class="btn">Cancel</a>
        </form>
      </div>
    </c:if>

    <div class="card">
      <h3>Available Trips</h3>
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
                <td>${trip.travelType}</td>
                <td>${trip.availableSeats}</td>
                <td>
                  <c:url var="editUrl" value="/AdminController">
                    <c:param name="action" value="editTrip" />
                    <c:param name="tripId" value="${trip.tripId}" />
                  </c:url>
                  <a href="${editUrl}" class="btn small">Edit</a>
                  <form method="post" action="${pageContext.request.contextPath}/AdminController" style="display:inline">
                    <input type="hidden" name="action" value="deleteTrip" />
                    <input type="hidden" name="tripId" value="${trip.tripId}" />
                    <button type="submit" class="btn small danger" onclick="return confirm('Delete this trip?');">
                      Delete
                    </button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

    <c:if test="${empty editTrip}">
      <div class="card form-card">
        <h3>Add New Trip</h3>
        <form action="${pageContext.request.contextPath}/AdminController" method="post">
          <input type="hidden" name="action" value="addTrip" />
          <div class="form-grid">
            <label>Origin
              <input type="text" name="origin" required />
            </label>
            <label>Destination
              <input type="text" name="destination" required />
            </label>
            <label>Departure Time
              <input type="datetime-local" name="departureTime" required />
            </label>
            <label>Arrival Time
              <input type="datetime-local" name="arrivalTime" required />
            </label>
            <label>Travel Type
              <select name="travelType">
                <option value="City">City</option>
                <option value="Inter-city">Inter-city</option>
              </select>
            </label>
            <label>Seats
              <input type="number" name="availableSeats" min="1" required />
            </label>
          </div>
          <button type="submit" class="btn primary">Add Trip</button>
        </form>
      </div>
    </c:if>
  </div> 

  <div id="section-fares"
       class="dashboard-section ${active == 'fares' ? '' : 'hidden'}">
    <div class="card">
      <h3>Fare Rules</h3>
      <form action="${pageContext.request.contextPath}/AdminController" method="post">
        <input type="hidden" name="action" value="updateFareRules" />
        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th>Ticket Type</th>
                <th>Travel Category</th>
                <th>Base Fare</th>
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
                    <input type="number" step="0.01"
                           name="baseFare_${rule.ruleId}"
                           value="${rule.baseFare}" required/>
                  </td>
                  <td>
                    <input type="number" step="0.01"
                           name="studentDisc_${rule.ruleId}"
                           value="${rule.studentDiscount}" required/>
                  </td>
                  <td>
                    <input type="number" step="0.01"
                           name="seniorDisc_${rule.ruleId}"
                           value="${rule.seniorDiscount}" required/>
                  </td>
                  <td>
                    <input type="number" step="0.01"
                           name="eveningDisc_${rule.ruleId}"
                           value="${rule.eveningDiscount}" required/>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
        <button type="submit" class="btn primary">Save Changes</button>
      </form>
    </div>
  </div>

  <div id="section-reports" class="dashboard-section hidden">
    <div class="card">
      <h3>Sales Reports</h3>
      <form action="${pageContext.request.contextPath}/AdminController" method="get" class="report-form">
        <input type="hidden" name="action" value="generateReport" />
        <label>Select Period:
          <select name="period">
            <option value="daily">Daily</option>
            <option value="weekly">Weekly</option>
            <option value="monthly">Monthly</option>
          </select>
        </label>
        <label>From<input type="date" name="fromDate" required/></label>
        <label>To  <input type="date" name="toDate" required/></label>
        <button type="submit" class="btn primary">Generate</button>
      </form>
      <c:if test="${not empty reportData}">
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
                  <td>${row.revenue}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>
    </div>
  </div>
</div> 

<script>
  const tabs     = document.querySelectorAll('.tab-button');
  const sections = document.querySelectorAll('.dashboard-section');
  tabs.forEach((tab, idx) => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => t.classList.remove('active'));
      sections.forEach(s => s.classList.add('hidden'));
      tab.classList.add('active');
      sections[idx].classList.remove('hidden');
    });
  });
</script>

<jsp:include page="Footer.jsp" />
