<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Passenger</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 0;
            margin: 0;
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
        .search-form {
            text-align: center;
            margin: 20px 0;
        }
        .search-input {
            padding: 10px;
            width: 200px;
        }
        .search-btn {
            padding: 10px 20px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
        }
        .search-btn:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .no-records {
            text-align: center;
            padding: 20px;
            font-style: italic;
            color: #666;
        }
        h1 {
            text-align: center;
            margin-top: 40px; /* Add some space above the title */
            color: #003c71; /* Optional: change the title color */
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
            <li><a href="flightBooking.jsp" onclick="setActive(this)">Book a flight</a></li>
            <li><a href="checkIn.jsp" onclick="setActive(this)">Check-in</a></li>
            <li><a href="myBookings.jsp" onclick="setActive(this)">My Bookings</a></li>
            <li><a href="Information.jsp" onclick="setActive(this)">Information</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
        <a href="login.jsp" class="login">Log in</a>
    </div>

    <div class="sidebar" id="sidebar">
        <span class="close-btn" onclick="toggleSidebar()">✖</span>
        <ul>
            <li><a href="flightBooking.jsp" onclick="setActive(this)">Book a flight</a></li>
            <li><a href="checkIn.jsp" onclick="setActive(this)">Check-in</a></li>
            <li><a href="myBookings.jsp" onclick="setActive(this)">My Bookings</a></li>
            <li><a href="Information.jsp" onclick="setActive(this)">Information</a></li>
            <li><a href="ourFlight.jsp" onclick="setActive(this)">Our Flight</a></li>
            <li><a href="flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
    </div>

    <h1>Search Passenger</h1>

    <div class="search-form">
        <form method="get" action="searchPassenger.jsp">
            <input type="text" name="searchQuery" class="search-input" placeholder="Enter Passenger ID or Passport Number" required>
            <button type="submit" class="search-btn">Search</button>
        </form>
    </div>

    <%
        String url = "jdbc:mysql://localhost:3306/airport";
        String user = "root";
        String password = "@Sashini123";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String searchQuery = request.getParameter("searchQuery");
            if (searchQuery != null && !searchQuery.isEmpty()) {
                String sql = "SELECT passengerID, passengerName, passportNumber, email, phone FROM passengers WHERE passengerID LIKE ? OR passportNumber LIKE ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + searchQuery + "%");
                pstmt.setString(2, "%" + searchQuery + "%");
                rs = pstmt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<p class='no-records'>No matching records found.</p>");
                } else {
    %>

    <table>
        <thead>
            <tr>
                <th>Passenger ID</th>
                <th>Name</th>
                <th>Passport Number</th>
                <th>Email</th>
                <th>Phone</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    String passengerID = rs.getString("passengerID");
                    String passengerName = rs.getString("passengerName");
                    String passportNumber = rs.getString("passportNumber");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
            %>
            <tr>
                <td><%= passengerID %></td>
                <td><%= passengerName %></td>
                <td><%= passportNumber %></td>
                <td><%= email %></td>
                <td><%= phone %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>An error occurred: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <script>
        function setActive(element) {
            const links = document.querySelectorAll('#navLinks li a');
            links.forEach(link => link.classList.remove('active'));
            element.classList.add('active');
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }
    </script>

</body>
</html>