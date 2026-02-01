<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .report-header {
            display: flex;
            align-items: center;
            justify-content: space-between; /* Distributes space between items */
            margin-bottom: 20px;
        }
        .report-logo {
            max-width: 150px; /* Increased size for the logo */
            margin-right: 20px;
        }
        .header-content {
            text-align: center; /* Center the title and date */
            flex-grow: 1; /* Allow this section to grow and take space */
        }
        .report-title {
            color: #003c71;
            margin-bottom: 5px;
        }
        .report-date {
            color: #666;
            font-size: 0.9em;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #003c71;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .action-buttons {
            margin-top: 20px;
            text-align: center;
        }
        .btn {
            padding: 8px 15px;
            margin: 0 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-print {
            background-color: #003c71;
            color: white;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        @media print {
            .action-buttons {
                display: none;
            }
            body {
                margin: 0;
                padding: 0;
            }
        }
    </style>
</head>
<body>
    <div class="report-header">
        <img src="img/airSRILANKA logo.jpeg" alt="Air Sri Lanka Logo" class="report-logo">
        <div class="header-content">
            <h1 class="report-title">Pilot Report</h1>
            <div class="report-date">Generated on: <%= new java.util.Date() %></div>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>Pilot ID</th>
                <th>Name</th>
                <th>License Number</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Flight Number</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM Pilots");
                    
                    while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("pilotID") %></td>
                <td><%= rs.getString("pilotName") %></td>
                <td><%= rs.getString("licenseNumber") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("flightNumber") %></td>
            </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>

    <div class="action-buttons">
        <button class="btn btn-print" onclick="window.print()">Print Report</button>
        <a href="admin.jsp" class="btn btn-back">Back to Dashboard</a>
    </div>
</body>
</html>