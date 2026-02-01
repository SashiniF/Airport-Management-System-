<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - La Première Suite</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
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
        
        .suite-hero {
            background-image: url('img/premiere-suite-hero.jpg');
            background-size: cover;
            background-position: center;
            height: 60vh;
            display: flex;
            align-items: center;
            position: relative;
        }
        
        .suite-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 60, 113, 0.3);
        }
        
        .suite-hero-content {
            position: relative;
            z-index: 1;
            color: white;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            width: 100%;
        }
        
        .suite-hero-content h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            max-width: 600px;
        }
        
        .suite-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 20px;
        }
        
        .suite-section {
            margin-bottom: 60px;
        }
        
        .suite-section h2 {
            color: #003c71;
            font-size: 2rem;
            margin-bottom: 20px;
        }
        
        .suite-section p {
            font-size: 1.1rem;
            margin-bottom: 20px;
            max-width: 800px;
        }
        
        .suite-features {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-top: 40px;
        }
        
        .feature-card {
            flex: 1;
            min-width: 250px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            transition: transform 0.3s ease;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .feature-card h3 {
            color: #003c71;
            margin-top: 0;
        }
        
        .feature-card p {
            font-size: 1rem;
        }
        
        .suite-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 40px;
        }
        
        .gallery-item {
            height: 250px;
            overflow: hidden;
            border-radius: 8px;
        }
        
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .gallery-item:hover img {
            transform: scale(1.05);
        }
        
        .back-link {
            display: inline-block;
            margin-top: 30px;
            color: #003c71;
            text-decoration: none;
            font-weight: 500;
            padding: 10px 15px;
            border: 1px solid #003c71;
            border-radius: 4px;
        }
        
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .suite-hero-content h1 {
                font-size: 2.2rem;
            }
            
            .suite-hero {
                height: 50vh;
            }
            
            .suite-features {
                flex-direction: column;
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
            <li><a href="information.jsp" onclick="setActive(this)" class="active">Information</a></li>
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
            <li><a href="Information.jsp" onclick="setActive(this)" class="active">Information</a></li>
            <li><a href="ourFlights.jsp" onclick="setActive(this)">Our flights</a></li>
            <li><a href="flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
        <div class="divider"></div>
    </div>

    <div class="suite-hero">
        <div class="suite-hero-content">
            <h1>Discover the new first-class suite</h1>
        </div>
    </div>

    <div class="suite-container">
        <div class="suite-section">
            <h2>An Unforgettable Journey</h2>
            <p>Treat yourself to an unforgettable journey. The new La Première suite offers a fully adaptable living space, designed for your privacy and well-being. Experience the pinnacle of luxury with our exclusive cabin designed for the most discerning travelers.</p>
            
            <div class="suite-features">
                <div class="feature-card">
                    <h3>Private Suite</h3>
                    <p>Your own secluded space with sliding doors for complete privacy, featuring a fully flat bed and direct aisle access.</p>
                </div>
                <div class="feature-card">
                    <h3>Premium Amenities</h3>
                    <p>Enjoy luxury bedding, designer toiletries, noise-canceling headphones, and premium entertainment options.</p>
                </div>
                <div class="feature-card">
                    <h3>Gourmet Dining</h3>
                    <p>Experience restaurant-quality meals prepared by world-class chefs, served on-demand at your preferred time.</p>
                </div>
            </div>
        </div>
        
        <div class="suite-section">
            <h2>Designed for Your Comfort</h2>
            <p>The La Première suite transforms into your private sanctuary at 30,000 feet. With meticulous attention to detail, every element has been crafted to provide unparalleled comfort and style.</p>
            
            <div class="suite-gallery">
                <div class="gallery-item">
                    <img src="img/suiteBed.png" alt="Suite Bed">
                </div>
                <div class="gallery-item">
                    <img src="img/suiteSeat.png" alt="Suite Seat">
                </div>
                <div class="gallery-item">
                    <img src="img/dining.png" alt="Suite Dining">
                </div>
            </div>
        </div>
        
        <a href="Information.jsp" class="back-link">← Back to Information</a>
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
            const activeNavLink = sessionStorage.getItem('activeNavLink') || 'information.jsp';
            
            navLinks.forEach(link => {
                const linkPage = link.getAttribute('href');
                if (linkPage === activeNavLink || linkPage === currentPage) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
               