<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.daoImpl.MenuDaoImpl" %>
<%@ page import="com.tap.model.Menu" %>

<%
MenuDaoImpl menuDao = new MenuDaoImpl();
%>
<%
List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
double total = 0;
int restaurantId = 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>Your Cart</title>

<style>
body {
    font-family: Arial;
    background: #0d0d0d;
    color: white;
    margin: 0;
}

.container {
    width: 70%;
    margin: auto;
    padding: 30px;
}

.cart-card {
    background: #1a1a1a;
    padding: 15px;
    margin-bottom: 15px;
    border-radius: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.name {
    font-size: 18px;
    font-weight: bold;
}

.price {
    color: orange;
}

.btn {
    padding: 6px 10px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}

.delete {
    background: #e11d48;
    color: white;
    transition: background 0.2s;
}

.delete:hover {
    background: #be123c;
}

.qty-btn:hover {
    background: #f97316;
    color: #fff !important;
}

.bottom {
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
}

.link-btn {
    padding: 10px 15px;
    background: orange;
    color: black;
    text-decoration: none;
    border-radius: 8px;
    font-weight: bold;
}
</style>

</head>

<body>
  <div class="container">

<h2>Your Cart</h2>

<%
if (cart == null || cart.isEmpty()) {
%>

<p>Cart is empty</p>

<%
} else {

    for (CartItem item : cart) {

        Menu menu = menuDao.getMenu(item.getMenuId());
        
        if(menu != null){
        	restaurantId = menu.getRestaurantID();
            total += menu.getPrice() * item.getQuantity();
%>

<div class="cart-card">
    <div>
        <div class="name"><%= menu.getName() %></div>
        <div class="price">₹<%= menu.getPrice() %></div>
    </div>

    <div style="display: flex; align-items: center; gap: 16px;">
        <!-- Quantity Selector -->
        <div style="display: inline-flex; align-items: center; border: 1px solid #f97316; border-radius: 8px; overflow: hidden; background: #221a15; height: 36px;">
            <a class="qty-btn" href="cart?action=update&menuId=<%=menu.getMenuId()%>&qty=-1" style="display: flex; align-items: center; justify-content: center; width: 32px; height: 100%; color: #f97316; text-decoration: none; font-weight: bold; font-size: 1.1rem; transition: background 0.2s, color 0.2s;">-</a>
            <span style="padding: 0 10px; font-weight: bold; color: white; min-width: 20px; text-align: center;"><%= item.getQuantity() %></span>
            <a class="qty-btn" href="cart?action=update&menuId=<%=menu.getMenuId()%>&qty=1" style="display: flex; align-items: center; justify-content: center; width: 32px; height: 100%; color: #f97316; text-decoration: none; font-weight: bold; font-size: 1.1rem; transition: background 0.2s, color 0.2s;">+</a>
        </div>
        <!-- Remove Button -->
        <a class="btn delete" href="cart?action=delete&menuId=<%=menu.getMenuId()%>" style="padding: 8px 16px; border-radius: 8px; text-decoration: none; font-size: 0.88rem; display: inline-block;">Remove</a>
    </div>
</div>

<%
        }
    }
}
%>

<h3>Total: ₹<%= total %></h3>

<div class="bottom">
    <a class="link-btn"
       href="<%=request.getContextPath()%>/menu?restaurantId=<%=restaurantId %>">
       Add More Items
    </a>
   <%
session.setAttribute("total", total);
%>
    <a class="link-btn" href="checkout.jsp">
       Proceed to Checkout
    </a>
</div>

</div>
</body>
</html>