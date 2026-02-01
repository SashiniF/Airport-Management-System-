<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Staff Registration</title>
    <style>
        /* Existing CSS styles here */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-image: url('img/airline.png');
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
            border-bottom: 2px solid red; /* Active link styling */
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
            transition: border-bottom 0.3s ease;
        }
        .sidebar ul li a:hover {
            background-color: #f0f0f0;
        }
        .sidebar ul li a.active {
            border-bottom: 2px solid red; /* Active link styling */
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

    <div class="container">
        <h1 class="title">Airline Staff Registration</h1>
        <form action="registerStaff.jsp" method="post">
            <div class="form-group">
                <label for="staffID">Staff ID</label>
                <input type="text" id="staffID" name="staffID" value="AS001" readonly>
            </div>

            <div class="form-group">
                <label for="staffName">Name</label>
                <input type="text" id="staffName" name="staffName" required>
            </div>
            <div class="form-group">
                <label for="position">Position</label>
                <input type="text" id="position" name="position" required>
            </div>
             <div class="form-group">
                <label for="licenseNumber">License Number</label>
                <input type="text" id="licenseNumber" name="licenseNumber" required>
            </div>
            <div class="form-group">
                <label for="flightNumber">Flight Number</label>
                <input type="text" id="flightNumber" name="flightNumber" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <button type="submit" class="submit-btn">Register Staff</button>
        </form>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        function setActiveLink(links) {
            links.forEach(link => {
                link.addEventListener('click', () => {
                    links.forEach(l => l.classList.remove('active'));
                    link.classList.add('active');
                });
            });
        }

        const navLinks = document.querySelectorAll('.nav-links a');
        setActiveLink(navLinks);

        const sidebarLinks = document.querySelectorAll('.sidebar ul li a');
        setActiveLink(sidebarLinks);
    </script>
</body>
</html>