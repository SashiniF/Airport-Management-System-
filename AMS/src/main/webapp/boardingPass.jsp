<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Boarding Pass</title>
    <style>
        body { 
            margin: 0; 
            padding: 0; 
            font-family: Arial; 
            background: #f5f5f5;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            overflow: hidden;
        }
        .boarding-pass {
            width: 950px; /* Reduced width */
            height: 420px; /* Fixed height */
            border: 2px solid #003c71;
            border-radius: 10px;
            overflow: hidden;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            position: relative;
        }
        .header {
            background: #003c71;
            color: white;
            padding: 15px;
            text-align: center;
            position: relative;
        }
        .airline-logo {
            position: absolute;
            right: 15px;
            top: 15px;
            height: 40px;
        }
        .passenger-info {
            display: flex;
            align-items: center; /* Center items vertically */
            padding: 15px;
        }
        .info-section {
            flex: 1;
            padding: 0 10px;
            text-align: center; /* Center text in sections */
        }
        .info-label {
            font-size: 14px; /* Increased font size */
            color: #0056b3; /* New color for labels */
            margin-bottom: 3px;
        }
        .info-value {
            font-size: 16px; /* Increased font size */
            font-weight: bold;
            color: black; /* New color for values */
            margin-bottom: 10px;
        }
        .barcode {
            text-align: center;
            padding: 15px;
            background: #f9f9f9;
            font-family: 'Libre Barcode 128';
            font-size: 48px; /* Font size */
            position: absolute;
            right: 30px; /* Adjusted to move it more to the right */
            top: 60%; /* Adjusted to move it down */
            transform: translateY(-50%) rotate(90deg); /* Rotate 90 degrees */
            white-space: nowrap; /* Prevent wrapping */
        }
        .flight-info {
            padding: 0 15px 15px;
        }
        .print-btn {
            margin-top: 20px;
            background: #003c71;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        @media print {
            .print-btn {
                display: none;
            }
            body {
                height: auto;
                overflow: visible;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Libre+Barcode+128&display=swap" rel="stylesheet">
</head>
<body>
    <%
    // Database connection and query logic
    String passengerID = request.getParameter("passengerID");
    String flightNumber = request.getParameter("flightNumber");
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
        
        // Get passenger details
        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM passengers WHERE passengerID = ?");
        pstmt.setString(1, passengerID);
        ResultSet rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            out.println("<div style='color:red;text-align:center;'>Passenger not found</div>");
            return;
        }
        
        String passengerName = rs.getString("passengerName");
        String passportNumber = rs.getString("passportNumber");
        
        // Generate random gate number
        String[] gates = {"A1", "A2", "B1", "B2", "C1", "C2", "D1", "D2"};
        String randomGate = gates[(int)(Math.random() * gates.length)];
        
        // Generate random seat number
        String randomSeat = (int)(Math.random() * 30 + 1) + "" + (char)(Math.random() * 6 + 'A');
        
        // Generate random departure time
        int randomHour = (int)(Math.random() * 12) + 1; // 1 to 12
        String randomMinute = String.format("%02d", (int)(Math.random() * 60)); // 00 to 59
        String randomDepartureTime = randomHour + ":" + randomMinute + (Math.random() < 0.5 ? " AM" : " PM");
        
        // Get flight details
        pstmt = conn.prepareStatement("SELECT fd.* FROM FlightDetails fd WHERE fd.flight_number = ?");
        pstmt.setString(1, flightNumber);
        rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            out.println("<div style='color:red;text-align:center;'>Flight not found</div>");
            return;
        }
        
        // Format dates
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy");
    %>
    
    <div class="boarding-pass">
        <div class="header">
            <img src="${pageContext.request.contextPath}/img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo" class="airline-logo">
            <h2>BOARDING PASS</h2>
            <p><%= flightNumber %></p>
        </div>
        
        <div class="passenger-info">
            <div class="info-section">
                <div class="info-label">PASSENGER</div>
                <div class="info-value"><%= passengerName %></div>
                
                <div class="info-label">FROM</div>
                <div class="info-value"><%= rs.getString("departure") %></div>
            </div>
            
            <div style="text-align: center; padding: 10px 20px 0;">
                <img src="${pageContext.request.contextPath}/img/flight.svg" alt="Flight Icon" style="width: 50px; height: auto;" />
            </div> <!-- Flight SVG image -->

            <div class="info-section">
                <div class="info-label">PASSPORT</div>
                <div class="info-value"><%= passportNumber %></div>
                
                <div class="info-label">TO</div>
                <div class="info-value"><%= rs.getString("arrival") %></div>
            </div>
        </div>
        
        <div class="flight-info">
            <div class="passenger-info">
                <div class="info-section">
                    <div class="info-label">DATE</div>
                    <div class="info-value"><%= dateFormat.format(rs.getDate("flight_date")) %></div>
                    
                    <div class="info-label">GATE</div>
                    <div class="info-value"><%= randomGate %></div>
                </div>
                
                <div class="info-section">
                    <div class="info-label">DEPARTS</div>
                    <div class="info-value"><%= randomDepartureTime %></div>
                    
                    <div class="info-label">SEAT</div>
                    <div class="info-value"><%= randomSeat %></div>
                </div>
            </div>
        </div>
        
        <div class="barcode">
            *BP<%= (int)(Math.random()*1000000) %>*
        </div>
    </div>
    
    <button class="print-btn" onclick="window.print()">Print Boarding Pass</button>
    
    <%
        conn.close();
    } catch (Exception e) {
        out.println("<div style='color:red;text-align:center;'>Error loading boarding pass</div>");
    }
    %>
</body>
</html>