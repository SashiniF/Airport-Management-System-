<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Passenger Registration</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-image: url('img/bg3.png');
            background-size: cover;
            overflow-x: hidden;
        }
        .navbar {
            background-color: white;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            padding: 10px 20px;
            z-index: 100;
        }
        .logo-container {
            display: flex;
            align-items: center;
        }
        .navbar img {
            height: 50px;
            margin-right: 10px;
        }
        .nav-links {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            flex-grow: 1;
        }
        .nav-links li {
            padding: 15px;
        }
        .nav-links a {
            text-decoration: none;
            color: #003c71;
            padding: 10px 15px;
            display: block;
            transition: all 0.3s ease;
        }
        .nav-links a:hover {
            background-color: rgba(0, 60, 113, 0.1);
            border-radius: 4px;
        }
        .container {
            max-width: 500px; 
            margin: 6px auto;
            padding: 30px; 
            background-color: rgba(255, 255, 255, 0.75);
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .title {
            color: #003366;
            font-size: 1.8rem;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%; 
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .submit-btn {
            background-color: #003c71;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .submit-btn:hover {
            background-color: #002a50;
        }
        /* Enhanced Sidebar Styles */
        .sidebar {
            position: fixed;
            left: -300px;
            top: 0;
            width: 300px;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.95);
            border-right: 1px solid #e0e0e0;
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.2);
            transition: left 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            z-index: 1000;
            backdrop-filter: blur(5px);
        }
        .sidebar.active {
            left: 0;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 60px 0 0 0;
            margin: 0;
        }
        .sidebar ul li {
            margin-bottom: 5px;
            padding: 0 20px;
        }
        .sidebar ul li a {
            color: #003c71;
            text-decoration: none;
            padding: 12px 15px;
            display: block;
            transition: all 0.3s ease;
            border-radius: 4px;
            font-weight: 500;
            position: relative;
        }
        .sidebar ul li a:hover {
            background-color: rgba(0, 60, 113, 0.1);
            transform: translateX(5px);
        }
        .sidebar ul li a:before {
            content: "→";
            position: absolute;
            left: 0;
            opacity: 0;
            transition: all 0.3s ease;
            color: #e63946;
        }
        .sidebar ul li a:hover:before {
            opacity: 1;
            left: 5px;
        }
        .sidebar ul li a.active {
            background-color: rgba(0, 60, 113, 0.1);
            border-left: 3px solid #e63946;
            color: #002a50;
            font-weight: 600;
        }
        .close-btn {
            cursor: pointer;
            font-size: 24px;
            padding: 15px;
            position: absolute;
            top: 10px;
            right: 10px;
            color: #003c71;
            transition: all 0.3s ease;
            background-color: rgba(0, 60, 113, 0.1);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .close-btn:hover {
            background-color: rgba(0, 60, 113, 0.2);
            transform: rotate(90deg);
        }
        /* Sidebar overlay */
        .sidebar-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }
        .sidebar-overlay.active {
            opacity: 1;
            visibility: visible;
        }
        .toggle-btn {
            cursor: pointer;
            margin-right: 15px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo-container">
            <img src="img/humburgerIcon.png" alt="Menu" class="toggle-btn" onclick="toggleSidebar()">
            <img src="${pageContext.request.contextPath}/img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo">
        </div>
        <ul class="nav-links" id="navLinks">
            <li><a href="flightBooking.jsp">Book a flight</a></li>
            <li><a href="checkIn.jsp">Check-in</a></li>
            <li><a href="myBookings.jsp">My Bookings</a></li>
            <li><a href="Information.jsp">Information</a></li>
            <li><a href="contactUs.jsp">Contact us</a></li>
        </ul>
        <a href="login.jsp" class="login-btn">Log in</a>
    </div>

    <div class="sidebar" id="sidebar">
        <span class="close-btn" onclick="toggleSidebar()">✖</span>
        <ul>
            <li><a href="flightBooking.jsp" onclick="setActive(this)">Book a flight</a></li>
            <li><a href="checkIn.jsp" onclick="setActive(this)">Check-in</a></li>
            <li><a href="myBookings.jsp" onclick="setActive(this)">My Bookings</a></li>
            <li><a href="Information.jsp" onclick="setActive(this)">Information</a></li>
            <li><a href="ourFlights.jsp" onclick="setActive(this)">Our flights</a></li>
            <li><a href="flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
    </div>

    <!-- Sidebar overlay -->
    <div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

    <div class="container">
        <h1 class="title">Passenger Registration</h1>

        <%
            String passengerID = "PN001"; // Default value
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                stmt = conn.createStatement();
                
                // Query to get the last Passenger ID
                String query = "SELECT passengerID FROM passengers ORDER BY passengerID DESC LIMIT 1";
                rs = stmt.executeQuery(query);
                
                if (rs.next()) {
                    String lastID = rs.getString("passengerID");
                    int idNumber = Integer.parseInt(lastID.substring(2)); // Extract the number
                    idNumber++; // Increment the ID number
                    passengerID = "PN" + String.format("%03d", idNumber); // Format to PN001, PN002, etc.
                }
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error retrieving Passenger ID: " + e.getMessage() + "</p>");
            } catch (Exception e) {
                out.println("<p style='color:red;'>An unexpected error occurred: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>

        <form action="registerPassenger.jsp" method="post">
            <div class="form-group">
                <label for="passengerID">Passenger ID</label>
                <input type="text" id="passengerID" name="passengerID" value="<%= passengerID %>" readonly>
            </div>

            <div class="form-group">
                <label for="passengerName">Name</label>
                <input type="text" id="passengerName" name="passengerName" required>
            </div>
            <div class="form-group">
                <label for="passportNumber">Passport Number</label>
                <input type="text" id="passportNumber" name="passportNumber" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone" required>
            </div>
            <button type="submit" class="submit-btn">Register Passenger</button>
        </form>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
            
            // Prevent scrolling when sidebar is open
            if (sidebar.classList.contains('active')) {
                document.body.style.overflow = 'hidden';
            } else {
                document.body.style.overflow = 'auto';
            }
        }
        
        // Close sidebar when clicking on a link
        document.querySelectorAll('.sidebar a').forEach(link => {
            link.addEventListener('click', () => {
                toggleSidebar();
            });
        });
    </script>
</body>
</html>