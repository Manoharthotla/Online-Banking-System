<html>
<head>
    <title>Welcome to MyBank</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #d8dbde;
            color: #333;
            background-image: url('ab3.jpeg'); /* Replace with your image path */
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                background-attachment: fixed;
                backdrop-filter: blur(2px); 
        }

        /* Header Section */
        .header {
            background-color: #0056b3;
            color: white;
            padding: 25px;
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            
        }

        /* Main Content */
        .main-content {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .main-content h2 {
            color: #0056b3;
            margin-bottom: 20px;
        }

        .main-content p {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        /* Buttons */
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .btn {
            background-color: #0056b3;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #004494;
        }

        /* Footer Section */
        .footer {
            text-align: center;
            margin-top: 40px;
            padding: 10px;
            background-color: hsl(210, 16%, 93%);
            color: #555;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <img src="rguktimage1.jpeg" alt="" style="width:5%;height:10%; border-radius:50%;"> &nbsp;&nbsp;
        Welcome to RGUKT BANK
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h2>About MyBank</h2>
        <p>
            At RGUKT Bank, we are committed to providing you with the best financial services. 
            Our mission is to simplify banking and empower you to achieve your financial goals. 
            With secure, fast, and reliable banking solutions, RGUKT Bank is here to make your life easier.
        </p>
        <p>
            Whether you're looking to manage your finances, explore loan options, or just need 
            a safe place for your money, RGUKT Bank is the partner you can trust.
        </p>

        <!-- Navigation Buttons -->
        <div class="btn-container">
            <a href="register.jsp" class="btn">User Registration</a>
            <a href="login.jsp" class="btn">User Login</a>
            <a href="admin_login.jsp" class="btn">Admin Login</a>
        </div>
    </div>

    <!-- Footer -->
    <!-- <div class="footer">
        © 2025 RGUKT Bank. All rights reserved.
    </div> -->
</body>
</html>
