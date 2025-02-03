<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("user_id");
    String message = "";
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            message = "<p style='color:red;'>New passwords do not match!</p>";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                // Fetch current password
                String checkPasswordQuery = "SELECT password FROM users WHERE user_id = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkPasswordQuery);
                checkStmt.setInt(1, userId);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");

                    if (!dbPassword.equals(oldPassword)) {
                        message = "<p style='color:red;'>Incorrect old password!</p>";
                    } else {
                        // Update password
                        String updatePasswordQuery = "UPDATE users SET password = ? WHERE user_id = ?";
                        PreparedStatement updateStmt = conn.prepareStatement(updatePasswordQuery);
                        updateStmt.setString(1, newPassword);
                        updateStmt.setInt(2, userId);
                        updateStmt.executeUpdate();

                        message = "<p style='color:green;'>Password changed successfully!</p>";
                        updateStmt.close();
                    }
                } else {
                    message = "<p style='color:red;'>User not found!</p>";
                }

                rs.close();
                checkStmt.close();
                conn.close();
            } catch (Exception e) {
                message = "<p style='color:red;'>Database Error: " + e.getMessage() + "</p>";
            }
        }
    }
%>

<html>
<head>
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            
            background-color: #2c3e50;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        form {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
        }
        input, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        button {
            background: #0056b3;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background: #74b9ff;
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

    </style>
</head>
<body>
    <form method="post">
        <h2>Change Password</h2>
        <label for="oldPassword">Old Password:</label>
        <input type="password" name="oldPassword" required>

        <label for="newPassword">New Password:</label>
        <input type="password" name="newPassword" required>

        <label for="confirmPassword">Confirm New Password:</label>
        <input type="password" name="confirmPassword" required>

        <button type="submit">Change Password</button>
        <a class="button" href="operations.jsp">Go back</a>
        <%= message %>
    </form>
</body>
</html>
