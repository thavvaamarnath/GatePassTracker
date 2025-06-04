<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>PU - Login</title>
    <link rel="icon" type="jpeg/png" href="images/pu_logo.png">
    <style>
        /* Global Styles */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            flex-direction: column;
        }
        
        /* Container Styles */
        .container {
            max-width: 400px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* Header Styles */
        .header {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            text-align: center;
        }
        
        /* Footer Styles */
        .footer {
            background-color: #4CAF50;
            color: #fff;
            text-align: center;
            padding: 10px 20px;
            margin-top: auto;
        }
        
        /* Link Styles */
        a {
            text-decoration: none;
            color: #4CAF50;
        }
        a:hover {
            color: #3e8e41;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <h1>PU - Login</h1>
    </div>
    
    <!-- Main Container -->
    <div class="container">
        <%
            // Retrieve parameters from request
            String role = request.getParameter("role");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Print debug information
            out.println("Role: " + role);
            out.println("Username: " + username);
            out.println("Password: " + password);

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/gatepass_db";
            String dbUser = "root";
            String dbPassword = "";
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                // Load JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection to the database
                connection = DriverManager.getConnection(url, dbUser, dbPassword);

                // Prepare SQL query based on user role
                String query = "";
                if ("student".equalsIgnoreCase(role)) {
                    query = "SELECT * FROM students WHERE erp = ? AND password = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setInt(1, Integer.parseInt(username));
                } else if ("admin".equalsIgnoreCase(role)) {
                    query = "SELECT * FROM admins WHERE name = ? AND password = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, username);
                } else if ("rector".equalsIgnoreCase(role)) {
                    query = "SELECT * FROM rectors WHERE name = ? AND password = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, username);
                } else {
                    out.println("Invalid role.");
                    return;
                }
                preparedStatement.setString(2, password);

                // Execute the query
                resultSet = preparedStatement.executeQuery();

                // Check if credentials are valid
                if (resultSet.next()) {
                    // Set session attributes
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    // Redirect to appropriate dashboard
                    if ("student".equalsIgnoreCase(role)) {
                        response.sendRedirect("student_dashboard.jsp");
                    } else if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("admin_dashboard.jsp");
                    } else if ("rector".equalsIgnoreCase(role)) {
                        response.sendRedirect("rector_dashboard.jsp");
                    }
                } else {
                    out.println("Invalid login credentials.");
                }
            } catch (Exception e) {
                // Print the exception to the output for debugging
                e.printStackTrace();
                out.println("An error occurred: " + e.getMessage());
            } finally {
                // Close resources
                try { if (resultSet != null) resultSet.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (preparedStatement != null) preparedStatement.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (connection != null) connection.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2024 Parul University
    </div>
</body>
</html>
