<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String action = request.getParameter("action");
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
        
        if ("edit".equals(action)) {
            String originalPassengerID = request.getParameter("originalPassengerID");
            String sql = "UPDATE passengers SET passengerName=?, passportNumber=?, email=?, phone=? WHERE passengerID=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("passengerName"));
            pstmt.setString(2, request.getParameter("passportNumber"));
            pstmt.setString(3, request.getParameter("email"));
            pstmt.setString(4, request.getParameter("phone"));
            pstmt.setString(5, originalPassengerID);
            pstmt.executeUpdate();
        } 
        else if ("delete".equals(action)) {
            String passengerID = request.getParameter("passengerID");
            String sql = "DELETE FROM passengers WHERE passengerID=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, passengerID);
            pstmt.executeUpdate();
        }
        
        response.sendRedirect("passengersView.jsp");
        return;
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
}

String editPassengerID = request.getParameter("editPassenger");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air Sri Lanka - Passenger Management</title>
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
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .title {
            color: #003366;
            font-size: 2rem;
            margin-bottom: 20px;
            text-align: center;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e0e0;
        }
        .passenger-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .passenger-table th {
            background-color: #003c71;
            color: white;
            padding: 12px;
            text-align: left;
        }
        .passenger-table td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
        }
        .passenger-table tr:hover {
            background-color: #f5f5f5;
        }
        .passenger-id {
            color: #003c71;
            font-weight: bold;
        }
        .action-buttons {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .btn-primary {
            background-color: #003c71;
            color: white;
        }
        .btn-primary:hover {
            background-color: #002a50;
        }
        .btn-danger {
            background-color: #d32f2f;
            color: white;
        }
        .btn-danger:hover {
            background-color: #b71c1c;
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
            background-color: white;
            margin: 10% auto;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 600px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover {
            color: #333;
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
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-actions {
            margin-top: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo-container">
            <img src="img/humburgerIcon.png" alt="Menu" class="hamburger" onclick="toggleSidebar()">
            <img src="${pageContext.request.contextPath}/img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo">
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
            <li><a href="ourFlights.jsp" onclick="setActive(this)">Our flights</a></li>
            <li><a href="flightStatus.jsp" onclick="setActive(this)">Flight status</a></li>
            <li><a href="businessServices.jsp" onclick="setActive(this)">Business Services</a></li>
            <li><a href="travelDestinations.jsp" onclick="setActive(this)">Travel destinations</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact us</a></li>
        </ul>
    </div>

    <div class="container">
        <h1 class="title">Passenger Management</h1>
        
        <table class="passenger-table">
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Passenger ID</th>
                    <th>Name</th>
                    <th>Passport Number</th>
                    <th>Email</th>
                    <th>Phone</th>
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
                        String sql = "SELECT * FROM passengers";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            String passengerID = rs.getString("passengerID");
                            String passengerName = rs.getString("passengerName");
                            String passportNumber = rs.getString("passportNumber");
                            String email = rs.getString("email");
                            String phone = rs.getString("phone");
                %>
                            <tr>
                                <td><input type="radio" name="selectedPassenger" value="<%= passengerID %>" <%= (passengerID.equals(editPassengerID) ? "checked" : "") %>></td>
                                <td class="passenger-id"><%= passengerID %></td>
                                <td><%= passengerName %></td>
                                <td><%= passportNumber %></td>
                                <td><%= email %></td>
                                <td><%= phone %></td>
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

        <div class="action-buttons">
            <button class="btn btn-primary" onclick="window.location.href='searchPassenger.jsp'">Search Passenger</button>
            <button class="btn btn-danger" onclick="deleteSelected()">Delete Selected</button>
        </div>

        <!-- Modal for Edit Passenger -->
        <div id="passengerModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2 id="modalTitle">Edit Passenger</h2>
                <form id="passengerForm" method="post">
                    <input type="hidden" name="action" id="formAction" value="edit">
                    <input type="hidden" name="originalPassengerID" id="originalPassengerID">
                    
                    <div class="form-group">
                        <label for="passengerID">Passenger ID</label>
                        <input type="text" id="passengerID" name="passengerID" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="passengerName">Name</label>
                        <input type="text" id="passengerName" name="passengerName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="passportNumber">Passport Number</label>
                        <input type="text" id="passportNumber" name="passportNumber" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-danger" onclick="closeModal()">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        function closeModal() {
            document.getElementById("passengerModal").style.display = "none";
        }

        function deleteSelected() {
            const selectedPassenger = document.querySelector('input[name="selectedPassenger"]:checked');
            if (selectedPassenger) {
                const passengerID = selectedPassenger.value;
                if (confirm(`Are you sure you want to delete passenger ${passengerID}?`)) {
                    const form = document.createElement('form');
                    form.method = 'post';
                    form.action = 'passengersView.jsp';
                    
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'delete';
                    form.appendChild(actionInput);
                    
                    const passengerInput = document.createElement('input');
                    passengerInput.type = 'hidden';
                    passengerInput.name = 'passengerID';
                    passengerInput.value = passengerID;
                    form.appendChild(passengerInput);
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            } else {
                alert("Please select a passenger to delete.");
            }
        }

        window.onclick = function(event) {
            const modal = document.getElementById("passengerModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>