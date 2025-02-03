<%@ page import="java.sql.*" %>
<%
    
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("user_id");
%>
<html>
<head>
    <title>Add Amount</title>
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
        a.button {
            display: flex;
            justify-content: center; /* Makes the anchor behave like a block element for padding */
            padding: 8px 20px; /* Add space inside the "button" */
        font-size: 14px; /* Adjust text size */
        color: #ffffff; /* Button text color */
        background-color:#0056b3;; /* Button background color */
        text-decoration: none; /* Remove the underline */
        border-radius: 5px; /* Rounded corners */
        text-align: center; /* Center the text */
        border: none; /* Remove any borders */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2); /* Optional: Add a shadow for a button-like effect */
        transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth hover effects */
        }

        a.button:hover {
        background-color: #0056b3; /* Darker blue on hover */
        transform: translateY(-2px); /* Slight "lift" effect on hover */
        }

        a.button:active {
        background-color: #003f7f; /* Even darker blue when pressed */
        transform: translateY(0); /* Reset the "lift" */
        }


        h2 {
            text-align: center;
            color:black; /* White text for contrast */
            margin-bottom: 20px;
        }

        form {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
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
            background-color: #28a745; /* Green button */
            color: #ffffff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #218838; /* Darker green on hover */
        }

        p {
            font-size: 30px;
            text-align: center;
            margin-top: 20px;
            color: #e90707; /* White text for feedback messages */
        }
        #myimage{
            border-radius: 50%;
            max-width: 100%; /* Ensure the image is responsive */
    height: auto; /* Maintain aspect ratio */
    margin-bottom: 20px;
    margin-left: 100px;
        }
    </style>
</head>
<body>

    
    
    <form action="addAmount.jsp" method="post">
        <image id="myimage" src="rguktimage1.jpeg"></image>
        <h2>Add Amount</h2>
        <label for="amount">Amount:</label>
        <input type="number" name="amount" step="0.01" required><br><br>
        <button type="submit">Add</button><br><br><br>
        <a class="button" href="operations.jsp">Go back to operations</a>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            double amount = Double.parseDouble(request.getParameter("amount"));

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                // Update balance
                String updateBalance = "UPDATE users SET balance = balance + ? WHERE user_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(updateBalance);
                pstmt.setDouble(1, amount);
                pstmt.setInt(2, userId);
                pstmt.executeUpdate();

                // Log transaction
                String logTransaction = "INSERT INTO transactions (user_id, transaction_type, amount, description) VALUES (?, 'credit', ?, 'Added to account')";
                PreparedStatement pstmt2 = conn.prepareStatement(logTransaction);
                pstmt2.setInt(1, userId);
                pstmt2.setDouble(2, amount);
                pstmt2.executeUpdate();

                out.println("<p><h2>Amount added successfully!</h2></p>");
                pstmt.close();
                pstmt2.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
