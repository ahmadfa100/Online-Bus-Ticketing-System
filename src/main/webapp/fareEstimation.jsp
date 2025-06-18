<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fare Estimation | Bus Tickets</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/footer.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    :root {
      --primary: #1a2b5f;
      --primary-dark: #0d1a40;
      --secondary: #2c3e50;
      --success: #27ae60;
      --light: #f8f9fa;
      --gray: #e0e0e0;
      --text: #333;
      --text-light: #7f8c8d;
      --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      --transition: all 0.3s ease;
    }

    body {
      background-color: #f5f7fa;
      color: var(--text);
      line-height: 1.6;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    main {
      flex: 1;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    .page-title {
      text-align: center;
      margin: 2.5rem 0;
      color: var(--primary);
    }

    .page-title h2 {
      font-size: 2.2rem;
      margin-bottom: 8px;
    }

    .page-title p {
      color: var(--text-light);
      font-size: 1.1rem;
      max-width: 600px;
      margin: 0 auto;
    }

    .estimation-container {
      max-width: 700px;
      margin: 0 auto 3rem;
      background: white;
      border-radius: 12px;
      box-shadow: var(--shadow);
      overflow: hidden;
      transition: var(--transition);
    }

    .estimation-container:hover {
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
    }

    .card-header {
      background: linear-gradient(135deg, var(--primary), var(--primary-dark));
      color: white;
      padding: 1.5rem;
      text-align: center;
    }

    .card-header h3 {
      font-size: 1.5rem;
      font-weight: 600;
    }

    .card-body {
      padding: 2rem;
    }

    .trip-info {
      background: #f8fafc;
      border-radius: 8px;
      padding: 1.5rem;
      margin-bottom: 2rem;
      border-left: 4px solid var(--primary);
    }

    .trip-info p {
      display: flex;
      margin-bottom: 12px;
      align-items: center;
    }

    .trip-info i {
      margin-right: 12px;
      color: var(--primary);
      min-width: 24px;
      text-align: center;
    }

    .trip-info strong {
      min-width: 100px;
      display: inline-block;
      color: var(--secondary);
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: var(--primary);
    }

    .select-wrapper {
      position: relative;
    }

    .select-wrapper i {
      position: absolute;
      right: 16px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--primary);
      pointer-events: none;
    }

    .form-group select {
      width: 100%;
      padding: 14px 16px;
      font-size: 1rem;
      border: 1px solid var(--gray);
      border-radius: 8px;
      background-color: white;
      appearance: none;
      transition: var(--transition);
    }

    .form-group select:focus {
      border-color: var(--primary);
      outline: none;
      box-shadow: 0 0 0 3px rgba(26, 43, 95, 0.2);
    }

    .btn-group {
      display: flex;
      gap: 16px;
      margin-top: 2rem;
    }

    .btn {
      display: inline-block;
      padding: 14px 28px;
      font-size: 1rem;
      font-weight: 600;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      text-align: center;
      transition: var(--transition);
      flex: 1;
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--primary), var(--primary-dark));
      color: white;
      box-shadow: 0 4px 8px rgba(26, 43, 95, 0.3);
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(26, 43, 95, 0.4);
    }

    .btn-success {
      background: linear-gradient(135deg, var(--success), #219653);
      color: white;
      box-shadow: 0 4px 8px rgba(39, 174, 96, 0.3);
    }

    .btn-success:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(39, 174, 96, 0.4);
    }

    .fare-result {
      background: linear-gradient(135deg, #e8f4fc, #d4eaf9);
      border-radius: 8px;
      padding: 1.5rem;
      margin-top: 2rem;
      text-align: center;
      animation: fadeIn 0.5s ease;
      border: 1px dashed var(--primary);
    }

    .fare-result h3 {
      font-size: 1.4rem;
      margin-bottom: 12px;
      color: var(--secondary);
    }

    .fare-amount {
      font-size: 2.2rem;
      font-weight: 700;
      color: var(--primary);
      margin: 10px 0;
    }

    .purchase-note {
      color: var(--text-light);
      font-size: 0.95rem;
      margin-top: 12px;
    }

    .login-prompt {
      text-align: center;
      padding: 2rem;
      background: #fff9e6;
      border-radius: 8px;
      border-left: 4px solid #f1c40f;
    }

    .login-prompt a {
      color: var(--primary);
      font-weight: 600;
      text-decoration: none;
    }

    .login-prompt a:hover {
      text-decoration: underline;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 768px) {
      .btn-group {
        flex-direction: column;
      }
      
      .trip-info p {
        flex-direction: column;
        align-items: flex-start;
      }
      
      .trip-info strong {
        margin-bottom: 5px;
      }
    }

    @media (max-width: 480px) {
      .card-body {
        padding: 1.5rem;
      }
      
      .page-title h2 {
        font-size: 1.8rem;
      }
      
      .fare-amount {
        font-size: 1.8rem;
      }
      
      .btn {
        padding: 12px 20px;
      }
    }
  </style>
</head>
<body>
  <jsp:include page="Header.jsp" />

  <main>
    <div class="container">
      <div class="page-title">
        <h2>Fare Estimation</h2>
        <p>Get an accurate fare estimate for your journey</p>
      </div>

      <div class="estimation-container">
        <div class="card-header">
          <h3>Plan Your Trip</h3>
        </div>
        
        <div class="card-body">
          <c:if test="${empty sessionScope.currentUser}">
            <div class="login-prompt">
              <p><i class="fas fa-exclamation-circle"></i> Please <a href="login.jsp">login</a> to estimate fares.</p>
            </div>
          </c:if>

          <c:if test="${not empty sessionScope.currentUser}">
            <div class="trip-info">
              <p><i class="fas fa-route"></i><strong>Trip:</strong> ${trip.origin} &rarr; ${trip.destination}</p>
              <p><i class="fas fa-clock"></i><strong>Departure:</strong> ${trip.departureTime}</p>
              <p><i class="fas fa-flag-checkered"></i><strong>Arrival:</strong> ${trip.arrivalTime}</p>
              <p><i class="fas fa-bus"></i><strong>Type:</strong> ${trip.travelType}</p>
            </div>

            <form action="${pageContext.request.contextPath}/TicketController" method="post">
              <input type="hidden" name="action" value="estimate" />
              <input type="hidden" name="tripId" value="${trip.tripId}" />
              <input type="hidden" name="travelType" value="${trip.travelType}" />

              <div class="form-group">
                <label for="ticketType"><i class="fas fa-ticket-alt"></i> Ticket Type</label>
                <div class="select-wrapper">
                  <select id="ticketType" name="ticketType">
                    <option value="One-Trip">One-Trip Ticket</option>
                    <option value="Daily Pass">Daily Pass</option>
                    <option value="Weekly Pass">Weekly Pass</option>
                    <option value="Monthly Pass">Monthly Pass</option>
                  </select>
                  <i class="fas fa-chevron-down"></i>
                </div>
              </div>

              <div class="btn-group">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-calculator"></i> Calculate Fare
                </button>
              </div>
            </form>

            <c:if test="${not empty estimatedFare}">
              <div class="fare-result">
                <h3>Your Estimated Fare</h3>
                <p>Based on your trip details and ticket selection</p>
                <div class="fare-amount">${estimatedFare}</div>
                <p class="purchase-note">Ready to purchase your ticket?</p>
                
                <form action="${pageContext.request.contextPath}/PurchaseController"
                      method="post" class="inline-form">
                  <input type="hidden" name="tripId" value="${trip.tripId}" />
                  <input type="hidden" name="ticketType" value="${ticket.ticketType}" />
                  <input type="hidden" name="travelType" value="${ticket.travelCategory}" />
                  <input type="hidden" name="finalFare" value="${estimatedFare}" />

                  <div class="btn-group">
                    <button type="submit" class="btn btn-success">
                      <i class="fas fa-shopping-cart"></i> Purchase Ticket
                    </button>
                  </div>
                </form>
              </div>
            </c:if>
          </c:if>
        </div>
      </div>
    </div>
  </main>

  <jsp:include page="Footer.jsp" />
</body>
</html>