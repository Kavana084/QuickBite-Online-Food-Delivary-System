<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuickBite — Login</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Inter', sans-serif;
    min-height: 100vh;
    background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .card {
    background: rgba(255,255,255,0.06);
    backdrop-filter: blur(20px);
    border: 1px solid rgba(255,255,255,0.12);
    border-radius: 24px;
    padding: 48px 40px;
    width: 100%;
    max-width: 420px;
    box-shadow: 0 24px 64px rgba(0,0,0,0.4);
  }

  .logo {
    text-align: center;
    margin-bottom: 32px;
  }
  .logo .icon {
    font-size: 3rem;
    display: block;
    margin-bottom: 8px;
  }
  .logo h1 {
    font-size: 2rem;
    font-weight: 800;
    background: linear-gradient(90deg, #f97316, #fb923c);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
  .logo p {
    color: rgba(255,255,255,0.5);
    font-size: 0.875rem;
    margin-top: 4px;
  }

  .error-box {
    background: rgba(239,68,68,0.15);
    border: 1px solid rgba(239,68,68,0.4);
    border-radius: 10px;
    color: #fca5a5;
    padding: 12px 16px;
    font-size: 0.875rem;
    margin-bottom: 20px;
    text-align: center;
  }

  .form-group { margin-bottom: 20px; }

  label {
    display: block;
    color: rgba(255,255,255,0.7);
    font-size: 0.8rem;
    font-weight: 600;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    margin-bottom: 8px;
  }

  input[type="text"], input[type="password"] {
    width: 100%;
    padding: 14px 16px;
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 12px;
    color: #fff;
    font-size: 0.95rem;
    font-family: 'Inter', sans-serif;
    outline: none;
    transition: border-color 0.2s, background 0.2s;
  }
  input[type="text"]:focus, input[type="password"]:focus {
    border-color: #f97316;
    background: rgba(249,115,22,0.08);
  }
  input::placeholder { color: rgba(255,255,255,0.3); }

  .btn-login {
    width: 100%;
    padding: 15px;
    background: linear-gradient(135deg, #f97316, #ea580c);
    border: none;
    border-radius: 12px;
    color: #fff;
    font-size: 1rem;
    font-weight: 700;
    font-family: 'Inter', sans-serif;
    cursor: pointer;
    transition: transform 0.15s, box-shadow 0.15s;
    margin-top: 8px;
    letter-spacing: 0.03em;
  }
  .btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(249,115,22,0.4);
  }
  .btn-login:active { transform: translateY(0); }

  .footer-link {
    text-align: center;
    margin-top: 24px;
    color: rgba(255,255,255,0.45);
    font-size: 0.875rem;
  }
  .footer-link a {
    color: #f97316;
    text-decoration: none;
    font-weight: 600;
  }
  .footer-link a:hover { text-decoration: underline; }
</style>
</head>
<body>

<div class="card">
  <div class="logo">
    <span class="icon">🍔</span>
    <h1>QuickBite</h1>
    <p>Your favourite food, delivered fast</p>
  </div>

  <%
    String error = request.getParameter("error");
    if ("1".equals(error)) {
  %>
  <div class="error-box">
    ❌ Invalid username or password. Please try again.
  </div>
  <% } %>

  <form action="LoginServlet" method="post">

    <div class="form-group">
      <label for="username">Username</label>
      <input type="text" id="username" name="username"
             placeholder="Enter your username" required autocomplete="username">
    </div>

    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password"
             placeholder="Enter your password" required autocomplete="current-password">
    </div>

    <button type="submit" class="btn-login">Login →</button>
  </form>

  <div class="footer-link">
    Don't have an account? <a href="signup.jsp">Sign up</a>
  </div>
</div>

</body>
</html>
