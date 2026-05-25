<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.User" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.daoImpl.MenuDaoImpl" %>
<%
    // Session guard
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    List<Menu>   menuList   = (List<Menu>)   request.getAttribute("menuList");
    Restaurant   restaurant = (Restaurant)   request.getAttribute("restaurant");
    String       restName   = (restaurant != null) ? restaurant.getName() : "Restaurant";
    String       restCuisine= (restaurant != null) ? restaurant.getCuisineType() : "";
    List<CartItem> cart     = (List<CartItem>) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuickBite — <%= restName %> Menu</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Inter', sans-serif;
    background: #0d0d0d;
    color: #f5f5f5;
    min-height: 100vh;
  }

  /* ── NAVBAR ── */
  nav {
    position: sticky;
    top: 0;
    z-index: 100;
    background: rgba(13,13,13,0.88);
    backdrop-filter: blur(16px);
    border-bottom: 1px solid rgba(255,255,255,0.06);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    height: 64px;
  }
  .nav-brand {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 1.4rem;
    font-weight: 800;
    background: linear-gradient(90deg, #f97316, #fb923c);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
  .nav-brand span { font-size: 1.6rem; }
  .nav-right { display: flex; align-items: center; gap: 16px; }
  .btn-back {
    padding: 8px 18px;
    background: transparent;
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 8px;
    color: rgba(255,255,255,0.7);
    font-size: 0.82rem;
    font-weight: 600;
    font-family: 'Inter', sans-serif;
    cursor: pointer;
    text-decoration: none;
    transition: border-color 0.2s, color 0.2s;
  }
  .btn-back:hover { border-color: #f97316; color: #f97316; }
  .btn-logout {
    padding: 8px 18px;
    background: transparent;
    border: 1px solid rgba(249,115,22,0.4);
    border-radius: 8px;
    color: #f97316;
    font-size: 0.82rem;
    font-weight: 600;
    font-family: 'Inter', sans-serif;
    cursor: pointer;
    text-decoration: none;
    transition: background 0.2s;
  }
  .btn-logout:hover { background: rgba(249,115,22,0.1); }

  /* ── RESTAURANT HERO ── */
  .rest-hero {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 32px 28px;
    border-bottom: 1px solid rgba(255,255,255,0.06);
  }
  .rest-hero h2 {
    font-size: 2.2rem;
    font-weight: 800;
    margin-bottom: 6px;
  }
  .rest-hero p {
    color: rgba(255,255,255,0.45);
    font-size: 0.9rem;
  }
  .rest-meta {
    display: flex;
    gap: 20px;
    margin-top: 14px;
    flex-wrap: wrap;
  }
  .rest-meta .pill {
    background: rgba(255,255,255,0.06);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 20px;
    padding: 6px 14px;
    font-size: 0.8rem;
    color: rgba(255,255,255,0.6);
    display: flex;
    align-items: center;
    gap: 6px;
  }

  /* ── SECTION LABEL ── */
  .section-label {
    max-width: 1200px;
    margin: 32px auto 0;
    padding: 0 32px 16px;
    font-size: 1.15rem;
    font-weight: 700;
    color: rgba(255,255,255,0.8);
    border-bottom: 2px solid rgba(249,115,22,0.3);
    display: inline-flex;
    align-items: center;
    gap: 8px;
  }

  /* ── MENU GRID ── */
  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
    gap: 22px;
    max-width: 1200px;
    margin: 28px auto 60px;
    padding: 0 32px;
  }

  /* ── MENU CARD ── */
  .menu-card {
    background: #1a1a1a;
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 18px;
    overflow: hidden;
    transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
    display: flex;
    flex-direction: column;
  }
  .menu-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 18px 44px rgba(0,0,0,0.5);
    border-color: rgba(249,115,22,0.25);
  }

  .menu-img-wrap {
    height: 175px;
    overflow: hidden;
    position: relative;
  }
  .menu-img-wrap img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.35s;
  }
  .menu-card:hover .menu-img-wrap img { transform: scale(1.05); }

  .avail-badge {
    position: absolute;
    top: 10px;
    left: 10px;
    background: rgba(34,197,94,0.85);
    border-radius: 6px;
    padding: 3px 9px;
    font-size: 0.7rem;
    font-weight: 700;
    color: #fff;
    letter-spacing: 0.05em;
  }
  .unavail-badge {
    position: absolute;
    top: 10px;
    left: 10px;
    background: rgba(239,68,68,0.8);
    border-radius: 6px;
    padding: 3px 9px;
    font-size: 0.7rem;
    font-weight: 700;
    color: #fff;
    letter-spacing: 0.05em;
  }

  .rating-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background: rgba(0,0,0,0.65);
    backdrop-filter: blur(6px);
    border-radius: 20px;
    padding: 4px 9px;
    font-size: 0.75rem;
    font-weight: 600;
    color: #facc15;
  }

  .menu-body {
    padding: 16px 18px 20px;
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  .menu-name {
    font-size: 1rem;
    font-weight: 700;
    margin-bottom: 6px;
  }
  .menu-desc {
    font-size: 0.8rem;
    color: rgba(255,255,255,0.45);
    line-height: 1.5;
    flex: 1;
    margin-bottom: 14px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
  .menu-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-top: 1px solid rgba(255,255,255,0.06);
    padding-top: 12px;
  }
  .menu-price {
    font-size: 1.1rem;
    font-weight: 800;
    color: #f97316;
  }
  .btn-add {
    background: linear-gradient(135deg, #f97316, #ea580c);
    border: none;
    border-radius: 8px;
    color: #fff;
    font-size: 0.8rem;
    font-weight: 700;
    font-family: 'Inter', sans-serif;
    padding: 8px 16px;
    cursor: pointer;
    transition: transform 0.15s, box-shadow 0.15s;
  }
  .btn-add:hover {
    transform: scale(1.05);
    box-shadow: 0 4px 14px rgba(249,115,22,0.4);
  }

  /* ── EMPTY STATE ── */
  .empty {
    grid-column: 1 / -1;
    text-align: center;
    padding: 80px 24px;
    color: rgba(255,255,255,0.3);
  }
  .empty .icon { font-size: 3.5rem; display: block; margin-bottom: 14px; }
  .empty p { font-size: 1rem; }

  /* ── QUANTITY CONTROLLER ── */
  .quantity-controller {
    display: inline-flex;
    align-items: center;
    background: #221a15;
    border: 1px solid #f97316;
    border-radius: 8px;
    overflow: hidden;
    height: 34px;
  }
  .qty-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 32px;
    height: 100%;
    background: transparent;
    color: #f97316;
    font-size: 1.1rem;
    font-weight: 700;
    text-decoration: none;
    transition: background 0.2s, color 0.2s;
  }
  .qty-btn:hover {
    background: #f97316;
    color: #fff;
  }
  .qty-val {
    padding: 0 8px;
    font-weight: 700;
    color: #fff;
    font-size: 0.9rem;
    min-width: 22px;
    text-align: center;
  }

  /* ── CART BUTTON ── */
  .btn-cart {
    padding: 8px 18px;
    background: #f97316;
    border: none;
    border-radius: 8px;
    color: #fff;
    font-size: 0.82rem;
    font-weight: 700;
    font-family: 'Inter', sans-serif;
    cursor: pointer;
    text-decoration: none;
    transition: background 0.2s, transform 0.2s;
    display: flex;
    align-items: center;
    gap: 6px;
  }
  .btn-cart:hover {
    background: #ea580c;
    transform: translateY(-1px);
  }

  /* ── CART POPUP BAR ── */
  .cart-popup-bar {
    position: fixed;
    bottom: 24px;
    left: 50%;
    transform: translateX(-50%);
    width: 90%;
    max-width: 550px;
    background: linear-gradient(135deg, #f97316, #ea580c);
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(234, 88, 12, 0.4);
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 20px;
    z-index: 1000;
    animation: slideUp 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  }
  @keyframes slideUp {
    from {
      transform: translate(-50%, 100px);
      opacity: 0;
    }
    to {
      transform: translate(-50%, 0);
      opacity: 1;
    }
  }
  .cart-popup-info {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  .cart-popup-count {
    font-size: 0.85rem;
    font-weight: 500;
    color: rgba(255, 255, 255, 0.8);
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }
  .cart-popup-price {
    font-size: 1.15rem;
    font-weight: 800;
    color: #fff;
  }
  .cart-popup-action {
    background: #fff;
    color: #ea580c;
    border-radius: 8px;
    padding: 10px 18px;
    font-size: 0.88rem;
    font-weight: 700;
    text-decoration: none;
    transition: transform 0.2s, box-shadow 0.2s;
  }
  .cart-popup-action:hover {
    transform: scale(1.03);
    box-shadow: 0 4px 12px rgba(255, 255, 255, 0.35);
  }
</style>
</head>
<body>

<!-- NAVBAR -->
<nav>
  <div class="nav-brand"><span>🍔</span> QuickBite</div>
  <div class="nav-right">
    <a href="<%= request.getContextPath() %>/restaurants?action=display" class="btn-back">← All Restaurants</a>
    <%
      int cartSize = 0;
      if (cart != null) {
          for (CartItem ci : cart) {
              cartSize += ci.getQuantity();
          }
      }
    %>
    <a href="<%= request.getContextPath() %>/cart" class="btn-cart">🛒 Cart (<%= cartSize %>)</a>
    <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn-logout">Logout</a>
  </div>
</nav>

<!-- RESTAURANT INFO -->
<div class="rest-hero">
  <h2><%= restName %></h2>
  <% if (restaurant != null) { %>
  <p><%= restaurant.getAddress() %></p>
  <div class="rest-meta">
    <div class="pill">🍽️ <%= restCuisine %></div>
    <div class="pill">⭐ <%= String.format("%.1f", restaurant.getRatings()) %></div>
    <div class="pill">🕐 <%= restaurant.getEta() %> mins delivery</div>
  </div>
  <% } %>
</div>

<!-- SECTION LABEL -->
<div style="max-width:1200px; margin:0 auto; padding:0 32px;">
  <div class="section-label">🍴 Menu</div>
</div>

<!-- MENU GRID -->
<div class="grid">
<%
  if (menuList == null || menuList.isEmpty()) {
%>
  <div class="empty">
    <span class="icon">🍽️</span>
    <p>No menu items available for this restaurant yet.</p>
  </div>
<%
  } else {
    for (Menu m : menuList) {
      String imgSrc = (m.getImgPath() != null && !m.getImgPath().isEmpty())
                      ? m.getImgPath()
                      : "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&q=80";
      String desc = (m.getDescription() != null && !m.getDescription().isEmpty())
                    ? m.getDescription() : "Delicious dish, freshly prepared.";
%>
  <div class="menu-card">
    <div class="menu-img-wrap">
      <img src="<%= request.getContextPath() + "/" + m.getImgPath() %>" />
      <% if (m.isAvailable()) { %>
        <span class="avail-badge">✓ Available</span>
      <% } else { %>
        <span class="unavail-badge">Unavailable</span>
      <% } %>
      <span class="rating-badge">⭐ <%= String.format("%.1f", m.getRatings()) %></span>
    </div>
    <div class="menu-body">
      <div class="menu-name"><%= m.getName() %></div>
      <div class="menu-desc"><%= desc %></div>
      <div class="menu-footer">
        <span class="menu-price">₹<%= String.format("%.0f", m.getPrice()) %></span>
        <% if (m.isAvailable()) {
             int itemQty = 0;
             if (cart != null) {
                 for (CartItem ci : cart) {
                     if (ci.getMenuId() == m.getMenuId()) {
                         itemQty = ci.getQuantity();
                         break;
                     }
                 }
             }
             if (itemQty == 0) {
        %>
          <a href="add-to-cart?menuId=<%=m.getMenuId()%>&restaurantId=<%=restaurant.getRestaurantId()%>&redirect=menu" style="text-decoration: none;">
            <button class="btn-add">+ Add</button>
          </a>
        <%   } else { %>
          <div class="quantity-controller">
            <a href="cart?action=update&menuId=<%=m.getMenuId()%>&qty=-1&restaurantId=<%=restaurant.getRestaurantId()%>" class="qty-btn">-</a>
            <span class="qty-val"><%= itemQty %></span>
            <a href="cart?action=update&menuId=<%=m.getMenuId()%>&qty=1&restaurantId=<%=restaurant.getRestaurantId()%>" class="qty-btn">+</a>
          </div>
        <%   }
           }
        %>
      </div>
    </div>
  </div>
<%
    }
  }
%>

 
<%
%>
</div>

<%
    int totalCartItems = 0;
    double totalCartPrice = 0.0;
    if (cart != null && !cart.isEmpty()) {
        MenuDaoImpl menuDao = new MenuDaoImpl();
        for (CartItem ci : cart) {
            Menu mItem = menuDao.getMenu(ci.getMenuId());
            if (mItem != null) {
                totalCartItems += ci.getQuantity();
                totalCartPrice += mItem.getPrice() * ci.getQuantity();
            }
        }
    }
    if (totalCartItems > 0) {
%>
  <div class="cart-popup-bar">
    <div class="cart-popup-info">
      <span class="cart-popup-count"><%= totalCartItems %> Item<%= totalCartItems > 1 ? "s" : "" %> Added</span>
      <span class="cart-popup-price">₹<%= String.format("%.0f", totalCartPrice) %></span>
    </div>
    <a href="<%= request.getContextPath() %>/cart" class="cart-popup-action">
      View Cart 🛒
    </a>
  </div>
<% } %>

</body>
</html>
