<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in
   
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int senderId = (int) session.getAttribute("user_id");
%>
<html>
<head>
    <title>Transfer Money</title>
    <style>
        /* General styles for the page */
body {
    
    font-family: Arial, sans-serif;
    background-color: #f0f8ff;
    color: #333;
    margin: 20;
    padding: 0;
    background-image: url('money.png'); /* Replace with your background image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(3px);
            
}

/* Center and style the heading */
h2 {
    color: white;
    text-align: center;
    margin-top: 20px;
}

/* Style the form container */
form {
    background: #ffffff;
    border: 1px solid #ccc;
    border-radius: 10px;
    max-width: 400px;
    margin: 20px auto;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    
}

/* Labels for form fields */
label {
    font-weight: bold;
    display: block;
    margin-bottom: 8px;
    color: #333;
}

/* Style for input fields */
input[type="number"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 14px;
}

/* Style for the submit button */
button {
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    padding: 10px 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
}

/* Button hover effect */
button:hover {
    background-color: #004494;
}

/* Styles for success and error messages */
p {
    text-align: center;
    font-size: 14px;
}

p[style*='color:red'] {
    color: #d9534f;
    font-weight: bold;
}

p[style*='color:green'] {
    color: #5cb85c;
    font-weight: bold;
}

/* Style for the back link */
a {
    display: block;
    text-align: center;
    margin-top: 15px;
    color:black;
    text-decoration: none;
    font-size: 14px;
}

a:hover {
    text-decoration: underline;
}

    </style>
</head>
<body>
    <h2>Transfer Money</h2>
    <form action="transfer.jsp" method="post">
        <label for="recipient_user_id">Recipient's User ID:</label>
        <input type="number" name="recipient_user_id" required><br><br>
        
        <label for="amount">Amount to Transfer:</label>
        <input type="number" name="amount" step="0.01" min="1" required><br><br>
        
        <button type="submit">Transfer</button><br><br>
        <a href="operations.jsp">Back to Operations</a>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            int recipientId = Integer.parseInt(request.getParameter("recipient_user_id"));
            double transferAmount = Double.parseDouble(request.getParameter("amount"));

            if (senderId == recipientId) {
                out.println("<p style='color:red;'>You cannot transfer money to yourself.</p>");
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");
                    conn.setAutoCommit(false); // Start transaction

                    // Check sender's balance
                    String checkBalanceQuery = "SELECT balance FROM users WHERE user_id = ?";
                    PreparedStatement checkBalanceStmt = conn.prepareStatement(checkBalanceQuery);
                    checkBalanceStmt.setInt(1, senderId);
                    ResultSet senderRs = checkBalanceStmt.executeQuery();

                    if (senderRs.next()) {
                        double senderBalance = senderRs.getDouble("balance");

                        if (transferAmount > senderBalance) {
                            out.println("<p style='color:red;'>Insufficient balance. Please try again.</p>");
                        } else {
                            // Check if recipient exists
                            String checkRecipientQuery = "SELECT user_id FROM users WHERE user_id = ?";
                            PreparedStatement checkRecipientStmt = conn.prepareStatement(checkRecipientQuery);
                            checkRecipientStmt.setInt(1, recipientId);
                            ResultSet recipientRs = checkRecipientStmt.executeQuery();

                            if (recipientRs.next()) {
                                // Deduct amount from sender's balance
                                String deductSenderQuery = "UPDATE users SET balance = balance - ? WHERE user_id = ?";
                                PreparedStatement deductSenderStmt = conn.prepareStatement(deductSenderQuery);
                                deductSenderStmt.setDouble(1, transferAmount);
                                deductSenderStmt.setInt(2, senderId);
                                deductSenderStmt.executeUpdate();

                                // Add amount to recipient's balance
                                String addRecipientQuery = "UPDATE users SET balance = balance + ? WHERE user_id = ?";
                                PreparedStatement addRecipientStmt = conn.prepareStatement(addRecipientQuery);
                                addRecipientStmt.setDouble(1, transferAmount);
                                addRecipientStmt.setInt(2, recipientId);
                                addRecipientStmt.executeUpdate();

                                // Log transaction for sender
                                String logSenderTransactionQuery = "INSERT INTO transactions (user_id, transaction_type, amount, description) VALUES (?, 'transfer out', ?, ?)";
                                PreparedStatement logSenderTransactionStmt = conn.prepareStatement(logSenderTransactionQuery);
                                logSenderTransactionStmt.setInt(1, senderId);
                                logSenderTransactionStmt.setDouble(2, transferAmount);
                                logSenderTransactionStmt.setString(3, "Transfer to User ID " + recipientId);
                                logSenderTransactionStmt.executeUpdate();

                                // Log transaction for recipient
                                String logRecipientTransactionQuery = "INSERT INTO transactions (user_id, transaction_type, amount, description) VALUES (?, 'transfer in', ?, ?)";
                                PreparedStatement logRecipientTransactionStmt = conn.prepareStatement(logRecipientTransactionQuery);
                                logRecipientTransactionStmt.setInt(1, recipientId);
                                logRecipientTransactionStmt.setDouble(2, transferAmount);
                                logRecipientTransactionStmt.setString(3, "Transfer from User ID " + senderId);
                                logRecipientTransactionStmt.executeUpdate();

                                conn.commit(); // Commit transaction

                                out.println("<p style='color:white;'><h2>Transfer successful! Amount: " + transferAmount + " to User ID: " + recipientId + "</h2></p>");
                            } else {
                                out.println("<p style='color:red;'>Recipient User ID does not exist. Please try again.</p>");
                            }
                        }
                    } else {
                        out.println("<p style='color:red;'>Error fetching your balance. Please try again.</p>");
                    }

                    conn.setAutoCommit(true); // End transaction
                    senderRs.close();
                    checkBalanceStmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                }
            }
        }
    %>

    <br>
    
</body>
</html>
