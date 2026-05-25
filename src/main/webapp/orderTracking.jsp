<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delivery Tracking | QuickBite</title>
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
  .tracking-card {
    width: 100%;
    max-width: 500px;
    background: #1a1a1a;
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 24px;
    padding: 40px;
    text-align: center;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
  }
  .icon-delivery {
    font-size: 5rem;
    margin-bottom: 24px;
    display: inline-block;
    animation: drive 3s ease-in-out infinite alternate;
  }
  @keyframes drive {
    0% { transform: translateX(-15px) rotate(-3deg); }
    100% { transform: translateX(15px) rotate(3deg); }
  }
  h1 {
    font-size: 1.8rem;
    font-weight: 800;
    color: #f97316;
    margin-bottom: 12px;
  }
  .status-text {
    font-size: 1.2rem;
    font-weight: 600;
    color: #fff;
    margin-bottom: 8px;
  }
  .sub-text {
    color: #a3a3a3;
    font-size: 0.95rem;
    margin-bottom: 35px;
    line-height: 1.5;
  }
  
  /* ── PROGRESS STEPPER ── */
  .stepper {
    display: flex;
    flex-direction: column;
    gap: 20px;
    text-align: left;
    margin-bottom: 35px;
    padding-left: 20px;
    position: relative;
  }
  .stepper::before {
    content: '';
    position: absolute;
    left: 8px;
    top: 10px;
    bottom: 10px;
    width: 2px;
    background: rgba(255,255,255,0.1);
  }
  .step {
    display: flex;
    align-items: center;
    gap: 16px;
    position: relative;
  }
  .step-node {
    width: 18px;
    height: 18px;
    border-radius: 50%;
    background: #404040;
    border: 3px solid #1a1a1a;
    z-index: 1;
    transition: background 0.3s;
  }
  .step.active .step-node {
    background: #f97316;
    box-shadow: 0 0 10px rgba(249,115,22,0.6);
  }
  .step.completed .step-node {
    background: #22c55e;
  }
  .step-label {
    font-size: 0.9rem;
    font-weight: 600;
    color: #737373;
  }
  .step.active .step-label {
    color: #fff;
  }
  .step.completed .step-label {
    color: #a3a3a3;
  }
  
  .btn-home {
    display: block;
    width: 100%;
    padding: 14px;
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 12px;
    background: transparent;
    color: rgba(255,255,255,0.8);
    font-size: 0.95rem;
    font-weight: 700;
    text-decoration: none;
    transition: border-color 0.2s, color 0.2s;
    text-align: center;
  }
  .btn-home:hover {
    border-color: #f97316;
    color: #f97316;
  }
</style>
</head>
<body>
  <div class="tracking-card">
    <div class="icon-delivery">🛵</div>
    <h1>Chill, Relax!</h1>
    <div class="status-text">Your order is on your way</div>
    <p class="sub-text">Our delivery executive has picked up your order and is heading towards your location.</p>
    
    <div class="stepper">
      <div class="step completed">
        <div class="step-node"></div>
        <span class="step-label">Order Confirmed</span>
      </div>
      <div class="step completed">
        <div class="step-node"></div>
        <span class="step-label">Food Prepared</span>
      </div>
      <div class="step active">
        <div class="step-node"></div>
        <span class="step-label">Out for Delivery</span>
      </div>
      <div class="step">
        <div class="step-node"></div>
        <span class="step-label">Arriving at Location</span>
      </div>
    </div>
    
    <a href="<%= request.getContextPath() %>/restaurants?action=display" class="btn-home">
      Back to Home
    </a>
  </div>
</body>
</html>
