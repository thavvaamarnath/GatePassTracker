<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    String username = (String) session.getAttribute("username");
    int erp = Integer.parseInt(username);  // Assuming ERP is the same as username in this example

    String url = "jdbc:mysql://localhost:3306/gatepass_db";
    String dbUser = "root";
    String dbPassword = "";
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, dbUser, dbPassword);

        // Retrieve gate pass status
        String query = "SELECT * FROM gatepasses WHERE erp = ?";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, erp);
        resultSet = preparedStatement.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>PU - View Gatepass Status</title>
    <style>
        /* Global Styles */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }
        
        /* Container Styles */
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        /* Header Styles */
        .header {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            text-align: center;
        }
        
        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: #fff;
        }
    </style>
    <link rel="icon" type="jpeg/png" href="images/pu_logo.png">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Gatepass Status</h1>
        </div>
        <table>
            <tr>
                <th>ID</th>
                <th>Reason</th>
                <th>Entry Date</th>
                <th>Entry Time</th>
                <th>Exit Date</th>
                <th>Exit Time</th>
                <th>Status</th>
            </tr>
            <% while (resultSet.next()) { %>
            <tr>
                <td><%= resultSet.getInt("gatepass_id") %></td>
                <td><%= resultSet.getString("reason") %></td>
                <td><%= resultSet.getDate("entry_date") %></td>
                <td><%= resultSet.getTime("entry_time") %></td>
                <td><%= resultSet.getDate("exit_date") %></td>
                <td><%= resultSet.getTime("exit_time") %></td>
                <td><%= resultSet.getString("status") %></td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (resultSet != null) resultSet.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (preparedStatement != null) preparedStatement.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (connection != null) connection.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
