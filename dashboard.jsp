<%@ page import="java.sql.*" %>
<%@ page import="com.parking.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>

<style>

body{
    font-family: Arial;
    background-color:#f4f4f4;
}

.container{
    width:400px;
    margin:100px auto;
    text-align:center;
}

h1{
    margin-bottom:20px;
}

.stats{
    background:white;
    padding:15px;
    margin-bottom:20px;
    border-radius:8px;
}

.btn{
    display:block;
    padding:12px;
    margin:15px 0;
    text-decoration:none;
    background-color:#3498db;
    color:white;
    border-radius:5px;
}

.logout{
    background-color:#e74c3c;
}

</style>

</head>

<body>

<div class="container">

<h1>Campus Parking Management System</h1>

<%
int parked = 0;
int totalSlots = 5;
int available = 0;

try{

Connection con = DBConnection.getConnection();

Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM vehicles WHERE status='PARKED'");

if(rs.next()){
    parked = rs.getInt(1);
}

available = totalSlots - parked;

}catch(Exception e){
e.printStackTrace();
}
%>

<div class="stats">

<h3>Vehicles Currently Parked : <%= parked %></h3>

<h3>Available Slots : <%= available %></h3>

<h3>Total Slots : <%= totalSlots %></h3>

</div>

<a class="btn" href="parking.jsp">Vehicle Entry</a>

<a class="btn" href="ViewVehicleServlet">View Vehicles</a>

<a class="btn logout" href="login.html">Logout</a>

</div>

</body>
</html>