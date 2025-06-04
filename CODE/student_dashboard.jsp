<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>PU - Student Dashboard</title>
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
        
        /* Form Styles */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        label {
            margin-bottom: 10px;
        }
        input {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
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
    <div class="container">
        <div class="header">
            <h1>Student Dashboard</h1>
            <p>Welcome Bharath Reddy!</p>
        </div>
        <form action="apply_gatepass.jsp" method="post">
            <h2>Apply for Gatepass</h2>
            <label for="reason">Reason:</label>
            <input type="text" id="reason" name="reason" required>
            <br>
            <label for="entryDate">Entry Date:</label>
            <input type="date" id="entryDate" name="entryDate" required min="<%= String.format("%tF", new java.util.Date()) %>">
            <br>
            <label for="entryTime">Entry Time:</label>
            <input type="time" id="entryTime" name="entryTime" required>
            <br>
            <label for="exitDate">Exit Date:</label>
            <input type="date" id="exitDate" name="exitDate" required min="<%= String.format("%tF", new java.util.Date()) %>">
            <br>
            <label for="exitTime">Exit Time:</label>
            <input type="time" id="exitTime" name="exitTime" required>
            <br>
            <button type="submit">Apply</button>
        </form>
        <br>
        <a href="view_gatepass_status.jsp">View Gatepass Status</a>
    </div>
</body>
</html>
