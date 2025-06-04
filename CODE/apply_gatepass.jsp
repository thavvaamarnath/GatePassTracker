<%@ page import="java.sql.*, jakarta.servlet.http.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>PU - Apply Gatepass</title>
    <link rel="icon" type="jpeg/png" href="images/pu_logo.png">
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
        <h1>Apply Gatepass</h1>

        <%
            // Retrieve parameters from request
            String reason = request.getParameter("reason");
            String entryDate = request.getParameter("entryDate");
            String entryTime = request.getParameter("entryTime");
            String exitDate = request.getParameter("exitDate");
            String exitTime = request.getParameter("exitTime");

            // Get ERP number from session
            String username = (String) session.getAttribute("username");
            int erp = Integer.parseInt(username);  // Assuming ERP is the same as username

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/gatepass_db";
            String dbUser = "root";
            String dbPassword = "";
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                // Establish connection to the database
                connection = DriverManager.getConnection(url, dbUser, dbPassword);

                // Get student details
                String nameQuery = "SELECT student_id, name FROM students WHERE erp = ?";
                preparedStatement = connection.prepareStatement(nameQuery);
                preparedStatement.setInt(1, erp);
                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    int studentId = resultSet.getInt("student_id");
                    String name = resultSet.getString("name");

                    // Parse date strings
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date entryDateUtil = dateFormat.parse(entryDate);
                    java.util.Date exitDateUtil = dateFormat.parse(exitDate);

                    // Parse time strings
                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                    java.util.Date entryTimeUtil = timeFormat.parse(entryTime);
                    java.util.Date exitTimeUtil = timeFormat.parse(exitTime);

                    // Convert date and time to sql format
                    java.sql.Date entryDateSql = new java.sql.Date(entryDateUtil.getTime());
                    java.sql.Time entryTimeSql = new java.sql.Time(entryTimeUtil.getTime());
                    java.sql.Date exitDateSql = new java.sql.Date(exitDateUtil.getTime());
                    java.sql.Time exitTimeSql = new java.sql.Time(exitTimeUtil.getTime());

                    // Insert gate pass
                    String insertQuery = "INSERT INTO gatepasses (student_id, name, erp, reason, entry_date, entry_time, exit_date, exit_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    preparedStatement = connection.prepareStatement(insertQuery);
                    preparedStatement.setInt(1, studentId);
                    preparedStatement.setString(2, name);
                    preparedStatement.setInt(3, erp);
                    preparedStatement.setString(4, reason);
                    preparedStatement.setDate(5, entryDateSql);
                    preparedStatement.setTime(6, entryTimeSql);
                    preparedStatement.setDate(7, exitDateSql);
                    preparedStatement.setTime(8, exitTimeSql);

                    int rowsAffected = preparedStatement.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("Gate pass applied successfully!");
                    } else {
                        out.println("Error applying gate pass.");
                    }
                } else {
                    out.println("Student not found.");
                }
            } catch (SQLException e) {
                out.println("SQL Error: " + e.getMessage());
                e.printStackTrace();
            } catch (ParseException e) {
                out.println("Parse Error: " + e.getMessage());
                e.printStackTrace();
            } catch (Exception e) {
                out.println("Error: " + e);
                e.printStackTrace();
            } finally {
                // Close resources in the finally block
                try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (preparedStatement != null) preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2024 Parul University
    </div>
</body>
</html>
