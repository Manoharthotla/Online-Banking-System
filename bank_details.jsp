<html>
<head>
    <title>Bank Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            min-height: 100vh;
            background-image: url('bank.png'); /* Replace with your background image path */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        h2 {
            color:blueviolet;
            text-align: center;
            margin-top: 40px;
            font-size: 32px;
        }

        .bank-card {
            background-color: rgba(255, 255, 255, 0.8); /* Slightly adjusted for better contrast */
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 85%;
            max-width: 900px;
            margin-top: 40px;
            padding: 30px;
            font-size: 18px;
            color: #3e566d;
            backdrop-filter: blur(10px); /* Reduced blur for better readability */
            transition: backdrop-filter 0.3s ease; /* Smooth transition effect */
        }

        .bank-card h3 {
            color: #2887c6;
            margin-bottom: 12px;
            font-size: 22px;
        }

        .bank-card p {
            font-size: 18px;
            margin: 10px 0;
            line-height: 1.6;
        }

        .bank-details-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-weight: bold;
            color: blueviolet;
        }

        .additional-info {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background-color: #ecf0f1;
            border-radius: 8px;
            margin-top: 20px;
        }

        .additional-info h4 {
            margin: 0;
            font-size: 20px;
            color: #3498db;
        }

        .additional-info p {
            margin: 0;
            color: #2c3e50;
        }

        .back-button {
            margin-top: 30px;
            text-align: center;
        }

        a.button {
            display: inline-block;
            padding: 12px 24px;
            font-size: 18px;
            color: #ffffff;
            background-color: #3498db;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        a.button:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        a.button:active {
            background-color: #1c5987;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .bank-card {
                width: 95%;
                padding: 20px;
            }

            h2 {
                font-size: 28px;
            }

            .bank-card h3 {
                font-size: 20px;
            }

            .additional-info {
                flex-direction: column;
                align-items: center;
            }

            .additional-info div {
                margin-bottom: 15px;
            }
        }
    </style>
</head>
<body>
    <h2>Complete Bank Details</h2>
    <div class="bank-card">
        <!-- Bank Information -->
        <div class="bank-details-section">
            <h3>Bank Overview</h3>
            <p><span class="section-title">Bank Name:</span> RGUKT Bank</p>
            <p><span class="section-title">Branch Location:</span> 123, RGUKT Campus, Basar, Telangana, 12345</p>
            <p><span class="section-title">Contact Number:</span> 8888888888</p>
            <p><span class="section-title">Established Year:</span> 2020</p>
            <p><span class="section-title">SWIFT Code:</span> ABCN12345</p>
            <p><span class="section-title">IFSC Code:</span> ABCD12345</p>
        </div>

        <div class="bank-details-section">
            <h3>Key Financials</h3>
            <p><span class="section-title">Total Deposits:</span> 50,00,000.00</p>
            <p><span class="section-title">Total Loans:</span> 20,00,000.00</p>
            <p><span class="section-title">Current Assets:</span> 60,00,000.00</p>
            <p><span class="section-title">Net Profit (Annual):</span> 5,00,000.00</p>
        </div>

        <div class="bank-details-section">
            <h3>Management</h3>
            <p><span class="section-title">CEO:</span> Jhon Doe</p>
            <p><span class="section-title">CFO:</span> Jane Smith</p>
            <p><span class="section-title">COO:</span> Mark Taylor</p>
        </div>

        <div class="additional-info">
            <div>
                <h4>Customers</h4>
                <p>Total Customers: 3500</p>
            </div>
            <div>
                <h4>Branches</h4>
                <p>25 Branches Nationwide</p>
            </div>
            <div>
                <h4>Security Rating</h4>
                <p>AAA (Highest Rating)</p>
            </div>
        </div>

    </div>

    <div class="back-button">
        <a class="button" href="admin_dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
