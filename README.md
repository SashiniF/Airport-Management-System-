# Airport-Management-System-
Web Project Description 
Overview
The Airport Management System (AMS) is a web-based application designed to streamline the operations of airports. It enables efficient management of flights, passengers, pilots, bookings, and associated services, enhancing user experience and operational efficiency.

Features
User Authentication: Secure login system for administrators and staff.
Flight Management: Add, modify, view, and delete flight schedules.
Passenger Management: Register passengers, view details, and manage records.
Pilot Management: Manage pilot information and flight assignments.
Appointment Scheduling: Schedule doctor and service appointments for passengers.
Billing and Payments: Handle billing for in-patient services and manage payments.
Search Functionality: Quickly search for flights, passengers, and pilot information.
Reporting: Generate and print detailed reports for flights and passengers.
Technologies Used
Frontend: HTML, CSS, JavaScript (Bootstrap, jQuery)
Backend: JSP (JavaServer Pages)
Database: MySQL
Server: Apache Tomcat or similar servlet container
Installation
Prerequisites
Java Development Kit (JDK) - Download from the Oracle website.
MySQL Database - Install MySQL server and ensure it is running.
Apache Tomcat - Download and install Apache Tomcat server.
Steps to Set Up
Clone the Repository:

bash
git clone https://github.com/yourusername/AirportManagementSystem.git
cd AirportManagementSystem

Database Setup:

Create a database named airport in MySQL.
Import the SQL scripts from the database directory to create necessary tables.
Configuration:

Update database connection details in the JSP files as needed:
URL, username, and password can be found in files like inpBill.jsp.
Deploy on Tomcat:

Place the project folder in the webapps directory of your Tomcat installation.
Start the Tomcat server using startup.bat (Windows) or startup.sh (Linux/Mac).
Access the application at http://localhost:8080/AirportManagementSystem.
Usage
Login: Enter your credentials to log in.

Admin: admin / admin@123
Staff: sashini / sashini@123
Navigation: Use the navigation menu to access various features.

Manage Appointments: Schedule appointments as needed.

Billing: Generate and manage bills for in-patient services.

Search Feature: Easily find flight or passenger details.

Log Out: Remember to log out after use.

Contribution
Contributions are welcome! Feel free to fork the repository and submit a pull request for improvements or new features.

License
This project is licensed under the MIT License.
