<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
// Handle form submissions
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String action = request.getParameter("action");
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
        
        if ("add".equals(action)) {
            // Add new flight
            String sql = "INSERT INTO FlightDetails (flight_number, flight_date, departure, arrival, departure_time, arrival_time, aircraft, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("newFlightNumber"));
            pstmt.setDate(2, Date.valueOf(request.getParameter("flightDate")));
            pstmt.setString(3, request.getParameter("departure"));
            pstmt.setString(4, request.getParameter("arrival"));
            pstmt.setTime(5, Time.valueOf(request.getParameter("departureTime") + ":00"));
            pstmt.setTime(6, Time.valueOf(request.getParameter("arrivalTime") + ":00"));
            pstmt.setString(7, request.getParameter("aircraft"));
            pstmt.setString(8, request.getParameter("status"));
            pstmt.executeUpdate();
        } 
        else if ("edit".equals(action)) {
            // Edit flight - now properly handling flight number update
            String originalFlightNumber = request.getParameter("originalFlightNumber");
            String newFlightNumber = request.getParameter("newFlightNumber");
            
            String sql = "UPDATE FlightDetails SET flight_number=?, flight_date=?, departure=?, arrival=?, departure_time=?, arrival_time=?, aircraft=?, status=? WHERE flight_number=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newFlightNumber);
            pstmt.setDate(2, Date.valueOf(request.getParameter("flightDate")));
            pstmt.setString(3, request.getParameter("departure"));
            pstmt.setString(4, request.getParameter("arrival"));
            pstmt.setTime(5, Time.valueOf(request.getParameter("departureTime") + ":00"));
            pstmt.setTime(6, Time.valueOf(request.getParameter("arrivalTime") + ":00"));
            pstmt.setString(7, request.getParameter("aircraft"));
            pstmt.setString(8, request.getParameter("status"));
            pstmt.setString(9, originalFlightNumber);
            pstmt.executeUpdate();
        } 
        else if ("delete".equals(action)) {
            // Delete flight
            String flightNumber = request.getParameter("flightNumber");
            String sql = "DELETE FROM FlightDetails WHERE flight_number=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, flightNumber);
            pstmt.executeUpdate();
        }
        
        // Redirect to self to refresh the data
        response.sendRedirect("ourFlight.jsp");
        return;
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
}

