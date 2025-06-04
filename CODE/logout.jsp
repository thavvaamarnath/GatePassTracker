<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>PU - Logout</title>
    <link rel="icon" type="jpeg/png" href="images/pu_logo.png">
</head>
<body>
    <%
        // Get the current session
        HttpSession userSession = request.getSession();

        // Remove session attributes
        userSession.removeAttribute("username");
        userSession.removeAttribute("role");

        // Add a message to the session
        userSession.setAttribute("message", "You have been logged out successfully.");

        // Redirect to the login page
        response.sendRedirect("index.jsp");
    %>
</body>
</html>
