<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%
    // Check if the session exists and user is logged in
    
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve user ID from the session
    int userId = (int) session.getAttribute("user_id");

    // Initialize variables to store user details
    String userName = "";
    String email = "";
    double balance = 0.0;

    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

        // Fetch user details
        String query = "SELECT username, email,balance FROM users WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();

        // Populate user details
        if (rs.next()) {
            userName = rs.getString("username");
            email = rs.getString("email");
            balance = rs.getDouble("balance");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
<html>
<head>
    <title>Operations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            background-color: #f4f8fb; /* Light background */
        }

        /* Sidebar styling */
        .sidebar {
            width: 250px;
            background-color: #2c3e50; /* Dark blue-gray */
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px 0;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 2px solid white;
            margin-bottom: 20px;
        }

        .sidebar h3 {
            text-align: center;
            margin: 10px 0;
            font-size: 18px;
            color: #ecf0f1; /* Light gray text */
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            width: 100%;
        }

        .sidebar ul li {
            width: 100%;
            margin: 10px 0;
        }

        .sidebar ul li a {
            display: block;
            width: 100%;
            text-decoration: none;
            color: white;
            background-color: #34495e; /* Slightly lighter blue-gray */
            padding: 10px 20px;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .sidebar ul li a:hover {
            background-color: #1abc9c; /* Green hover effect */
        }

        .sidebar ul li a:active {
            background-color: #16a085; /* Darker green on click */
        }

        /* Main content styling */
        .main-content {
            flex: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            background-color: #ffffff; /* White background */
        }

        .main-content h2 {
            font-size: 28px;
            color: #2c3e50; /* Dark text color */
            margin-bottom: 10px;
        }

        .main-content table {
            border-collapse: collapse;
            width: 100%;
        }

        .main-content table th, .main-content table td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .main-content table th {
            background-color: #2c3e50;
            color: white;
            text-align: left;
        }

        .main-content table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <img src="rguktimage1.jpeg" alt="Bank Logo">
        <h3>UserName: <%=userName%></h3>
        <ul>
            <li><a href="addAmount.jsp">Add Amount</a></li>
            <li><a href="withdraw.jsp">Withdraw</a></li>
            <li><a href="transfer.jsp">Transfer Money</a></li>
            <li><a href="checkBalance.jsp">Check Balance</a></li>
            <li><a href="transactionHistory.jsp">Transaction History</a></li>
            <li><a href="password_change.jsp">Change Password</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="bank">
            <h2>Welcome to RGUKT Bank!</h2>
            <p style="font-size: 16px; color: #555; margin-bottom: 20px;">
                At RGUKT Bank, we are committed to providing you with the best financial services to help you achieve your dreams. 
                Manage your account, transfer funds, and monitor your transactions all in one secure place.
            </p>
        </div>
        <h2>Customer Details</h2>
        <table>
            <tr>
                <th>UserId</th>
                <td><%= userId %></td>
            </tr>
            <tr>
                <th>Name</th>
                <td><%= userName %></td>
            </tr>
            <tr>
                <th>Email</th>
                <td><%= email %></td>
            </tr>
            <tr>
                <th>Balance</th>
                <td><%= balance %></td>
            </tr>
        </table>
    </div>
</body>
</html>
