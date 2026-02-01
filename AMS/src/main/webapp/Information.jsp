<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }
        
        .navbar {
            background-color: white;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            padding: 10px 20px;
            position: relative;
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
        
        .hamburger {
            width: 40px;
            height: auto;
            margin-right: 20px;
            cursor: pointer;
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
            position: relative;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #003c71;
            font-weight: 500;
            padding: 10px 15px;
            display: block;
        }
        
        .nav-links a:hover {
            background-color: #f0f0f0;
        }
        
        .nav-links a.active, .sidebar ul li a.active {
            color: #003c71;
            border-bottom: 2px solid #ff5c00;
        }
        
        .login-btn {
            margin-left: auto;
            color: #003c71;
            text-decoration: none;
            padding: 10px 15px;
        }
        
        /* Sidebar Styles */
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
            font-family: Arial, sans-serif;
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
        
        .divider {
            height: 1px;
            background-color: #e0e0e0;
            margin: 10px 0;
        }
        
        .hero-banner {
            background-image: url('img/information-banner.jpg');
            background-size: cover;
            background-position: center;
            height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            position: relative;
        }
        
        .hero-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 60, 113, 0.7);
        }
        
        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 800px;
            padding: 20px;
        }
        
        .hero-content h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        
        .information-section {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .section-title {
            color: #003c71;
            font-size: 1.8rem;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .info-cards {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }
        
        .info-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 23%;
            min-width: 250px;
            flex: 1;
        }
        
        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .card-image {
            height: 180px;
            overflow: hidden;
        }
        
        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .info-card:hover .card-image img {
            transform: scale(1.05);
        }
        
        .card-content {
            padding: 15px;
        }
        
        .card-content h3 {
            color: #003c71;
            margin-top: 0;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }
        
        .card-content p {
            margin-bottom: 15px;
            font-size: 0.9rem;
        }
        
        .read-more {
            color: #ff5c00;
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            font-size: 0.9rem;
        }
        
        @media (max-width: 1200px) {
            .info-cards {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .info-card {
                width: 48%;
                margin-bottom: 20px;
            }
        }
        
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .hero-content h1 {
                font-size: 2rem;
            }
            
            .info-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo-container">
            <img src="img/humburgerIcon.png" alt="Menu" class="hamburger" onclick="toggleSidebar()">
            <img src="img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo">
        </div>
        <ul class="nav-links" id="navLinks">
            <li><a href="flightBooking.jsp" onclick="setActive(this)">Book a flight</a></li>
            <li><a href="checkIn.jsp" onclick="setActive(this)">Check-in</a></li>
            <li><a href="myBookings.jsp" onclick="setActive(this)">My Bookings</a></li>
            <li><a href="Information.jsp" onclick="setActive(this)" class="active">Information</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact Us</a></li>
        </ul>
        <a href="login.jsp" class="login-btn">Log in</a>
    </div>

    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <span class="close-btn" onclick="toggleSidebar()">✖</span>
        <ul>
            <li><a href="bookFlight.jsp" onclick="setActive(this)">Book a flight</a></li>
            <li><a href="checkIn.jsp" onclick="setActive(this)">Check-in</a></li>
            <li><a href="myBookings.jsp" onclick="setActive(this)">My Bookings</a></li>
            <li><a href="Information.jsp" onclick="setActive(this)">Information</a></li>
            <li><a href="ourFlights.jsp" onclick="setActive(this)">Our flights</a></li>
            <li><a href="flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
        </ul>
        <div class="divider"></div>
    </div>

    <div class="hero-banner">
        <div class="hero-content">
            <h1>Travel with Air Sri Lanka</h1>
            <h2>Information and helpful tips</h2>
        </div>
    </div>

    <div class="information-section">
        <h2 class="section-title">The latest</h2>
        
        <div class="info-cards">
            <!-- Business Class Suite Card -->
            <div class="info-card">
                <div class="card-image">
                    <img src="img/suite.png" alt="New Business Class Suite">
                </div>
                <div class="card-content">
                    <h3>Discover the new Business Class suite</h3>
                    <p>Experience unparalleled comfort in our newly designed Business Class cabins featuring lie-flat seats and premium amenities.</p>
                    <a href="status.jsp" class="read-more">Read more →</a>
                </div>
            </div>
            
            <!-- Flight Status Card -->
            <div class="info-card">
                <div class="card-image">
                    <img src="img/status.png" alt="Flight Status">
                </div>
                <div class="card-content">
                    <h3>Flight schedule and status</h3>
                    <p>Check real-time flight information, schedules, and status updates for all Air Sri Lanka flights.</p>
                    <a href="flightStatus.jsp" class="read-more">Check status →</a>
                </div>
            </div>
            
            <!-- Airport Services Card -->
            <div class="info-card">
                <div class="card-image">
                    <img src="img/services.png" alt="Airport Services">
                </div>
                <div class="card-content">
                    <h3>Enjoy bespoke services at Colombo-Bandaranaike airport</h3>
                    <p>From premium lounge access to fast-track immigration, discover our exclusive airport services.</p>
                    <a href="services.jsp" class="read-more">Learn more →</a>
                </div>
            </div>
            
            <!-- Baggage Services Card -->
            <div class="info-card">
                <div class="card-image">
                    <img src="img/baggage.png" alt="Baggage Services">
                </div>
                <div class="card-content">
                    <h3>Hand-off your baggage and travel with ease</h3>
                    <p>Learn about our baggage policies, tracking services, and special handling options.</p>
                    <a href="luggage.jsp" class="read-more">Baggage info →</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        function setActive(element) {
            // Remove active class from all nav links in both main nav and sidebar
            const allLinks = document.querySelectorAll('#navLinks li a, .sidebar ul li a');
            allLinks.forEach(link => link.classList.remove('active'));
            
            // Add active class to clicked element
            element.classList.add('active');
            
            // If clicked from sidebar, also activate corresponding main nav link if exists
            if (element.closest('.sidebar')) {
                const mainNavLinks = document.querySelectorAll('#navLinks li a');
                const currentHref = element.getAttribute('href');
                
                mainNavLinks.forEach(link => {
                    if (link.getAttribute('href') === currentHref) {
                        link.classList.add('active');
                    }
                });
            }
            
            // Close sidebar if it's open (for mobile)
            const sidebar = document.getElementById('sidebar');
            if (sidebar.classList.contains('active')) {
                sidebar.classList.remove('active');
            }
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }
        
        // Close sidebar when clicking outside of it
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const hamburger = document.querySelector('.hamburger');
            
            if (sidebar.classList.contains('active') && 
                !sidebar.contains(event.target) && 
                event.target !== hamburger) {
                sidebar.classList.remove('active');
            }
        });
        
        // Set active link based on current page
        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = window.location.pathname.split('/').pop();
            const allLinks = document.querySelectorAll('#navLinks li a, .sidebar ul li a');
            
            allLinks.forEach(link => {
                const linkHref = link.getAttribute('href');
                if (linkHref === currentPage) {
                    link.classList.add('active');
                    
                    // If it's a sidebar link, also activate corresponding main nav link
                    if (link.closest('.sidebar')) {
                        const mainNavLinks = document.querySelectorAll('#navLinks li a');
                        mainNavLinks.forEach(navLink => {
                            if (navLink.getAttribute('href') === currentPage) {
                                navLink.classList.add('active');
                            }
                        });
                    }
                }
            });
        });
    </script>
</body>
</html>