<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("admin_id") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Add New Customer</title>
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
            background-image: url('add_customer.jpg'); /* Replace with your background image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            backdrop-filter: blur(3px);
        }

        h2 {
            text-align: center;
            color: black;
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

        input[type="text"], input[type="email"], input[type="number"] {
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
            font-size: 20px;
            text-align: center;
            margin-top: 20px;
            color: #e90707; /* Red text for feedback messages */
        }

        #myimage {
            border-radius: 50%;
            /* max-width: 100%;
            height: auto; */
            width: 150px;
            height: 150px;
            margin-top: 20px;
            margin-bottom: 5px;
            margin-left: 120px;
        }
        a.button {
            display: flex;
            justify-content: center;
            padding: 8px 20px;
            margin-top:10px;
            font-size: 13px;
            color: #ffffff;
            background-color: #0056b3; /* Button background color */
            text-decoration: none;
            border-radius: 5px;
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
    <form action="add_customer.jsp" method="post">
        <image id="myimage" src="rguktimage1.jpeg"></image>
        <h2>Add New Customer</h2>
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required>
        
        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required>
        
        <label for="balance">Initial Balance:</label>
        <input type="number" name="balance" id="balance" min="0" required>
        
        <button type="submit">Add Customer</button><br><br>
        <a class="button" href="admin_dashboard.jsp">Go back</a>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String username = request.getParameter("username").trim();
            String email = request.getParameter("email").trim();
            double balance = Double.parseDouble(request.getParameter("balance"));

            if (username.isEmpty() || email.isEmpty() || balance < 0) {
                out.println("<p>Invalid input. Please check all fields and try again.</p>");
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                    String query = "INSERT INTO users (username, password, email, balance) VALUES (?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, username);
                    pstmt.setString(2, "Password");
                    pstmt.setString(3, email);
                    pstmt.setDouble(4, balance);
                    pstmt.executeUpdate();

                    out.println("<p style='color:green;'>Customer added successfully!</p>");
                    pstmt.close();
                    conn.close();
                } catch (SQLIntegrityConstraintViolationException e) {
                    out.println("<p>Error: Email or Username already exists.</p>");
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
</body>
</html>
