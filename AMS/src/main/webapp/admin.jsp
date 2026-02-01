<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .navbar {
            background-color: #003c71;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .logo {
            display: flex;
            align-items: center;
        }
        .logo img {
            height: 40px;
            margin-right: 10px;
        }
        .logo h1 {
            margin: 0;
            font-size: 1.5rem;
        }
        .nav-links {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .nav-links li {
            margin-left: 20px;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }
        .sidebar {
            position: fixed;
            left: 0;
            top: 70px;
            width: 250px;
            height: calc(100vh - 70px);
            background-color: white;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            z-index: 100;
        }
        .sidebar.collapsed {
            left: -250px;
        }
        .sidebar-menu {
            list-style: none;
            padding: 20px 0;
            margin: 0;
        }
        .sidebar-menu li {
            padding: 10px 20px;
            border-bottom: 1px solid #eee;
        }
        .sidebar-menu li a {
            color: #333;
            text-decoration: none;
            display: block;
        }
        .sidebar-menu li a:hover {
            color: #003c71;
            background-color: #f0f0f0;
        }
        .sidebar-menu li.active a {
            color: #003c71;
            font-weight: bold;
            border-left: 4px solid #003c71;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: all 0.3s ease;
        }
        .main-content.expanded {
            margin-left: 0;
        }
        .toggle-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .card h3 {
            margin-top: 0;
            color: #003c71;
        }
        .card p {
            color: #666;
        }
        .action-btn {
            display: inline-block;
            padding: 8px 15px;
            margin: 5px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
            font-weight: 500;
            text-align: center;
        }
        .btn-primary {
            background-color: #003c71;
        }
        .btn-primary:hover {
            background-color: #002a50;
        }
        .btn-success {
            background-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .section-title {
            color: #003c71;
            border-bottom: 2px solid #003c71;
            padding-bottom: 10px;
            margin-top: 30px;
        }
        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <div class="logo">
            <img src="img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo">
            <h1>Admin Dashboard</h1>
        </div>
        <ul class="nav-links">
            <li><a href="#"><i class="fas fa-bell"></i></a></li>
            <li><a href="#"><i class="fas fa-envelope"></i></a></li>
            <li><button class="logout-btn">Logout</button></li>
        </ul>
    </div>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <ul class="sidebar-menu">
            <li class="active"><a href="#"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="#passenger-section"><i class="fas fa-users"></i> Passenger Management</a></li>
            <li><a href="#pilot-section"><i class="fas fa-user-tie"></i> Pilot Management</a></li>
            <li><a href="#"><i class="fas fa-plane"></i> Flight Management</a></li>
            <li><a href="#"><i class="fas fa-calendar-alt"></i> Schedule Management</a></li>
            <li><a href="#"><i class="fas fa-chart-bar"></i> Reports</a></li>
            <li><a href="#"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content" id="main-content">
        <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
        
        <h2 class="section-title">Dashboard Overview</h2>
        
        <div class="dashboard-cards">
            <div class="card">
                <h3>Total Passengers</h3>
                <%
                    int passengerCount = 0;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM passengers");
                        if(rs.next()) {
                            passengerCount = rs.getInt("count");
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
                <p><%= passengerCount %></p>
                <a href="#passenger-section" class="action-btn btn-primary">Manage Passengers</a>
            </div>
            <div class="card">
                <h3>Total Pilots</h3>
                <%
                    int pilotCount = 0;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM Pilots");
                        if(rs.next()) {
                            pilotCount = rs.getInt("count");
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
                <p><%= pilotCount %></p>
                <a href="#pilot-section" class="action-btn btn-primary">Manage Pilots</a>
            </div>
            <div class="card">
                <h3>Active Flights</h3>
                <%
                    int flightCount = 0;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM FlightDetails WHERE status = 'On Time' OR status = 'Delayed'");
                        if(rs.next()) {
                            flightCount = rs.getInt("count");
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
                <p><%= flightCount %></p>
                <a href="ourFlights.jsp" class="action-btn btn-primary">View Flights</a>
            </div>
        </div>

        <!-- Passenger Management Section -->
        <h2 class="section-title" id="passenger-section">Passenger Management</h2>
        <div class="card">
            <h3>Passenger Operations</h3>
            <div>
                <a href="searchPassenger.jsp" class="action-btn btn-primary">Search Passengers</a>
                <a href="passenger.jsp" class="action-btn btn-success">Add New Passenger</a>
                <a href="passengerReport.jsp" class="action-btn btn-primary">Generate Report</a>
                <a href="passengerView.jsp" class="action-btn btn-primary">View All Passengers</a>
            </div>
            
            <!-- Passenger Activity -->
            <div style="margin-top: 20px;">
                <h4>Recent Passenger Activity</h4>
                <%
                    int newPassengersToday = 0;
                    int recentCheckIns = 0;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                        
                        // Get new passengers registered today
                        Statement stmt1 = conn.createStatement();
                        ResultSet rs1 = stmt1.executeQuery("SELECT COUNT(*) AS count FROM passengers WHERE DATE(registration_date) = CURDATE()");
                        if(rs1.next()) {
                            newPassengersToday = rs1.getInt("count");
                        }
                        rs1.close();
                        stmt1.close();
                        
                        // Get recent check-ins (last hour)
                        Statement stmt2 = conn.createStatement();
                        ResultSet rs2 = stmt2.executeQuery("SELECT COUNT(*) AS count FROM checkins WHERE checkin_time >= NOW() - INTERVAL 1 HOUR");
                        if(rs2.next()) {
                            recentCheckIns = rs2.getInt("count");
                        }
                        rs2.close();
                        stmt2.close();
                        
                        conn.close();
                    } catch(Exception e) {
                        // If checkins table doesn't exist, just show 0
                        recentCheckIns = 0;
                    }
                %>
                <p><%= newPassengersToday %> new passengers registered today</p>
                <p><%= recentCheckIns %> check-ins completed in last hour</p>
            </div>
        </div>

        <!-- Pilot Management Section -->
        <h2 class="section-title" id="pilot-section">Pilot Management</h2>
        <div class="card">
            <h3>Pilot Operations</h3>
            <div>
                <a href="searchPilot.jsp" class="action-btn btn-primary">Search Pilots</a>
                <a href="pilotDetails.jsp" class="action-btn btn-success">Add New Pilot</a>
                <a href="pilotReport.jsp" class="action-btn btn-primary">Generate Report</a>
                <a href="pilotView.jsp" class="action-btn btn-primary">View All Pilots</a>
            </div>
            
            <!-- Pilot Availability -->
            <div style="margin-top: 20px;">
                <h4>Pilot Availability</h4>
                <%
                    int availablePilots = 0;
                    int pilotsOnLeave = 0;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                        
                        // Get available pilots (assuming all are available if no status field)
                        Statement stmt1 = conn.createStatement();
                        ResultSet rs1 = stmt1.executeQuery("SELECT COUNT(*) AS count FROM Pilots");
                        if(rs1.next()) {
                            availablePilots = rs1.getInt("count");
                        }
                        rs1.close();
                        stmt1.close();
                        
                        // Get pilots on leave (assuming you might add this later)
                        pilotsOnLeave = 0; // Currently no leave status in your schema
                        
                        conn.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
                <p><%= availablePilots %> pilots currently available</p>
                <p><%= pilotsOnLeave %> pilots on leave</p>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('expanded');
        }

        // Set active menu item
        document.querySelectorAll('.sidebar-menu li').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.sidebar-menu li').forEach(i => {
                    i.classList.remove('active');
                });
                this.classList.add('active');
            });
        });

        // Logout button functionality
        document.querySelector('.logout-btn').addEventListener('click', function() {
            if(confirm('Are you sure you want to logout?')) {
                window.location.href = 'logout.jsp';
            }
        });
    </script>
</body>
</html>