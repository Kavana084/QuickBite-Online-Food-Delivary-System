<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // If already logged in, skip landing page
    if (session.getAttribute("loggedInUser") != null) {
        response.sendRedirect(request.getContextPath() + "/restaurants?action=display");
        return;
    }
%>
<%
System.out.println("JSP Loaded");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuickBite — Fast Food Delivery</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Inter', sans-serif;
    background: #0d0d0d;
    color: #f5f5f5;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }

  /* Glowing background orbs */
  body::before {
    content: '';
    position: fixed;
    top: -200px;
    left: -200px;
    width: 600px;
    height: 600px;
    background: radial-gradient(circle, rgba(249,115,22,0.18), transparent 70%);
    border-radius: 50%;
    animation: float1 8s ease-in-out infinite;
    pointer-events: none;
  }
  body::after {
    content: '';
    position: fixed;
    bottom: -200px;
    right: -200px;
    width: 500px;
    height: 500px;
    background: radial-gradient(circle, rgba(234,88,12,0.12), transparent 70%);
    border-radius: 50%;
    animation: float2 10s ease-in-out infinite;
    pointer-events: none;
  }

  @keyframes float1 {
    0%, 100% { transform: translate(0, 0); }
    50% { transform: translate(60px, 40px); }
  }
  @keyframes float2 {
    0%, 100% { transform: translate(0, 0); }
    50% { transform: translate(-40px, -60px); }
  }

  .hero {
    text-align: center;
    z-index: 1;
    animation: fadeUp 0.8s ease both;
  }

  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(30px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  .emoji {
    font-size: 5rem;
    display: block;
    margin-bottom: 16px;
    animation: bounce 2s ease infinite;
  }
  @keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
  }

  h1 {
    font-size: 4.5rem;
    font-weight: 900;
    line-height: 1;
    background: linear-gradient(135deg, #f97316 0%, #fb923c 50%, #fdba74 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: -0.03em;
    margin-bottom: 16px;
  }

  .tagline {
    font-size: 1.2rem;
    color: rgba(255,255,255,0.5);
    margin-bottom: 48px;
    font-weight: 400;
  }

  .btn-group {
    display: flex;
    gap: 16px;
    justify-content: center;
    flex-wrap: wrap;
  }

  .btn-primary {
    padding: 16px 40px;
    background: linear-gradient(135deg, #f97316, #ea580c);
    border: none;
    border-radius: 14px;
    color: #fff;
    font-size: 1rem;
    font-weight: 700;
    font-family: 'Inter', sans-serif;
    text-decoration: none;
    transition: transform 0.2s, box-shadow 0.2s;
    box-shadow: 0 8px 32px rgba(249,115,22,0.3);
    letter-spacing: 0.02em;
  }
  .btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 14px 40px rgba(249,115,22,0.45);
  }

  .btn-secondary {
    padding: 16px 40px;
    background: transparent;
    border: 1.5px solid rgba(255,255,255,0.18);
    border-radius: 14px;
    color: rgba(255,255,255,0.8);
    font-size: 1rem;
    font-weight: 600;
    font-family: 'Inter', sans-serif;
    text-decoration: none;
    transition: border-color 0.2s, color 0.2s, transform 0.2s;
  }
  .btn-secondary:hover {
    border-color: #f97316;
    color: #f97316;
    transform: translateY(-3px);
  }

  .chips {
    display: flex;
    gap: 12px;
    justify-content: center;
    flex-wrap: wrap;
    margin-top: 56px;
    opacity: 0.45;
    font-size: 0.85rem;
  }
  .chips span {
    background: rgba(255,255,255,0.07);
    border-radius: 20px;
    padding: 6px 14px;
  }
  .navbar {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    padding: 24px 48px;

    display: flex;
    justify-content: space-between;
    align-items: center;

    z-index: 10;
}

.logo {
    font-size: 1.4rem;
    font-weight: 800;
    color: #f97316;
}

.nav-links {
    display: flex;
    gap: 14px;
}

.nav-btn {
    text-decoration: none;
    color: white;
    padding: 10px 20px;
    border-radius: 10px;
    font-weight: 600;
    transition: 0.2s;
    border: 1px solid rgba(255,255,255,0.15);
}

.nav-btn:hover {
    background: rgba(255,255,255,0.08);
}

.register {
    background: linear-gradient(135deg, #f97316, #ea580c);
    border: none;
}
</style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">

    <div class="logo">
        🍔 QuickBite
    </div>

    <div class="nav-links">
        <a href="Login.jsp" class="nav-btn">
            Login
        </a>

        <a href="signup.jsp" class="nav-btn register">
            Register
        </a>
    </div>

</div>

<!-- HERO SECTION -->
<div class="hero">

    <span class="emoji">🍔</span>

    <h1>QuickBite</h1>

    <p class="tagline">
        Your favourite food, delivered lightning fast 🚀
    </p>

    <div class="btn-group">

        <a href="<%= request.getContextPath() %>/home"
           class="btn-primary">

           Browse Restaurants →

        </a>

    </div>

    <div class="chips">
        <span>🍕 Pizza</span>
        <span>🍜 Noodles</span>
        <span>🍛 Biryani</span>
        <span>🍔 Burgers</span>
        <span>🥗 Salads</span>
        <span>☕ Coffee</span>
    </div>

</div>
</body>
</html>