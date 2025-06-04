<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>PU - Approve/Reject Gatepass</title>
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

        /* Header Styles */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .header .logo img {
            height: 40px; /* Adjust as needed */
            width: auto; /* Maintain aspect ratio */
        }
        .header nav {
            display: flex;
            gap: 20px;
        }
        .header nav a {
            color: #fff;
            text-decoration: none;
            font-size: 1em;
            transition: color 0.3s ease-in-out, transform 0.3s ease-in-out;
        }
        .header nav a:hover {
            color: #e0e0e0;
            transform: scale(1.1);
        }
        
        /* Footer Styles */
        .footer {
            background-color: #4CAF50;
            color: #fff;
            text-align: center;
            padding: 10px 20px;
            margin-top: auto;
        }

        /* Container Styles */
        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Message Styles */
        .message {
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #f0f0f0;
            margin-bottom: 20px;
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
        <div class="logo">
            <img src="images/pu_logo.png" alt="Logo" style="height: 50px; width: 200px;">
        </div>
        <nav>
            <a href="#">Home</a>
            <a href="#">About</a>
            <a href="#">Services</a>
            <a href="logout.jsp" class="logout-button">Logout</a>
        </nav>
    </div>

    <!-- Main Container -->
    <div class="container">
        <h1>Approve/Reject Gatepass</h1>
        <%
            String action = request.getParameter("action");
            int gatepassId = Integer.parseInt(request.getParameter("gatepassId"));

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/gatepass_db";
            String dbUser = "root";
            String dbPassword = "";
            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                // Establish connection to the database
                connection = DriverManager.getConnection(url, dbUser, dbPassword);

                // Determine status based on action
                String status = null;
                if ("Approve".equals(action)) {
                    status = "APPROVED";
                } else if ("Reject".equals(action)) {
                    status = "REJECTED";
                }

                if (status != null) {
                    // Update gate pass status
                    String updateQuery = "UPDATE gatepasses SET status = ? WHERE gatepass_id = ?";
                    preparedStatement = connection.prepareStatement(updateQuery);
                    preparedStatement.setString(1, status);
                    preparedStatement.setInt(2, gatepassId);

                    int rowsAffected = preparedStatement.executeUpdate();
                    if (rowsAffected > 0) {
        %>
        <div class="message">
            Gate pass <%= status %> successfully!
        </div>
        <%
                    } else {
        %>
        <div class="message">
            Error updating gate pass.
        </div>
        <%
                    }
                } else {
        %>
        <div class="message">
            Invalid action.
        </div>
        <%
                }
            } catch (SQLException e) {
                out.println("SQL Error: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources
                try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <a href="admin_dashboard.jsp">Back to Dashboard</a>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2024 Parul University
    </div>
</body>
</html>
