<%@ page import="java.sql.*" %>
<%@ page import="com.parking.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Parking Registration</title>

<style>

body{
font-family: Arial;
background:#f4f6f9;
}

.container{
width:420px;
margin:100px auto;
background:white;
padding:30px;
text-align:center;
border-radius:12px;
box-shadow:0 4px 15px rgba(0,0,0,0.1);
}

input,select{
width:90%;
padding:10px;
margin:10px;
border-radius:6px;
border:1px solid #ccc;
}

button{
padding:10px 20px;
background:#3498db;
color:white;
border:none;
border-radius:6px;
cursor:pointer;
}

button:hover{
background:#2980b9;
}

table{
width:100%;
border-collapse:collapse;
margin-top:10px;
}

th{
background:#3498db;
color:white;
padding:10px;
}

td{
padding:10px;
font-weight:500;
}

.available{
color:#27ae60;
background:#eafaf1;
border-radius:20px;
padding:5px 12px;
}

.occupied{
color:#e74c3c;
background:#fdecea;
border-radius:20px;
padding:5px 12px;
}

</style>

</head>

<body>

<div class="container">

<h2>Parking Registration</h2>
<h3>Parking Slot Status</h3>

<table border="1" cellpadding="8">

<tr>
<th>Slot</th>
<th>Status</th>
</tr>

<%
String slots[]={"P01","P02","P03","P04","P05"};

for(String s:slots){

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM vehicles WHERE parking_slot=? AND status='PARKED'");

ps.setString(1,s);

ResultSet rs = ps.executeQuery();

if(rs.next()){
%>

<tr>
<td><%=s%></td>
<td><span class="occupied">Occupied</span></td>
</tr>

<%
}else{
%>

<tr>
<td><%=s%></td>
<td><span class="available">Available</span></td>
</tr>

<%
}

}
%>

</table>

<br><br>

<form method="post">

Owner Name<br>
<input type="text" name="owner_name" required>

Vehicle Number<br>
<input type="text" name="vehicle_number" required>

Vehicle Type<br>
<select name="vehicle_type">
<option>Car</option>
<option>Bike</option>
<option>EV</option>
</select>

Parking Slot<br>
<select name="parking_slot">
<option>P01</option>
<option>P02</option>
<option>P03</option>
<option>P04</option>
<option>P05</option>
</select>

<br>

<button type="submit">Allot Parking</button>

</form>

<%

String owner=request.getParameter("owner_name");
String vehicle=request.getParameter("vehicle_number");
String type=request.getParameter("vehicle_type");
String slot=request.getParameter("parking_slot");

if(owner!=null){

try{

Connection con=DBConnection.getConnection();

String check="SELECT * FROM vehicles WHERE parking_slot=? AND status='PARKED'";

PreparedStatement ps1=con.prepareStatement(check);
ps1.setString(1,slot);

ResultSet rs=ps1.executeQuery();

if(rs.next()){

out.println("<h3 style='color:red'>Slot Already Occupied</h3>");

}else{

String sql="INSERT INTO vehicles(owner_name,vehicle_number,vehicle_type,parking_slot,entry_time,status) VALUES(?,?,?,?,NOW(),'PARKED')";

PreparedStatement ps=con.prepareStatement(sql);

ps.setString(1,owner);
ps.setString(2,vehicle);
ps.setString(3,type);
ps.setString(4,slot);

ps.executeUpdate();

out.println("<h3 style='color:green'>Parking Allotted Successfully</h3>");

}

}catch(Exception e){
out.println(e);
}

}

%>

<br>

<a href="ViewVehicleServlet">View Vehicles</a>

<br><br>

<a href="dashboard.jsp">Back to DashBoard</a>

</div>

</body>
</html>