<%-- 
    Document   : Header
    Created on : 18 Apr 2025, 11:41:50 AM
    Updated on : [today’s date]
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
            <h1>Bus Tickets</h1>
          </a>
        </div>

        <nav>
          <ul>
            <%
              User currentUser = (User) session.getAttribute("currentUser");
              Boolean isAdmin  = (Boolean) session.getAttribute("isAdmin");
            %>

            <li>
              <c:choose>
                <c:when test="${not empty currentUser}">
                  <a href="${pageContext.request.contextPath}/UserController?action=logout">
                    Logout
                  </a>
                </c:when>
                <c:otherwise>
                  <a href="${pageContext.request.contextPath}/login.jsp">
                    Login
                  </a>
                </c:otherwise>
              </c:choose>
            </li>

            <c:if test="${not empty currentUser}">
     
            <li>
            <a href="${pageContext.request.contextPath}/TicketController?action=history">
                Tickets
             </a>
             </li>
            </c:if>

            <c:if test="${isAdmin == true}">
              <li>
                <a href="${pageContext.request.contextPath}/AdminController">
                  Admin Dashboard
                </a>
              </li>
            </c:if>
          </ul>
        </nav>

      </div>
    </header>
  </body>
</html>
