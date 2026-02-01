<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Book Flights</title>
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
        .hero-container {
            position: relative;
            text-align: left;
        }
        .hero-image {
            width: 100%;
            height: auto;
        }
        .hero-content {
            position: absolute;
            top: 20%;
            right: 5%;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }
        .hero-title {
            font-size: 34px;
            color: #003c71;
        }
        .hero-subtitle {
            font-size: 20px;
            color: #333;
        }
        .booking-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .booking-header {
            margin-bottom: 20px;
            font-size: 35px;
            color: #003c71;
        }
        .booking-input-container {
            display: flex;
            justify-content: space-between;
            width: 100%;
            margin-bottom: 15px;
        }
        .booking-input {
            padding: 10px;
            margin: 0 10px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }
        .booking-select {
            padding: 12px;
            margin: 0 10px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }
        .booking-button {
            padding: 10px;
            background-color: #003c71;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            height: 45px;
            width: 100%;
            margin-top: 10px;
        }
        .booking-button:hover {
            background-color: #00274d;
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
            <li><a href="flightBooking.jsp" onclick="setActive(this)" class="active">Book a flight</a></li>
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
            <li><a href="ourFlights.jsp" onclick="setActive(this)">Our flights</a></li>
            <li><a href="flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
            <li><a href="passenger.jsp" onclick="setActive(this)">Passenger Management</a></li>
            <li><a href="pilotDetails.jsp" onclick="setActive(this)">Pilot Management</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
        <div class="divider"></div>
    </div>

    <div class="hero-container">
        <img src="img/jbooking.jpeg" alt="Business Cabin Offer" class="hero-image">
        <div class="hero-content">
            <h1 class="hero-title">Our offers in Business cabin</h1>
            <p class="hero-subtitle">A cabin where you can dream of dream deals</p>
        </div>
    </div>

    <div class="booking-section">
        <div class="booking-header">Book a flight</div>
        
        <form action="search.jsp" method="get">
            <div class="booking-input-container">
                <select class="booking-select" name="tripType" id="tripType">
                    <option value="round">Round trip</option>
                    <option value="oneway">One way</option>
                    <option value="multi">Multi-city</option>
                </select>
                <input type="text" class="booking-input" name="departure" id="departure" placeholder="Departing from" required>
                <input type="text" class="booking-input" name="arrival" id="arrival" placeholder="Arriving at" required>
            </div>
            <div class="booking-input-container">
                <input type="date" class="booking-input" name="departureDate" id="departureDate" required>
                <input type="date" class="booking-input" name="returnDate" id="returnDate">
            </div>
            <div class="booking-input-container">
                <select class="booking-select" name="cabinClass" id="cabinClass">
                    <option value="economy">Economy</option>
                    <option value="premium">Premium Economy</option>
                    <option value="business">Business</option>
                    <option value="first">First Class</option>
                </select>
                <select class="booking-select" name="adults" id="adults">
                    <% for (int i = 1; i <= 9; i++) { %>
                        <option value="<%= i %>"><%= i %> Adult<%= i > 1 ? "s" : "" %></option>
                    <% } %>
                </select>
                <select class="booking-select" name="children" id="children">
                    <% for (int i = 0; i <= 6; i++) { %>
                        <option value="<%= i %>"><%= i %> Children<%= i == 1 ? " (Child)" : "" %></option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="booking-button">Search flights</button>
        </form>
    </div>

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