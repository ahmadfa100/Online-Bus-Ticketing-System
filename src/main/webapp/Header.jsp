<%-- 
    Document   : Header
    Created on : 18 Apr 2025, 11:41:50 AM
--%>
<%@ page
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="Models.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Bus Tickets</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  </head>
  <body>
    <header>
      <div class="header-container">

        <div class="logo">
          <a href="${pageContext.request.contextPath}/TripController">
            <img
              src="${pageContext.request.contextPath}/images/bus_logo.jpg"
              alt="Bus Tickets Logo"
            >
            <div class="logo-text">
              <h1>Bus Tickets</h1>
            </div>
          </a>
        </div>

        <nav>
          <ul>
            <%
              User currentUser = (User) session.getAttribute("currentUser");
              Boolean isAdmin  = (Boolean) session.getAttribute("isAdmin");
            %>

            <c:if test="${not empty currentUser}">
              <li class="user-info">
                <i class="fas fa-user-circle"></i> ${currentUser.username}
              </li>
            </c:if>
            
            <li>
              <c:choose>
                <c:when test="${not empty currentUser}">
                  <a href="${pageContext.request.contextPath}/UserController?action=logout" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i> Logout
                  </a>
                </c:when>
                <c:otherwise>
                  <a href="${pageContext.request.contextPath}/login.jsp" class="nav-link">
                    <i class="fas fa-sign-in-alt"></i> Login
                  </a>
                </c:otherwise>
              </c:choose>
            </li>

            <c:if test="${not empty currentUser}">
              <li>
                <a href="${pageContext.request.contextPath}/TicketController?action=history" class="nav-link">
                  <i class="fas fa-ticket-alt"></i> My Tickets
                </a>
              </li>
            </c:if>

            <c:if test="${isAdmin == true}">
              <li>
                <a href="${pageContext.request.contextPath}/AdminController" class="nav-link active">
                  <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
              </li>
            </c:if>
          </ul>
        </nav>

      </div>
    </header>
  </body>
</html>