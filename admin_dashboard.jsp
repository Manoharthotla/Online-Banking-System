<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f8fb;
            color: #333;
        }

        /* Dashboard Layout */
        .dashboard-container {
            display: flex;
            height: 100vh; /* Full viewport height */
        }

        /* Sidebar Styling */
        .sidebar {
            width: 250px;
            background-color: #0056b3; /* Dark blue sidebar */
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px 10px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar h2 {
            font-size: 20px;
            margin-bottom: 20px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            margin: 10px 0;
            border-radius: 5px;
            width: 100%;
            text-align: center;
            transition: background 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #004494; /* Slightly darker blue on hover */
        }

        /* Content Area Styling */
        .content {
            flex: 1;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: inset 0 1px 5px rgba(0, 0, 0, 0.1);
        }

        .content h2 {
            color: #0056b3;
        }

        .content p {
            font-size: 16px;
            margin: 10px 0;
        }

        .admin-details {
            font-size: 18px;
            margin-top: 20px;
        }

        .admin-details span {
            font-weight: bold;
        }

    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <a href="add_customer.jsp">Add New Customer</a>
            <a href="remove_customer.jsp">Remove Customer</a>
            <a href="bank_details.jsp">View Bank Details</a>
            <a href="admin_logout.jsp">Logout</a>
        </div>

        <!-- Content Area -->
        <div class="content">
            <h2>Admin Details</h2>

            <% 
                // Check if the session has an admin user
               
                if (session != null && session.getAttribute("admin_id") != null) {
                    int adminId = (int) session.getAttribute("admin_id");
                    
                    // Database connection
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");

                        // Query to fetch admin details
                        String query = "SELECT * FROM admin WHERE admin_id = ?";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setInt(1, adminId);
                        ResultSet rs = pstmt.executeQuery();

                        if (rs.next()) {
                            // Display admin details
                            String adminName = rs.getString("username");
                            String adminEmail = rs.getString("email");
                            String adminPhone = rs.getString("phone_number");
                            
                            out.println("<div class='admin-details'>");
                            out.println("<p><span>Name:</span> " + adminName + "</p>");
                            out.println("<p><span>Email:</span> " + adminEmail + "</p>");
                            out.println("<p><span>Phone:</span> " + adminPhone + "</p>");
                            out.println("</div>");
                        } else {
                            out.println("<p>No admin details found.</p>");
                        }

                        rs.close();
                        pstmt.close();
                        conn.close();

                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                } else {
                    response.sendRedirect("admin_login.jsp"); // Redirect if not logged in
                }

            %>
            <div class="dashboard-widgets">
                <h3>Quick Stats</h3>
                <ul>
                    <li>Total Customers: 
                        <% 
                            try {
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");
                                String customerCountQuery = "SELECT COUNT(*) AS total FROM users";
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery(customerCountQuery);
                                if (rs.next()) {
                                    out.println(rs.getInt("total"));
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                out.println("N/A");
                            }
                        %>
                    </li>
                    <li>Total Bank Accounts: 
                        <% 
                            try {
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Banking", "manu", "Manu@0809");
                                String accountsCountQuery = "SELECT COUNT(*) AS total FROM users";
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery(accountsCountQuery);
                                if (rs.next()) {
                                    out.println(rs.getInt("total"));
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                out.println("N/A");
                            }
                        %>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
