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
    <title>Withdraw Money</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background: linear-gradient(135deg, #74b9ff, #a29bfe);
    color: #333;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-image: url("credit.png");
    background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(3px);
}

form {
    background-color: #ffffff;
    padding: 20px 40px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    width: 100%;
    max-width: 400px;
}

h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #2d3436;
}

label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #2d3436;
}

input[type="number"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #dfe6e9;
    border-radius: 5px;
    font-size: 16px;
}

button {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    color: #ffffff;
    background-color:#0056b3;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #74b9ff;
}

p {
    text-align: center;
    font-size: 14px;
}

p[style*="color:red"] {
    color: #d63031;
}

p[style*="color:green"] {
    color: green;
}
#myimage{
            border-radius: 50%;
            max-width: 100%; /* Ensure the image is responsive */
    height: auto; /* Maintain aspect ratio */
    margin-bottom: 20px;
    margin-left: 100px;
        }
        a.button {
            display: flex;
            justify-content: center; /* Makes the anchor behave like a block element for padding */
            padding: 8px 20px; /* Add space inside the "button" */
        font-size: 14px;/* Adjust text size */
        color: #ffffff; /* Button text color */
        background-color:#38485a; /* Button background color */
        text-decoration: none; /* Remove the underline */
        border-radius: 5px; /* Rounded corners */
        border: none; /* Remove any borders */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2); /* Optional: Add a shadow for a button-like effect */
        transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth hover effects */
        }

        a.button:hover {
        background-color: #062343; /* Darker blue on hover */
        transform: translateY(-2px); /* Slight "lift" effect on hover */
        }

        a.button:active {
        background-color: #003f7f; /* Even darker blue when pressed */
        transform: translateY(0); /* Reset the "lift" */
        }

    </style>
</head>
<body>
    
    <form action="withdraw.jsp" method="post">
        <image id="myimage" src="rguktimage1.jpeg"></image>
        <h2>Withdraw Money</h2>
        <label for="amount">Amount to Withdraw:</label>
        <input type="number" name="amount" step="0.01" min="1" required><br><br>
        <button type="submit">Withdraw</button><br><br>
        <a class="button" href="operations.jsp">Go back to operations</a>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            double withdrawAmount = Double.parseDouble(request.getParameter("amount"));

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                // Check current balance
                String getBalanceQuery = "SELECT balance FROM users WHERE user_id = ?";
                PreparedStatement getBalanceStmt = conn.prepareStatement(getBalanceQuery);
                getBalanceStmt.setInt(1, userId);
                ResultSet rs = getBalanceStmt.executeQuery();

                if (rs.next()) {
                    double currentBalance = rs.getDouble("balance");

                    if (withdrawAmount > currentBalance) {
                        out.println("<p style='color:red;'>Insufficient balance. Please try again.</p>");
                    } else {
                        // Deduct amount from balance
                        String updateBalanceQuery = "UPDATE users SET balance = balance - ? WHERE user_id = ?";
                        PreparedStatement updateBalanceStmt = conn.prepareStatement(updateBalanceQuery);
                        updateBalanceStmt.setDouble(1, withdrawAmount);
                        updateBalanceStmt.setInt(2, userId);
                        updateBalanceStmt.executeUpdate();

                        // Log transaction
                        String logTransactionQuery = "INSERT INTO transactions (user_id, transaction_type, amount, description) VALUES (?, 'debit', ?, 'Withdrawal')";
                        PreparedStatement logTransactionStmt = conn.prepareStatement(logTransactionQuery);
                        logTransactionStmt.setInt(1, userId);
                        logTransactionStmt.setDouble(2, withdrawAmount);
                        logTransactionStmt.executeUpdate();

                        out.println("<p style='color:rgb(15, 211, 15);'><h2>Withdrawal successful! Amount withdrawn: " + withdrawAmount + "</h2></p>");

                        updateBalanceStmt.close();
                        logTransactionStmt.close();
                    }
                } else {
                    out.println("<p style='color:red;'>Error fetching balance. Please try again later.</p>");
                }

                rs.close();
                getBalanceStmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
