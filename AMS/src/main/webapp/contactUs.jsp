<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Contact Us</title>
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
        .main-content {
            display: flex;
            gap: 30px;
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .contact-content {
            flex: 2;
        }
        .contact-header {
            font-size: 36px;
            color: #003c71;
            margin-bottom: 30px;
            text-align: center;
        }
        .contact-section {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 40px;
        }
        .contact-card {
            flex: 1;
            min-width: 300px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }
        .contact-card h2 {
            color: #003c71;
            margin-top: 0;
            border-bottom: 2px solid #ff5c00;
            padding-bottom: 10px;
        }
        .contact-info {
            margin-top: 20px;
        }
        .contact-info p {
            margin: 15px 0;
            display: flex;
            align-items: center;
        }
        .contact-info i {
            margin-right: 10px;
            color: #ff5c00;
            font-size: 20px;
        }
        .contact-form {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #003c71;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        textarea.form-control {
            height: 150px;
            resize: vertical;
        }
        .submit-btn {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .submit-btn:hover {
            background-color: #00274d;
        }
        .chatbot-container {
            flex: 1;
            min-width: 350px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            height: fit-content;
            position: sticky;
            top: 20px;
        }
        .chatbot-header {
            background-color: #003c71;
            color: white;
            padding: 15px;
            border-radius: 8px 8px 0 0;
            margin: -20px -20px 20px -20px;
            display: flex;
            align-items: center;
        }
        .chatbot-header i {
            margin-right: 10px;
            font-size: 24px;
        }
        .chatbot-messages {
            height: 400px;
            overflow-y: auto;
            margin-bottom: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
        }
        .message {
            margin-bottom: 15px;
            padding: 10px 15px;
            border-radius: 18px;
            max-width: 80%;
            word-wrap: break-word;
        }
        .user-message {
            background-color: #e3f2fd;
            margin-left: auto;
            border-bottom-right-radius: 5px;
        }
        .bot-message {
            background-color: #f1f1f1;
            margin-right: auto;
            border-bottom-left-radius: 5px;
        }
        .chatbot-input {
            display: flex;
            gap: 10px;
        }
        .chatbot-input input {
            flex: 1;
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 16px;
        }
        .chatbot-input button {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        .chatbot-input button:hover {
            background-color: #00274d;
        }
        .typing-indicator {
            display: none;
            color: #666;
            font-style: italic;
            margin: 5px 0;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
            <li><a href="contactUs.jsp" onclick="setActive(this)" class="active">Contact us</a></li>
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

    <div class="main-content">
        <div class="contact-content">
            <h1 class="contact-header">Contact Air Sri Lanka</h1>
            
            <div class="contact-section">
                <div class="contact-card">
                    <h2>Customer Service</h2>
                    <div class="contact-info">
                        <p><i class="fas fa-phone-alt"></i> +94 11 2 123456</p>
                        <p><i class="fas fa-envelope"></i> customerservice@airsrilanka.com</p>
                        <p><i class="fas fa-clock"></i> 24/7 Support</p>
                    </div>
                </div>
                
                <div class="contact-card">
                    <h2>Head Office</h2>
                    <div class="contact-info">
                        <p><i class="fas fa-map-marker-alt"></i> Air Sri Lanka Headquarters, Bandaranaike International Airport, Katunayake, Sri Lanka</p>
                        <p><i class="fas fa-phone-alt"></i> +94 11 2 987654</p>
                        <p><i class="fas fa-envelope"></i> info@airsrilanka.com</p>
                    </div>
                </div>
                
                <div class="contact-card">
                    <h2>Social Media</h2>
                    <div class="contact-info">
                        <p><i class="fab fa-facebook"></i> facebook.com/airsrilanka</p>
                        <p><i class="fab fa-twitter"></i> twitter.com/airsrilanka</p>
                        <p><i class="fab fa-instagram"></i> instagram.com/airsrilanka</p>
                    </div>
                </div>
            </div>
            
            <div class="contact-form">
                <h2>Send us a Message</h2>
                <form action="contactSubmit.jsp" method="post">
                    <div class="form-group">
                        <label for="name">Your Name</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" class="form-control" required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>
        </div>
        
        <div class="chatbot-container">
            <div class="chatbot-header">
                <i class="fas fa-robot"></i>
                <h3>Air Sri Lanka Assistant</h3>
            </div>
            <div class="chatbot-messages" id="chatbotMessages">
                <div class="message bot-message">
                    Hello! I'm your Air Sri Lanka assistant. I can help with:
                    <ul>
                        <li>Airline safety information</li>
                        <li>Weather for any city worldwide</li>
                        <li>General flight information</li>
                    </ul>
                    How can I assist you today?
                </div>
            </div>
            <div class="typing-indicator" id="typingIndicator">Assistant is typing...</div>
            <div class="chatbot-input">
                <input type="text" id="userInput" placeholder="Ask about safety or weather..." onkeypress="handleKeyPress(event)">
                <button onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>
    </div>

    <script>
        // Navbar and sidebar functions
        function setActive(element) {
            const links = document.querySelectorAll('#navLinks li a');
            links.forEach(link => link.classList.remove('active'));
            element.classList.add('active');
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        // Chatbot functions
        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }

        function sendMessage() {
            const userInput = document.getElementById('userInput');
            const message = userInput.value.trim();
            
            if (message === '') return;
            
            // Add user message to chat
            addMessage(message, 'user');
            userInput.value = '';
            
            // Show typing indicator
            document.getElementById('typingIndicator').style.display = 'block';
            
            // Simulate delay for bot response
            setTimeout(() => {
                document.getElementById('typingIndicator').style.display = 'none';
                const botResponse = generateResponse(message);
                addMessage(botResponse, 'bot');
            }, 1000 + Math.random() * 2000);
        }
        
        function addMessage(text, sender) {
            const messagesContainer = document.getElementById('chatbotMessages');
            const messageDiv = document.createElement('div');
            messageDiv.classList.add('message');
            messageDiv.classList.add(sender === 'user' ? 'user-message' : 'bot-message');
            
            // Handle both text and HTML content
            if (typeof text === 'string' && text.startsWith('<')) {
                messageDiv.innerHTML = text;
            } else {
                messageDiv.textContent = text;
            }
            
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }
        
        function generateResponse(userMessage) {
            const lowerMessage = userMessage.toLowerCase();
            
            // Airline safety responses
            if (lowerMessage.includes('safety') || lowerMessage.includes('secure') || 
                lowerMessage.includes('measure')) {
                return `Air Sri Lanka follows strict safety protocols:<br>
                        <ul>
                            <li>Regular aircraft maintenance checks</li>
                            <li>Highly trained pilots and crew</li>
                            <li>Emergency equipment on all flights</li>
                            <li>Compliance with international aviation standards</li>
                        </ul>`;
            }
            
            if (lowerMessage.includes('emergency') || lowerMessage.includes('evacuation')) {
                return `In emergencies:<br>
                        <ol>
                            <li>Listen to crew instructions</li>
                            <li>Locate nearest exit (count rows to your exit)</li>
                            <li>Assume brace position if instructed</li>
                            <li>Leave all belongings behind</li>
                        </ol>`;
            }
            
            // Weather responses
            if (lowerMessage.includes('weather') || lowerMessage.includes('forecast') || 
                lowerMessage.includes('temperature')) {
                const cityMatch = userMessage.match(/weather in (.+)/i) || 
                                 userMessage.match(/forecast for (.+)/i) ||
                                 userMessage.match(/how is the weather in (.+)/i);
                
                if (cityMatch && cityMatch[1]) {
                    const city = cityMatch[1].trim();
                    return `For accurate weather in <strong>${city}</strong>, I recommend checking:<br>
                           <ul>
                               <li><a href="https://www.accuweather.com/en/search-locations?query=${encodeURIComponent(city)}" target="_blank">AccuWeather</a></li>
                               <li><a href="https://www.weather.com/weather/today/l/${encodeURIComponent(city)}" target="_blank">Weather.com</a></li>
                           </ul>
                           Need general climate info about ${city}?`;
                } else {
                    return "I can check weather for any city. Try:<br>" +
                           "• <em>'Weather in Colombo'</em><br>" +
                           "• <em>'What's the forecast for London?'</em>";
                }
            }
            
            
             