<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Search Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
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
        .navbar img {
            height: 50px;
            margin-right: 10px;
        }
        .navbar ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            flex-grow: 1;
        }
        .navbar ul li {
            padding: 15px;
        }
        .navbar ul li a {
            color: #003c71;
            text-decoration: none;
            padding: 10px 15px;
            display: block;
        }
        .active {
            border-bottom: 2px solid #ff5c00;
        }
        .sidebar {
            position: fixed;
            left: -250px;
            top: 0;
            width: 250px;
            height: 100%;
            background-color: white;
            border-right: 1px solid #e0e0e0;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.5);
            transition: left 0.3s ease;
            z-index: 1000;
        }
        .sidebar.active {
            left: 0;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 20px;
            margin: 0;
        }
        .sidebar ul li {
            margin-bottom: 10px;
        }
        .sidebar ul li a {
            color: #003c71;
            text-decoration: none;
            padding: 12px 15px;
            display: block;
        }
        .sidebar ul li a:hover {
            background-color: #f0f0f0;
        }
        .close-btn {
            cursor: pointer;
            font-size: 24px;
            padding: 10px;
            position: absolute;
            top: 10px;
            right: 10px;
            color: #003c71;
        }
        .results-container {
            margin: 20px;
            padding: 20px;
        }
        .results-header {
            font-size: 24px;
            color: #003c71;
            margin-bottom: 20px;
        }
        .flight-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .flight-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .flight-number {
            font-weight: bold;
            color: #003c71;
        }
        .flight-status {
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
        }
        .status-on-time {
            background-color: #d4edda;
            color: #155724;
        }
        .status-delayed {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .flight-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .flight-times {
            text-align: center;
        }
        .flight-time {
            font-size: 18px;
            font-weight: bold;
        }
        .flight-date {
            font-size: 14px;
            color: #666;
        }
        .flight-route {
            text-align: center;
            flex-grow: 1;
        }
        .flight-route-arrow {
            font-size: 20px;
            color: #003c71;
        }
        .flight-duration {
            font-size: 14px;
            color: #666;
        }
        .flight-aircraft {
            font-size: 14px;
            color: #666;
        }
        .select-flight-btn {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }
        .select-flight-btn:hover {
            background-color: #00274d;
        }
        .no-results {
            text-align: center;
            padding: 40px;
            font-size: 18px;
            color: #666;
        }
        .hamburger {
            cursor: pointer;
            height: 24px;
            margin-right: 20px;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="logo-container">
            <img src="img/humburgerIcon.png" alt="Menu" class="hamburger" onclick="toggleSidebar()">
            <img src="img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo">
        </div>
        <ul id="navLinks">
            <li><a href="flightBooking.jsp">Book a flight</a></li>
            <li><a href="checkIn.jsp">Check-in</a></li>
            <li><a href="myBookings.jsp">My Bookings</a></li>
            <li><a href="Information.jsp">Information</a></li>
            <li><a href="contactUs.jsp">Contact us</a></li>
        </ul>
        <a href="login.jsp" class="login">Log in</a>
    </div>

    <div class="sidebar" id="sidebar">
        <span class="close-btn" onclick="toggleSidebar()">✖</span>
        <ul>
            <li><a href="flightBooking.jsp">Book a flight</a></li>
            <li><a href="checkIn.jsp">Check-in</a></li>
            <li><a href="myBookings.jsp">My Bookings</a></li>
            <li><a href="Information.jsp">Information</a></li>
            <li><a href="ourFlights.jsp">Our flights</a></li>
            <li><a href="flightStatus.jsp">Flight status</a></li>
            <li><a href="businessServices.jsp">Business Services</a></li>
            <li><a href="travelDestinations.jsp">Travel destinations</a></li>
            <li><a href="contactUs.jsp">Contact us</a></li>
        </ul>
        <div class="divider"></div>
    </div>

    <div class="results-container">
        <div class="results-header">Available Flights</div>
        
        <%-- [Previous JSP code for database connection and query remains the same] --%>
        <%
        // Get search parameters from the request
        String departure = request.getParameter("departure");
        String arrival = request.getParameter("arrival");
        String departureDate = request.getParameter("departureDate");
        String returnDate = request.getParameter("returnDate");
        String tripType = request.getParameter("tripType");
        String cabinClass = request.getParameter("cabinClass");
        String adults = request.getParameter("adults");
        String children = request.getParameter("children");
        
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/your_database_name";
        String username = "your_username";
        String password = "your_password";
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish connection
            conn = DriverManager.getConnection(url, username, password);
            
            // Create SQL query based on search parameters
            String sql = "SELECT * FROM FlightDetails WHERE departure LIKE ? AND arrival LIKE ? AND flight_date = ?";
            
            // If round trip, we should also search for return flights
            if (tripType.equals("round") && returnDate != null && !returnDate.isEmpty()) {
                sql += " UNION SELECT * FROM FlightDetails WHERE departure LIKE ? AND arrival LIKE ? AND flight_date = ?";
            }
            
            // Prepare statement
            PreparedStatement pstmt = conn.prepareStatement(sql);
            
            // Set parameters for departure flight
            pstmt.setString(1, "%" + departure + "%");
            pstmt.setString(2, "%" + arrival + "%");
            pstmt.setString(3, departureDate);
            
            // If round trip, set parameters for return flight
            if (tripType.equals("round") && returnDate != null && !returnDate.isEmpty()) {
                pstmt.setString(4, "%" + arrival + "%");
                pstmt.setString(5, "%" + departure + "%");
                pstmt.setString(6, returnDate);
            }
            
            // Execute query
            rs = pstmt.executeQuery();
            
            boolean hasResults = false;
            
            while (rs.next()) {
                hasResults = true;
                String flightNumber = rs.getString("flight_number");
                String flightDate = rs.getString("flight_date");
                String flightDeparture = rs.getString("departure");
                String flightArrival = rs.getString("arrival");
                String depTime = rs.getString("departure_time");
                String arrTime = rs.getString("arrival_time");
                String aircraft = rs.getString("aircraft");
                String status = rs.getString("status");
                
                // Format status for display
                String statusClass = "";
                switch(status.toLowerCase()) {
                    case "on time":
                        statusClass = "status-on-time";
                        break;
                    case "delayed":
                        statusClass = "status-delayed";
                        break;
                    case "cancelled":
                        statusClass = "status-cancelled";
                        break;
                }
        %>
        
        <div class="flight-card">
            <div class="flight-header">
                <span class="flight-number"><%= flightNumber %></span>
                <span class="flight-status <%= statusClass %>"><%= status %></span>
            </div>
            <div class="flight-details">
                <div class="flight-times">
                    <div class="flight-time"><%= depTime %></div>
                    <div class="flight-date"><%= flightDate %></div>
                </div>
                <div class="flight-route">
                    <div><%= flightDeparture %></div>
                    <div class="flight-route-arrow">→</div>
                    <div><%= flightArrival %></div>
                </div>
                <div class="flight-times">
                    <div class="flight-time"><%= arrTime %></div>
                    <div class="flight-date"><%= flightDate %></div>
                </div>
            </div>
            <div class="flight-footer">
                <div class="flight-aircraft">Aircraft: <%= aircraft %></div>
                <button class="select-flight-btn" onclick="selectFlight('<%= flightNumber %>', '<%= flightDate %>')">Select Flight</button>
            </div>
        </div>
        
        <%
            }
            
            if (!hasResults) {
        %>
            <div class="no-results">
                No flights found matching your search criteria. Please try different dates or routes.
            </div>
        <%
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        %>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }
        
        function selectFlight(flightNumber, flightDate) {
            // Here you would typically redirect to a booking page or store the selection
            alert("Selected flight: " + flightNumber + " on " + flightDate);
            // You can redirect to a booking page with parameters:
            // window.location.href = "booking.jsp?flightNumber=" + flightNumber + "&flightDate=" + flightDate;
        }
    </script>

</body>
</html>