<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("user_id");
%>
<html>
<head>
    <title>Transaction History</title>
    <style>
        /* General page styling */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2); /* Light gradient */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column; /* Align content vertically */
            min-height: 100vh; /* Full viewport height */
            background-image: url('history.jpg'); /* Replace with your background image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        /* Container for the content */
        .container {
            background:#ddd; /* White background */
            padding: 30px; /* Padding for spacing */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            width: 90%; /* Responsive width */
            max-width: 800px; /* Limit max width */
            text-align: center; /* Center align content */
        }

        /* Heading styling */
        h2 {
            color: #1976d2; /* Blue text */
            margin-bottom: 20px; /* Space below heading */
        }

        /* Table styling */
        table {
            width: 100%; /* Full width */
            border-collapse: collapse; /* Remove gaps between cells */
            margin-top: 20px; /* Space above the table */
        }

        table, th, td {
            border: 1px solid #ddd; /* Light gray border */
        }

        th, td {
            padding: 10px; /* Spacing inside cells */
            text-align: left; /* Align text to the left */
        }

        th {
            background-color: #1976d2; /* Blue background for header */
            color: white; /* White text for header */
        }

        tr:nth-child(even) {
            background-color: #f9f9f9; /* Light gray for alternate rows */
        }

        tr:hover {
            background-color: #f1f1f1; /* Highlight row on hover */
        }

        /* No transactions found message */
        p {
            color: #333; /* Neutral color */
            font-size: 16px; /* Larger text */
        }

        /* Link styling */
        a {
            display: inline-block; /* Inline block for padding effect */
            margin-top: 20px; /* Space above the link */
            padding: 10px 20px; /* Internal spacing */
            background: #1976d2; /* Blue background */
            color: white; /* White text */
            text-decoration: none; /* No underline */
            border-radius: 5px; /* Rounded corners */
            font-weight: bold; /* Bold text */
            transition: background 0.3s ease; /* Smooth hover effect */
        }

        a:hover {
            background: #004ba0; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Transaction History</h2>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                // Fetch transaction history for the user
                String query = "SELECT * FROM transactions WHERE user_id = ? ORDER BY transaction_date DESC";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();

                // Display transaction history in a table
                if (rs.next()) {
        %>
                    <table>
                        <thead>
                            <tr>
                                <th>Transaction ID</th>
                                <th>Transaction Type</th>
                                <th>Amount</th>
                                <th>Description</th>
                                <th>Transaction Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                do {
                            %>
                            <tr>
                                <td><%= rs.getInt("transaction_id") %></td>
                                <td><%= rs.getString("transaction_type") %></td>
                                <td><%= rs.getDouble("amount") %></td>
                                <td><%= rs.getString("description") %></td>
                                <td><%= rs.getTimestamp("transaction_date") %></td>
                            </tr>
                            <%
                                } while (rs.next());
                            %>
                        </tbody>
                    </table>
                <%
                } else {
                    out.println("<p>No transactions found.</p>");
                }

                pstmt.close();
                rs.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>

        <a href="operations.jsp">Back to Operations</a>
    </div>
</body>
</html>
