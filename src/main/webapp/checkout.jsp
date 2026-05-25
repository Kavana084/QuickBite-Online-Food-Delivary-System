<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User" %>

<%
Double total = (Double) session.getAttribute("total");

if(total == null){
    total = 0.0;
}

User loggedInUser = (User) session.getAttribute("loggedInUser");
String defaultAddress = (loggedInUser != null && loggedInUser.getAddress() != null) ? loggedInUser.getAddress() : "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QuickBite | Checkout</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(
    135deg,
    #ff7e5f,
    #feb47b,
    #ffcc70);
}

.checkout-card{
    width:450px;
    background:white;
    border-radius:25px;
    padding:35px;
    box-shadow:0 15px 40px rgba(0,0,0,.25);
}

.title{
    text-align:center;
    color:#ff6b00;
    margin-bottom:25px;
    font-size:32px;
}

.total-box{
    background:#fff4e6;
    padding:18px;
    border-radius:14px;
    text-align:center;
    margin-bottom:25px;
}

.total-label{
    color:#666;
    font-size:14px;
}

.amount{
    font-size:28px;
    color:#ff6b00;
    font-weight:bold;
}

.payment-title{
    margin-bottom:12px;
    font-size:18px;
    color:#333;
    font-weight:600;
}

.option{
    display:flex;
    align-items:center;
    gap:12px;
    padding:15px;
    margin-bottom:12px;
    border-radius:12px;
    background:#f8f8f8;
    cursor:pointer;
    transition:.3s;
}

.option:hover{
    transform:translateY(-3px);
    background:#fff2e6;
}

.option input{
    transform:scale(1.3);
}

.pay-btn{
    width:100%;
    margin-top:15px;
    padding:14px;
    border:none;
    border-radius:12px;
    background:linear-gradient(
    to right,
    #ff6b00,
    #ff9800);
    color:white;
    font-size:18px;
    font-weight:bold;
    cursor:pointer;
}

.pay-btn:hover{
    opacity:.9;
}

.btn-secondary {
    width: 100%;
    margin-top: 10px;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 12px;
    background: #f5f5f5;
    color: #555;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    text-align: center;
    transition: background 0.2s;
}
.btn-secondary:hover {
    background: #e8e8e8;
}

.address-box {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 12px;
    font-size: 14px;
    margin-bottom: 20px;
    resize: none;
    outline: none;
    transition: border-color 0.2s;
}
.address-box:focus {
    border-color: #ff6b00;
}

.confirm-box {
    background: #fdf2e9;
    border-left: 4px solid #ff6b00;
    padding: 16px;
    border-radius: 8px;
    margin-bottom: 20px;
    text-align: left;
}
.confirm-label {
    font-size: 13px;
    color: #777;
    margin-bottom: 4px;
    font-weight: 600;
}
.confirm-value {
    font-size: 15px;
    color: #333;
    font-weight: bold;
    margin-bottom: 12px;
    word-break: break-all;
}
.confirm-value:last-child {
    margin-bottom: 0;
}

</style>

<script>
function showConfirmTab(event) {
    event.preventDefault();
    
    const address = document.getElementById("address").value.trim();
    if (!address) {
        alert("Please enter a delivery address.");
        return;
    }
    
    const paymentOptions = document.getElementsByName("payment");
    let paymentSelected = "";
    for (let option of paymentOptions) {
        if (option.checked) {
            paymentSelected = option.value;
            break;
        }
    }
    
    if (!paymentSelected) {
        alert("Please select a payment method.");
        return;
    }
    
    // Copy values to confirmation tab
    document.getElementById("confirm-address").innerText = address;
    
    let paymentLabelText = "";
    if (paymentSelected === "UPI") paymentLabelText = "📱 UPI Payment";
    else if (paymentSelected === "CARD") paymentLabelText = "💳 Debit / Credit Card";
    else if (paymentSelected === "COD") paymentLabelText = "💵 Cash On Delivery";
    else if (paymentSelected === "WALLET") paymentLabelText = "👛 Wallet";
    
    document.getElementById("confirm-payment").innerText = paymentLabelText;
    
    // Switch views
    document.getElementById("checkout-details").style.display = "none";
    document.getElementById("checkout-confirm").style.display = "block";
}

function showDetailsTab(event) {
    event.preventDefault();
    document.getElementById("checkout-details").style.display = "block";
    document.getElementById("checkout-confirm").style.display = "none";
}
</script>

</head>

<body>

<div class="checkout-card">

<h1 class="title">💳 Checkout</h1>

<div class="total-box">
    <div class="total-label">Total Amount</div>
    <div class="amount">₹<%= total %></div>
</div>

<form action="place-order" method="post">

    <!-- STEP 1: Details Form -->
    <div id="checkout-details">
        <div class="payment-title">Delivery Address</div>
        <textarea id="address" name="address" rows="3" class="address-box" placeholder="Enter your delivery address..." required><%= defaultAddress %></textarea>

        <div class="payment-title">Choose Payment Method</div>
        
        <label class="option">
            <input type="radio" name="payment" value="UPI" required>
            📱 UPI Payment
        </label>

        <label class="option">
            <input type="radio" name="payment" value="CARD">
            💳 Debit / Credit Card
        </label>

        <label class="option">
            <input type="radio" name="payment" value="COD">
            💵 Cash On Delivery
        </label>

        <label class="option">
            <input type="radio" name="payment" value="WALLET">
            👛 Wallet
        </label>

        <button type="button" class="pay-btn" onclick="showConfirmTab(event)">
            Continue to Confirm →
        </button>
    </div>

    <!-- STEP 2: Confirm Form -->
    <div id="checkout-confirm" style="display: none;">
        <div class="payment-title" style="text-align: center; margin-bottom: 20px; color: #ff6b00;">Confirm Your Order</div>

        <div class="confirm-box">
            <div class="confirm-label">Delivery Address</div>
            <div id="confirm-address" class="confirm-value"></div>

            <div class="confirm-label">Payment Method</div>
            <div id="confirm-payment" class="confirm-value"></div>

            <div class="confirm-label">Amount Payable</div>
            <div class="confirm-value" style="color: #ff6b00; font-size: 1.2rem;">₹<%= total %></div>
        </div>

        <button type="submit" class="pay-btn" style="background: linear-gradient(to right, #4caf50, #8bc34a);">
            Confirm Order ✓
        </button>

        <button type="button" class="btn-secondary" onclick="showDetailsTab(event)">
            ← Back to Edit
        </button>
    </div>

</form>

</div>

</body>
</html>