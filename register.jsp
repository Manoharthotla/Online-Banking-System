<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
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
            background-image: url("ab3.jpeg");
            background-size: cover; /* Ensures the image covers the entire background */
            background-position: center; /* Centers the image */
            background-repeat: no-repeat; /* Prevents the image from repeating */
            background-attachment: fixed;
            backdrop-filter: blur(3px);        
            
        }

        h1 {
            color: black;
            font-size: 2.5em;
            text-align: center;
            margin-bottom: 10px; /* Adds space between the title and the form */
        }

        h2 {
            text-align: center;
            color: #333333; /* Dark text for contrast */
        }

        form {
            background-color: #ffffff; /* White form background */
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
        }

        label {
            font-weight: bold;
            color: #555555;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            font-size: 14px;
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
            color: #333333;
            font-size: 20px;
            color:maroon;
        }

        p a {
            color:rgb(17, 0, 128);
            text-decoration: none;
            font-size: 20px;
        }

        p a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
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
    <!-- Title Section -->
    <h1>Welcome to Rgukt Basar Bank</h1><br><br>
    
    <!-- Registration Form -->
    <form action="register.jsp" method="post">
        <img id="myimage" src="rguktimage1.jpeg">
        <h2>User Registration</h2>
        
        <label for="username">Username:</label>
        <input type="text" name="username" required><br>
        
        <label for="email">Email:</label>
        <input type="email" name="email" required><br>
        
        <label for="password">Password:</label>
        <input type="password" name="password" required><br>
        
        <label for="confirm_password">Confirm Password:</label>
        <input type="password" name="confirm_password" required><br>
        
        <button type="submit">Register</button><br><br>
        <p>If you have an Account  <a href="login.jsp">Login</a></p>
    </form>


    <!-- JSP Logic -->
    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");

            if (!password.equals(confirmPassword)) {
                out.println("<p class='error-message'>Passwords do not match. Please try again.</p>");
            } else {
                try {
                    // Load the MySQL driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                    String query = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password); // Ideally hash the password before storing it.
                    pstmt.setString(3, email);

                    int rows = pstmt.executeUpdate();

                    if (rows > 0) {
                        out.println("<p>Registration successful! <a href='login.jsp'>Login Here</a></p>");
                    } else {
                        out.println("<p>Registration failed. Please try again.</p>");
                    }

                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
</body>
</html>
