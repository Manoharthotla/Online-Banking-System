<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("admin_id") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Remove Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('credit.png'); /* Replace with your background image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(3px);
        }

        form {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h2 {
            text-align: center;
            color: #333333; /* Dark text color */
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            color: #333333; /* Dark gray text */
            display: block;
            margin-bottom: 8px;
        }

        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            background-color: #dc3545; /* Red button for critical action */
            color: #ffffff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #c82333; /* Darker red on hover */
        }

        p {
            font-size: 18px;
            text-align: center;
            margin-top: 20px;
            color: #e90707; /* Error message text color */
        }

        .success {
            color: #28a745; /* Green for success messages */
        }

        .error {
            color: #dc3545; /* Red for error messages */
        }
        a.button {
            display: inline-block;
            padding: 8px 20px;
            margin-top:10px;
            font-size: 13px;
            color: #ffffff;
            background-color: #0056b3; /* Button background color */
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2); /* Optional: Add a shadow for a button-like effect */
            transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth hover effects */
        }

        a.button:hover {
            background-color: #003f7f; /* Darker blue on hover */
            transform: translateY(-2px); /* Slight "lift" effect on hover */
        }
    </style>
</head>
<body>
    <form action="remove_customer.jsp" method="post">
        <h2>Remove Customer</h2>
        <label for="user_id">Customer ID:</label>
        <input type="number" name="user_id" placeholder="Enter Customer ID" required><br>
        <button type="submit">Remove Customer</button>
        <a href="admin_dashboard.jsp" class="button">Go back</a>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            int userId = Integer.parseInt(request.getParameter("user_id"));

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                String query = "DELETE FROM users WHERE user_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, userId);

                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    out.println("<p class='success'>Customer removed successfully!</p>");
                } else {
                    out.println("<p class='error'>Error: Customer not found.</p>");
                }

                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
