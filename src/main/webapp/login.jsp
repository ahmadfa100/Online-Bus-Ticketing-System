<%-- 
    Document   : login
    Created on : 14 Apr 2025, 3:53:04 PM
    Author     : Ahmad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" href="CSS/login.css">

</head>
<body>
<div class="container">
    <h2>User Login</h2>
    <% String errorMessage = (String) request.getAttribute("errorMessage"); 
       if (errorMessage != null) { %>
    <div class="error"><%= errorMessage %></div>
    <% } %>
    <form action="UserController" method="post">
        <input type="hidden" name="action" value="login">
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required placeholder="Enter your email">
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password">
        </div>
        <button type="submit" class="btn">Login</button>
    </form>
    <div class="link">
        <p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
    </div>
</div>
</body>
</html>