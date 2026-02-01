<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Check-In</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-image: url('img/check.png');
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
            position: relative;
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
            border-bottom: 3px solid red; /* Added underline effect */
        }
        .container {
            max-width: 800px;
            margin: 10px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .title {
            color: #003366;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }
        .check-in-options {
            margin: 20px 0;
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }
        .check-in-btn {
            background-color: white;
            color: #003c71;
            border: 1px solid #003c71;
            padding: 12px 25px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 250px;
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: center;
            text-decoration: none;
        }
        .booking-form {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.5s ease-out;
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }
        .booking-form.active {
            max-height: 500px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 15px;
            background-color: white;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #003c71;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .submit-btn {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            transition: background-color 0.3s;
        }
        .submit-btn:hover {
            background-color: #00274d;
        }
        .error-message {
            color: red;
            margin-top: 10px;
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
            <li><a href="checkIn.jsp" class="active">Check-in</a></li>
            <li><a href="myBookings.jsp">My Bookings</a></li>
            <li><a href="Information.jsp">Information</a></li>
            <li><a href="contactUs.jsp">Contact us</a></li>
        </ul>
    </div>

    <div class="container">
        <h1 class="title">Ready to check in?</h1>
        <p>You can check in any time from 30 hours before your flight's departure. Please select how you would like to check in:</p>

        <div class="check-in-options">
            <button class="check-in-btn" id="bookingDetailsBtn" onclick="toggleBookingForm()">
                Enter my booking details
            </button>
            
            <div class="booking-form" id="bookingForm">
                <form action="boardingPass.jsp" method="post" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="passengerID">Passenger ID</label>
                        <input type="text" id="passengerID" name="passengerID" required>
                    </div>
                    <div class="form-group">
                        <label for="flightNumber">Flight number</label>
                        <input type="text" id="flightNumber" name="flightNumber" required>
                    </div>
                    <button type="submit" class="submit-btn">Check In</button>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        function toggleBookingForm() {
            const bookingForm = document.getElementById('bookingForm');
            bookingForm.classList.toggle('active');
        }
        
        function validateForm() {
            const passengerID = document.getElementById('passengerID').value;
            const flightNumber = document.getElementById('flightNumber').value;
            
            if (!passengerID || !flightNumber) {
                alert('Please fill in all fields');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>