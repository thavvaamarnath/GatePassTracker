<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title> PU - Admin Dashboard</title>
    <style>
        /* Global Styles */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
            position: relative;
            width: 100%;
            bottom: 0;
        }

        /* Container Styles */
        .container {
            flex: 1;
            max-width: 1000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
        /* Form Styles */
        form {
            display: inline-block;
            margin: 10px 0;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
            transition: background-color 0.3s ease-in-out;
        }
        input[type="submit"]:hover {
            background-color: #3e8e41;
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
    <link rel="icon" type="jpeg/png" href="images/pu_logo.png">
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
        <h1>Admin Dashboard</h1>
        <h2>All Gatepasses</h2>

        <% 
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/gatepass_db";
            String dbUser = "root";
            String dbPassword = "";
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                // Establish connection to the database
                connection = DriverManager.getConnection(url, dbUser, dbPassword);
                statement = connection.createStatement();

                // Retrieve all gatepasses
                String query = "SELECT * FROM gatepasses";
                resultSet = statement.executeQuery(query);
        %>

        <table>
            <tr>
                <th>Gatepass ID</th>
                <th>Student ID</th>
                <th>Name</th>
                <th>ERP</th>
                <th>Reason</th>
                <th>Entry Date</th>
                <th>Entry Time</th>
                <th>Exit Date</th>
                <th>Exit Time</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                while (resultSet.next()) {
                    int gatepassId = resultSet.getInt("gatepass_id");
                    int studentId = resultSet.getInt("student_id");
                    String name = resultSet.getString("name");
                    int erp = resultSet.getInt("erp");
                    String reason = resultSet.getString("reason");
                    java.sql.Date entryDate = resultSet.getDate("entry_date");
                    java.sql.Time entryTime = resultSet.getTime("entry_time");
                    java.sql.Date exitDate = resultSet.getDate("exit_date");
                    java.sql.Time exitTime = resultSet.getTime("exit_time");
                    String status = resultSet.getString("status");
            %>
            <tr>
                <td><%= gatepassId %></td>
                <td><%= studentId %></td>
                <td><%= name %></td>
                <td><%= erp %></td>
                <td><%= reason %></td>
                <td><%= entryDate %></td>
                <td><%= entryTime %></td>
                <td><%= exitDate %></td>
                <td><%= exitTime %></td>
                <td><%= status %></td>
                <td>
                    <form action="approve_reject_gatepass.jsp" method="post">
                        <input type="hidden" name="gatepassId" value="<%= gatepassId %>">
                        <input type="submit" name="action" value="Approve">
                        <input type="submit" name="action" value="Reject">
                    </form>
                </td>
            </tr>
            <% 
                }
            } catch (SQLException e) {
                out.println("SQL Error: " + e.getMessage());
                e.printStackTrace();
            } finally {
                // Close resources
                try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (statement != null) statement.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            %>
        </table>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2024 Parul University
    </div>
</body>
</html>
