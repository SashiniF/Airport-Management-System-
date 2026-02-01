<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Flight Status</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-image: url('img/bg.png');
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

        .nav-links a.active {
            border-bottom: 2px solid red; /* Add red underline */
        }

        .container {
            max-width: 800px;
            margin: 5px auto;
            padding: 20px;
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

        .flight-details {
            margin-top: 10px;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            padding-top: 10px;
        }

        .flight-details p {
            margin-bottom: 5px;
            font-size: 1rem;
            background-color: rgba(255, 255, 255, 0.7);
            padding: 6px 10px;
            border-radius: 4px;
        }

        .error-message {
            color: #d9534f;
            text-align: center;
            margin-top: 10px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 10px;
            border-radius: 4px;
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

        .toggle-btn {
            cursor: pointer;
            margin-left: auto;
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
        <span class="close-btn" onclick="toggleSidebar()">&#10005;</span>
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
    </div>

    <div class="container">
        <h1 class="title">Search for a flight</h1>

        <form>
            <input type="text" name="flightNumber" placeholder="Enter flight No" value="<%= request.getParameter("flightNumber") != null ? request.getParameter("flightNumber") : "" %>">
            <button type="submit" class="search-btn">Search flights</button>
        </form>

        <div class="flight-details">
            <%
                String flightNumber = request.getParameter("flightNumber");
                if (flightNumber != null && !flightNumber.trim().isEmpty()) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String DB_URL = "jdbc:mysql://localhost:3306/airport";
                        String DB_USER = "root";
                        String DB_PASS = "@Sashini123";
                        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

                        String sql = "SELECT * FROM FlightDetails WHERE flight_number = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, flightNumber.trim());
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
            %>
                            <h2>Flight Details for <%= flightNumber %></h2>
                            <p><strong>Flight ID:</strong> <%= rs.getInt("flight_id") %></p>
                            <p><strong>Flight Number:</strong> <%= rs.getString("flight_number") %></p>
                            <p><strong>Flight Date:</strong> <%= rs.getDate("flight_date") %></p>
                            <p><strong>Departure:</strong> <%= rs.getString("departure") %></p>
                            <p><strong>Arrival:</strong> <%= rs.getString("arrival") %></p>
                            <p><strong>Departure Time:</strong> <%= rs.getTime("departure_time") %></p>
                            <p><strong>Arrival Time:</strong> <%= rs.getTime("arrival_time") %></p>
                            <p><strong>Aircraft:</strong> <%= rs.getString("aircraft") %></p>
                            <p><strong>Status:</strong> <%= rs.getString("status") %></p>
            <%
                        } else {
            %>
                            <p class="error-message">Flight with number '<%= flightNumber %>' not found in the database.</p>
            <%
                        }
                    } catch (ClassNotFoundException e) {
                        out.println("<p class='error-message'><strong>Error: JDBC Driver not found.</strong></p>");
                    } catch (SQLException e) {
                        out.println("<p class='error-message'><strong>Error: Database connection or query failed.</strong></p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { }
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { }
                    }
                }
            %>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        const navLinks = document.querySelectorAll('.nav-links a');
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                navLinks.forEach(l => l.classList.remove('active')); // Remove active class from all links
                link.classList.add('active'); // Add active class to the clicked link
            });
        });
    </script>
</body>
</html>