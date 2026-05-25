<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.User" %>
<%@ page import="com.tap.model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QuickBite</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial, sans-serif;
    background:#f5f5f5;
}

/* HEADER */

.header{
    background:#ff5a5f;
    color:white;
    padding:15px 40px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.logo{
    font-size:28px;
    font-weight:bold;
}

.nav a{
    color:white;
    text-decoration:none;
    margin-left:20px;
    font-size:18px;
}

/* SEARCH */

.search-section{
    text-align:center;
    padding:30px;
}

.search-section h1{
    margin-bottom:20px;
}

.search-box{
    width:50%;
    padding:12px;
    border:none;
    border-radius:8px;
    font-size:16px;
}

/* RESTAURANTS */

.container{
    display:flex;
    flex-wrap:wrap;
    gap:25px;
    justify-content:center;
    padding:20px;
}

.card{
    width:260px;
    background:white;
    border-radius:12px;
    overflow:hidden;
    box-shadow:0 2px 10px rgba(0,0,0,0.2);
    transition:0.3s;
}

.card:hover{
    transform:scale(1.03);
}

.card img{
    width:100%;
    height:180px;
    object-fit:cover;
}

.card-content{
    padding:15px;
}

.card-content h2{
    margin-bottom:10px;
}

.card-content p{
    margin:5px 0;
    color:#555;
}

a{
    text-decoration:none;
    color:black;
}

</style>
</head>

<body>

<!-- HEADER -->

<div class="header">

    <div class="logo">
        QuickBite
    </div>

    <div class="nav">
        <% if (session.getAttribute("loggedInUser") != null) { %>
            <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                int cartSize = 0;
                if (cart != null) {
                    for (CartItem ci : cart) {
                        cartSize += ci.getQuantity();
                    }
                }
            %>
            <a href="cart" style="font-weight: bold; color: #ffeb3b;">🛒 Cart (<%= cartSize %>)</a>
            <a href="LogoutServlet" style="color: #ffc107;">Logout</a>
        <% } else { %>
            <a href="Login.jsp">Login</a>
            <a href="signup.jsp">Register</a>
        <% } %>
    </div>

</div>

<!-- SEARCH -->

<div class="search-section">

    <h1>Top Restaurants</h1>

    <input type="text"
           placeholder="Search Restaurants..."
           class="search-box">

</div>

<!-- RESTAURANTS -->
<%
User user = (User)session.getAttribute("loggedInUser");

if(user != null){
%>

<h2 style="text-align:center;">
    Welcome, <%=user.getName()%>
</h2>

<%
}
%>

<div class="container">

<%
ArrayList<Restaurant> restaurantList = (ArrayList<Restaurant>) request.getAttribute("restaurantList");
if (restaurantList == null) {
    restaurantList = new com.tap.daoImpl.RestaurantDaoImpl().getAllRestaurants();
}

if (restaurantList == null || restaurantList.isEmpty()) {
%>
    <div style="text-align: center; padding: 60px 20px; width: 100%; color: #666; font-family: Arial, sans-serif;">
        <span style="font-size: 3.5rem; display: block; margin-bottom: 15px;">🍽️</span>
        <h3>No Restaurants Available</h3>
        <p style="margin-top: 8px; font-size: 0.95rem;">Please run the DataSeeder class in Eclipse to populate the database tables.</p>
    </div>
<%
} else {
    for(Restaurant r : restaurantList){
%>
        <a href="menu?restaurantId=<%=r.getRestaurantId()%>">
            <div class="card">
                <img src="<%=r.getImgPath()%>">
                <div class="card-content">
                    <h2><%=r.getName()%></h2>
                    <p>⭐ <%=r.getRatings()%></p>
                    <p><%=r.getCuisineType()%></p>
                </div>
            </div>
        </a>
<%
    }
}
%>

</div>

</body>
</html>