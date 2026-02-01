<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Login</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-image: url('img/a.png');
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

        .container {
            max-width: 400px; /* Adjusted max-width */
            margin: 30px 0 30px 20px; /* Adjusted margin to push left */
            padding: 20px; /* Adjusted padding */
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

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #003c71;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .submit-btn {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 14px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background-color: #00274d;
        }

        .forgot-password {
            text-align: right;
            margin-top: -15px;
            margin-bottom: 20px;
        }

        .forgot-password a {
            color: #003c71;
            text-decoration: none;
            font-size: 14px;
        }

        .register-link {
            margin-top: 20px;
            color: #003c71;
        }

        .register-link a {
            color: #003c71;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 20px;
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
        <a href="login.jsp" class="login-btn active">Log in </a>
    </div>

    <div class="container">
        <h1 class="title">Welcome back</h1>
        <p>Log in to your Air Sri Lanka account to manage your bookings, check in, and more.</p>

        <%
            // Check for login credentials
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String errorMessage = request.getParameter("error");

            if (username != null && password != null) {
                if (username.equals("admin") && password.equals("admin@123")) {
                    response.sendRedirect("admin.jsp");
                    return; // Stop further processing
                } else if (username.equals("sashini") && password.equals("sashini@123")) {
                    response.sendRedirect("flightBooking.jsp");
                    return; // Stop further processing
                } else {
                    errorMessage = "Invalid credentials";
                }
            }

            if (errorMessage != null) { 
        %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <%
            }
        %>

        <form class="login-form" action="login.jsp" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="forgot-password">
                <a href="forgotPassword.jsp">Forgot password?</a>
            </div>
            
            <button type="submit" class="submit-btn">Log in</button>
            
            <div class="register-link">
                Don't have an account? <a href="passenger.jsp">Register now</a>
            </div>
        </form>
    </div>
    
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        // Highlight active navigation item
        document.addEventListener('DOMContentLoaded', function() {
            const navLinks = document.querySelectorAll('.nav-links a');
            navLinks.forEach(link => {
                link.addEventListener('click', function() {
                    navLinks.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        });
    </script>
</body>
</html>