<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String passengerID = request.getParameter("passengerID");
    String name = request.getParameter("passengerName");
    String passportNumber = request.getParameter("passportNumber");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airport", "root", "@Sashini123");
        String sql = "INSERT INTO passengers (passengerID, passengerName, passportNumber, email, phone) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, passengerID);
        pstmt.setString(2, name);
        pstmt.setString(3, passportNumber);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        
        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            response.sendRedirect("passengerView.jsp?message=success");
        } else {
            response.sendRedirect("passengerView.jsp?message=error");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("passengerView.jsp?message=error");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>