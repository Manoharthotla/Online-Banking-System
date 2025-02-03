<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("user_id");
    double currentBalance = 0.0;
%>
<html>
<head>
    <title>Check Balance</title>
    <style>
        /* General page styling */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #90caf9); /* Gradient background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full screen height */
            background-image: url('check.jpg'); /* Replace with your background image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        /* Container for the balance details */
        .container {
            background: #ffffff; /* White background */
            border: 1px solid #ddd; /* Light border */
            border-radius: 10px; /* Rounded corners */
            padding: 30px; /* Padding around content */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            max-width: 400px; /* Restrict max width */
            text-align: center; /* Center align content */
        }

        /* Heading styling */
        h2 {
            color: #1976d2; /* Blue color for heading */
            font-size: 24px; /* Larger heading */
            margin-bottom: 20px; /* Spacing below heading */
        }

        /* Paragraph styling */
        p {
            font-size: 18px; /* Slightly larger text */
            color: #333; /* Neutral color for balance */
            margin: 10px 0; /* Spacing between lines */
        }

        /* Link styling */
        a {
            display: block; /* Block element for alignment */
            margin-top: 30px; /* Space above link */
            padding: 10px 15px; /* Padding for button effect */
            background: #0056b3; /* Blue background */
            color: #ffffff; /* White text */
            text-decoration: none; /* Remove underline */
            border-radius: 5px; /* Rounded corners */
            font-weight: bold; /* Bold text */
            transition: background 0.3s ease; /* Smooth transition effect */
            font-size: 14px;
        }

        a:hover {
            background: #004ba0; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Check Your Balance</h2>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                // Fetch current balance
                String query = "SELECT balance FROM users WHERE user_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    currentBalance = rs.getDouble("balance");
                } else {
                    out.println("<p style='color:red;'>Error: Unable to fetch balance.</p>");
                }

                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>

        <p>Your current balance is: <%= currentBalance %></p>
        <a href="operations.jsp">Go back to operations</a>
    </div>
</body>
</html>
