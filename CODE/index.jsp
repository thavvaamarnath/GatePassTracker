<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>PU - Gate Pass Management System</title>
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
            max-width: 400px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
        input, select {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #3e8e41;
        }
        
        /* Image Styles */
        .logo {
            width: 100px;
            height: 100px;
            margin: 20px auto;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    <div class="container">
       <!--<img src="‪" alt="Gate Pass Management System Logo" class="logo">-->
        <h1>Welcome to Gate Pass Management System</h1>
        <form action="login.jsp" method="post">
            <label for="role">Role:</label>
            <select id="role" name="role">
                <option value="student">Student</option>
                <option value="admin">Admin</option>
                <option value="rector">Rector</option>
            </select>
            <br>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username">
            <br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password">
            <br>
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>
