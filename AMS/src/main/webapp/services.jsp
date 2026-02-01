<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Concierge Service</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            line-height: 1.6;
            background-color: #f5f5f5;
            overflow-x: hidden;
        }

        /* Navigation Bar Styles */
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

        .nav-links a.active {
            color: #003c71;
            border-bottom: 2px solid #ff0000;
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

        .sidebar ul li a.active {
            color: #003c71;
            border-bottom: 2px solid #ff0000;
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

        /* Hero Image Styles - Modified to show full image */
        .hero-image-container {
            width: 100%;
            overflow: hidden;
            position: relative;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            background-color: #f0f0f0;
        }

        .hero-image {
            max-width: 100%;
            height: auto;
            display: block;
        }

        /* Content Styles */
        .content-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .breadcrumb {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }

        .breadcrumb a {
            color: #003c71;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        h1 {
            color: #003c71;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .service-description {
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        .service-features {
            margin-left: 20px;
        }

        .service-features li {
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .content-container {
                margin: 20px;
                padding: 15px;
            }
            
            .hero-image-container {
                background-color: #fff;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/img/humburgerIcon.png" alt="Menu" class="hamburger" onclick="toggleSidebar()">
            <img src="${pageContext.request.contextPath}/img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo">
        </div>
        <ul class="nav-links" id="navLinks">
            <li><a href="${pageContext.request.contextPath}/flightBooking.jsp" onclick="setActive(this)">Book a flight</a></li>
            <li><a href="${pageContext.request.contextPath}/checkIn.jsp" onclick="setActive(this)">Check-in</a></li>
            <li><a href="${pageContext.request.contextPath}/myBookings.jsp" onclick="setActive(this)">My Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/Information.jsp" onclick="setActive(this)" class="active">Information</a></li>
        </ul>
        <a href="${pageContext.request.contextPath}/login.jsp" class="login-btn">Log in</a>
    </div>

    <!-- Sidebar Navigation -->
    <div class="sidebar" id="sidebar">
        <span class="close-btn" onclick="toggleSidebar()">✖</span>
        <ul>
            <li><a href="${pageContext.request.contextPath}/flightBooking.jsp" onclick="setActive(this)">Book a flight</a></li>
            <li><a href="${pageContext.request.contextPath}/checkIn.jsp" onclick="setActive(this)">Check-in</a></li>
            <li><a href="${pageContext.request.contextPath}/myBookings.jsp" onclick="setActive(this)">My Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/Information.jsp" onclick="setActive(this)" class="active">Information</a></li>
            <li><a href="${pageContext.request.contextPath}/ourFlights.jsp" onclick="setActive(this)">Our flights</a></li>
            <li><a href="${pageContext.request.contextPath}/flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="${pageContext.request.contextPath}/businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="${pageContext.request.contextPath}/travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
            <li><a href="${pageContext.request.contextPath}/contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
        <div class="divider"></div>
    </div>

    <!-- Hero Image - Full Width -->
    <div class="hero-image-container">
        <img src="${pageContext.request.contextPath}/img/ser.png" alt="Concierge Service" class="hero-image">
    </div>

    <!-- Main Content -->
    <div class="content-container">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/Information.jsp">Information</a> &gt; 
            <span>Concierge Service</span>
        </div>
        
        <h1>Air Sri Lanka Concierge service</h1>
        
        <div class="service-description">
            Discover our Concierge service at Colombo-Bandaranaike International airport. 
            This service is open to all customers flying in the Economy, Premium, and Business cabins and includes:
        </div>
        
        <ul class="service-features">
            <li>Private transfer and increased handling before departure and on arrival</li>
            <li>Personalized assistance throughout your airport experience</li>
            <li>Expedited security and immigration procedures</li>
            <li>Access to premium lounges regardless of travel class</li>
            <li>Dedicated check-in counters</li>
            <li>Baggage handling priority</li>
            <li>Customized travel arrangements</li>
        </ul>
    </div>

    <script>
        function setActive(element) {
            const links = document.querySelectorAll('#navLinks li a, .sidebar ul li a');
            links.forEach(link => link.classList.remove('active'));
            element.classList.add('active');
            
            const href = element.getAttribute('href');
            const correspondingLink = document.querySelector(`.sidebar ul li a[href="${href}"], #navLinks li a[href="${href}"]`);
            if (correspondingLink) {
                correspondingLink.classList.add('active');
            }
            
            sessionStorage.setItem('activeNavLink', href);
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }
        
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const hamburger = document.querySelector('.hamburger');
            
            if (sidebar.classList.contains('active') && 
                !sidebar.contains(event.target) && 
                event.target !== hamburger) {
                sidebar.classList.remove('active');
            }
        });
        
        document.addEventListener('DOMContentLoaded', function() {
            const navLinks = document.querySelectorAll('#navLinks li a, .sidebar ul li a');
            const currentPage = window.location.pathname.split('/').pop();
            const activeNavLink = sessionStorage.getItem('activeNavLink') || 'Information.jsp';
            
            navLinks.forEach(link => {
                const linkPage = link.getAttribute('href').split('/').pop();
                if (linkPage === activeNavLink || linkPage === currentPage) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>