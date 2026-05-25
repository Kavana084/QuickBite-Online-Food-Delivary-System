<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.daoImpl.MenuDaoImpl" %>
<%@ page import="com.tap.model.Menu" %>
<%
    List<CartItem> orderedItems = (List<CartItem>) session.getAttribute("orderedItems");
    Double total = (Double) session.getAttribute("total");
    if (total == null) {
        total = 0.0;
    }
    MenuDaoImpl menuDao = new MenuDaoImpl();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Placed Successfully | QuickBite</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: 'Inter', sans-serif;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: #0d0d0d;
    color: #f5f5f5;
    padding: 20px;
  }
  .success-card {
    width: 100%;
    max-width: 500px;
    background: #1a1a1a;
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 24px;
    padding: 35px;
    text-align: center;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
  }
  .icon-check {
    font-size: 4rem;
    color: #22c55e;
    margin-bottom: 16px;
    display: block;
    animation: scaleIn 0.5s cubic-bezier(0.16, 1, 0.3, 1) both;
  }
  @keyframes scaleIn {
    from { transform: scale(0.5); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
  }
  h1 {
    font-size: 1.8rem;
    font-weight: 800;
    color: #fff;
    margin-bottom: 8px;
  }
  .thank-you {
    color: #a3a3a3;
    font-size: 0.95rem;
    margin-bottom: 28px;
  }
  .order-summary {
    background: #262626;
    border-radius: 16px;
    padding: 20px;
    text-align: left;
    margin-bottom: 28px;
    border: 1px solid rgba(255,255,255,0.03);
  }
  .summary-title {
    font-size: 0.85rem;
    font-weight: 700;
    color: #f97316;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    margin-bottom: 14px;
    border-bottom: 1px solid rgba(255,255,255,0.06);
    padding-bottom: 8px;
  }
  .summary-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;
    font-size: 0.9rem;
  }
  .item-name {
    font-weight: 500;
    color: #e5e5e5;
  }
  .item-qty {
    color: #a3a3a3;
    margin-left: 8px;
    font-size: 0.85rem;
  }
  .item-price {
    font-weight: 600;
    color: #fff;
  }
  .total-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid rgba(255,255,255,0.06);
    padding-top: 12px;
    margin-top: 8px;
    font-weight: 700;
    font-size: 1.1rem;
  }
  .total-label {
    color: #fff;
  }
  .total-price {
    color: #f97316;
  }
  .btn-confirm {
    display: block;
    width: 100%;
    padding: 14px;
    border: none;
    border-radius: 12px;
    background: linear-gradient(135deg, #f97316, #ea580c);
    color: white;
    font-size: 1rem;
    font-weight: 700;
    cursor: pointer;
    text-decoration: none;
    transition: transform 0.2s, box-shadow 0.2s;
    box-shadow: 0 4px 14px rgba(249, 115, 22, 0.3);
    margin-bottom: 12px;
    text-align: center;
  }
  .btn-confirm:hover {
    transform: translateY(-1px);
    box-shadow: 0 6px 20px rgba(249, 115, 22, 0.45);
  }
</style>
</head>
<body>
  <div class="success-card">
    <span class="icon-check">✓</span>
    <h1>Thank You for Your Order!</h1>
    <p class="thank-you">Your order has been received and is being processed.</p>
    
    <div class="order-summary">
      <div class="summary-title">Order Summary</div>
      <%
        if (orderedItems != null && !orderedItems.isEmpty()) {
            for (CartItem item : orderedItems) {
                Menu menu = menuDao.getMenu(item.getMenuId());
                if (menu != null) {
      %>
        <div class="summary-item">
          <div>
            <span class="item-name"><%= menu.getName() %></span>
            <span class="item-qty">x<%= item.getQuantity() %></span>
          </div>
          <span class="item-price">₹<%= String.format("%.0f", menu.getPrice() * item.getQuantity()) %></span>
        </div>
      <%
                }
            }
        } else {
      %>
        <p style="color: #a3a3a3; font-size: 0.9rem;">No items found.</p>
      <%
        }
      %>
      <div class="total-row">
        <span class="total-label">Total Paid</span>
        <span class="total-price">₹<%= String.format("%.0f", total) %></span>
      </div>
    </div>
    
    <a href="orderTracking.jsp" class="btn-confirm">
      Confirm & Track Order →
    </a>
  </div>
</body>
</html>