// Check if we're in edit mode
String editFlightNumber = request.getParameter("editFlight");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Flight Schedules</title>
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
        .schedule-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .schedule-header {
            margin-bottom: 20px;
            font-size: 35px;
            color: #003c71;
            text-align: center;
        }
        .schedule-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .schedule-table th {
            background-color: #003c71;
            color: white;
            padding: 12px;
            text-align: left;
        }
        .schedule-table td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
        }
        .schedule-table tr:hover {
            background-color: #f0f0f0;
        }
        .flight-number {
            color: #003c71;
            font-weight: bold;
        }
        .flight-status {
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: bold;
        }
        .status-on-time {
            background-color: #e6f7e6;
            color: #2e7d32;
        }
        .status-delayed {
            background-color: #fff8e1;
            color: #ff8f00;
        }
        .status-cancelled {
            background-color: #ffebee;
            color: #c62828;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1001;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: #f9f9f9;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #003c71;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            padding: 10px 20px;
            background-color: #003c71;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056a6;
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
            <li><a href="ourFlight.jsp" onclick="setActive(this)" class="active">Our Flight</a></li>
            <li><a href="flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
        <div class="divider"></div>
    </div>

    <div class="hero-container">
        <img src="img/flight.png" alt="Flight Schedules" class="hero-image">
        <div class="hero-content">
            <h1 class="hero-title">Flight Schedules</h1>
            <p class="hero-subtitle">Check our flight timings and plan your journey</p>
        </div>
    </div>

    <div class="schedule-section">
        <div class="schedule-header">Flight Schedules</div>
        
        <table class="schedule-table" id="flightTable">
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Flight No.</th>
                    <th>Date</th>
                    <th>Departure</th>
                    <th>Arrival</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Aircraft</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM FlightDetails";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            String flightNumber = rs.getString("flight_number");
                            Date flightDate = rs.getDate("flight_date");
                            String departure = rs.getString("departure");
                            String arrival = rs.getString("arrival");
                            Time departureTime = rs.getTime("departure_time");
                            Time arrivalTime = rs.getTime("arrival_time");
                            String aircraft = rs.getString("aircraft");
                            String status = rs.getString("status");
                            String statusClass = status.replace(" ", "-").toLowerCase();
                %>
                            <tr>
                                <td><input type="radio" name="selectedFlight" value="<%= flightNumber %>" <%= (flightNumber.equals(editFlightNumber) ? "checked" : "") %>></td>
                                <td class="flight-number"><%= flightNumber %></td>
                                <td><%= flightDate %></td>
                                <td><%= departure %></td>
                                <td><%= arrival %></td>
                                <td><%= departureTime.toString().substring(0, 5) %></td>
                                <td><%= arrivalTime.toString().substring(0, 5) %></td>
                                <td><%= aircraft %></td>
                                <td><span class="flight-status status-<%= statusClass %>"><%= status %></span></td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                        if (conn != null) try { conn.close(); } catch (SQLException e) {}
                    }
                %>
            </tbody>
        </table>

        <div style="margin-top: 20px;">
            <button onclick="openModal('add')">Add Flight</button>
            <button onclick="editSelected()">Edit Selected</button>
            <button onclick="deleteSelected()">Delete Selected</button>
        </div>

        <div id="flightModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2 id="modalTitle">Add a New Flight</h2>
                <form id="flightForm" method="post">
                    <input type="hidden" name="action" id="formAction" value="add">
                    <input type="hidden" name="originalFlightNumber" id="originalFlightNumber">
                    
                    <div class="form-group">
                        <label for="flightNumber">Flight No.</label>
                        <input type="text" id="flightNumber" name="newFlightNumber" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="flightDate">Date</label>
                        <input type="date" id="flightDate" name="flightDate" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="departure">Departure</label>
                        <input type="text" id="departure" name="departure" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="arrival">Arrival</label>
                        <input type="text" id="arrival" name="arrival" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="departureTime">Departure Time</label>
                        <input type="time" id="departureTime" name="departureTime" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="arrivalTime">Arrival Time</label>
                        <input type="time" id="arrivalTime" name="arrivalTime" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="aircraft">Aircraft</label>
                        <input type="text" id="aircraft" name="aircraft" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" required>
                            <option value="On Time">On Time</option>
                            <option value="Delayed">Delayed</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </div>
                    
                    <button type="submit">Save</button>
                </form>
            </div>
        </div>
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

        function openModal(action) {
            const modal = document.getElementById("flightModal");
            const modalTitle = document.getElementById("modalTitle");
            const formAction = document.getElementById("formAction");
            
            if (action === 'add') {
                modalTitle.textContent = "Add a New Flight";
                formAction.value = "add";
                document.getElementById("flightForm").reset();
                document.getElementById("originalFlightNumber").value = "";
                document.getElementById("flightNumber").readOnly = false;
            }
            
            modal.style.display = "block";
        }

        function closeModal() {
            document.getElementById("flightModal").style.display = "none";
        }

        function editSelected() {
            const selectedFlight = document.querySelector('input[name="selectedFlight"]:checked');
            if (selectedFlight) {
                const flightNumber = selectedFlight.value;
                const row = selectedFlight.closest('tr');
                
                // Populate the form with the selected flight's data
                document.getElementById("modalTitle").textContent = "Edit Flight " + flightNumber;
                document.getElementById("formAction").value = "edit";
                document.getElementById("originalFlightNumber").value = flightNumber;
                document.getElementById("flightNumber").value = flightNumber;
                document.getElementById("flightNumber").readOnly = false; // Changed to allow editing
                document.getElementById("flightDate").value = row.cells[2].textContent;
                document.getElementById("departure").value = row.cells[3].textContent;
                document.getElementById("arrival").value = row.cells[4].textContent;
                document.getElementById("departureTime").value = row.cells[5].textContent;
                document.getElementById("arrivalTime").value = row.cells[6].textContent;
                document.getElementById("aircraft").value = row.cells[7].textContent;
                document.getElementById("status").value = row.cells[8].querySelector('span').textContent.trim();
                
                // Open the modal
                document.getElementById("flightModal").style.display = "block";
            } else {
                alert("Please select a flight to edit.");
            }
        }

        function deleteSelected() {
            const selectedFlight = document.querySelector('input[name="selectedFlight"]:checked');
            if (selectedFlight) {
                const flightNumber = selectedFlight.value;
                if (confirm(`Are you sure you want to delete flight ${flightNumber}?`)) {
                    // Create a form and submit it to delete the flight
                    const form = document.createElement('form');
                    form.method = 'post';
                    form.action = 'ourFlight.jsp';
                    
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'delete';
                    form.appendChild(actionInput);
                    
                    const flightInput = document.createElement('input');
                    flightInput.type = 'hidden';
                    flightInput.name = 'flightNumber';
                    flightInput.value = flightNumber;
                    form.appendChild(flightInput);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            } else {
                alert("Please select a flight to delete.");
            }
        }

        window.onclick = function(event) {
            const modal = document.getElementById("flightModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

</body>
</html>