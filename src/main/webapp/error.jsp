<%-- 
    Document   : error
    Created on : 23 May 2025, 1:31:32 PM
    Author     : Ahmad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" href="CSS/error.css">

</head>
<body>
    <div class="container">
        <h2>Oops!</h2>
        <p class="message"><%= request.getAttribute("errorMessage") %></p>
        <a href="/trips" class="button">Back to Trips</a>
    </div>
</body>
</html>
