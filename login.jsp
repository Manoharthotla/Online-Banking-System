<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <title>Login</title>
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
                background-image: url('ab3.jpeg'); /* Replace with your image path */
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                background-attachment: fixed;
                backdrop-filter: blur(3px); 
                
            }
    
            h2 {
                text-align: center;
                color:black; /* White text for contrast */
            }
    
            form {
                background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
                padding: 20px 30px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                max-width: 400px;
                width: 100%;
            }
    
            label {
                font-weight: bold;
                color: #333333;
            }
    
            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin: 5px 0 15px;
                border: 1px solid #cccccc;
                border-radius: 4px;
                font-size: 14px;
            }
            h1 {
            color: black;
            font-size: 2.5em;
            text-align: center;
            margin-bottom: 10px; /* Adds space between the title and the form */
        }
    
            button {
                background-color: #007BFF; /* Blue button */
                color: #ffffff;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                width: 100%;
            }
    
            button:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }
    
            p {
                text-align: center;
                color: #ff0000; /* Red text for error messages */
            }
    
            p a {
                color: #007BFF;
                text-decoration: none;
            }
    
            p a:hover {
                text-decoration: underline;
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
    <h1>Welcome to Rgukt Basar Bank</h1><br><br>
    <form action="login.jsp" method="post">
        <img id="myimage" src="rguktimage1.jpeg">
        <h2>User Login</h2>
        <label for="username">Username:</label>
        <input type="text" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" name="password" required><br><br>
        <button type="submit">Login</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                String query = "SELECT user_id FROM users WHERE username = ? AND password = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                pstmt.setString(2, password); // Validate hashed password if hashing is used.

                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    session.setAttribute("user_id", userId);
                    response.sendRedirect("operations.jsp"); // Redirect to welcome page.
                } else {
                    out.println("<p>Invalid username or password. Please try again.</p>");
                }

                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
