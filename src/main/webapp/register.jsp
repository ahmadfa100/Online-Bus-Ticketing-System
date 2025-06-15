<%-- 
    Document   : registration
    Created on : 14 Apr 2025, 4:00:50 PM
    Author     : Ahmad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" href="CSS/register.css">

</head>
<body>
<div class="container">
    <h2>User Registration</h2>
    <form action="UserController" method="post">
        <input type="hidden" name="action" value="register">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required placeholder="Enter your username">
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required placeholder="Enter your email">
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password">
        </div>
        <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm your password">
        </div>
        <div class="form-group">
            <label for="status">User Status:</label>
            <select id="status" name="status" required>
                <option value="Regular">Regular</option>
                <option value="Student">Student</option>
                <option value="Senior">Senior</option>
            </select>
        </div>
        <input type="hidden" name="role" value="passenger">
        <button type="submit" class="btn">Register</button>
    </form>
    <div class="link">
        <p>Already have an account? <a href="login.jsp">Login here</a>.</p>
    </div>
</div>
</body>
</html>