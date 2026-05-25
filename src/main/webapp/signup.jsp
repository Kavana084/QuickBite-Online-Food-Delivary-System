<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup Page</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
    }

    .container {
        width: 400px;
        margin: 50px auto;
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px gray;
    }

    h2 {
        text-align: center;
    }

    input, select {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    button {
        width: 100%;
        padding: 10px;
        margin-top: 15px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #218838;
    }
</style>
</head>
<body>

<div class="container">
    <h2>User Signup</h2>

    <form action="SignupServlet" method="post">

        <input type="text" name="name" placeholder="Enter Name" required>

        <input type="email" name="email" placeholder="Enter Email" required>

        <input type="text" name="phoneNo" placeholder="Enter Phone Number" required>

        <input type="text" name="address" placeholder="Enter Address" required>

        <input type="text" name="username" placeholder="Enter Username" required>

        <input type="password" name="password" placeholder="Enter Password" required>

        <select name="role">
            <option value="CUSTOMER">CUSTOMER</option>
            <option value="ADMIN">ADMIN</option>
            <option value="RESTAURANTOWNER">RESTAURANT OWNER</option>
            <option value="DELIVERYBOY">DELIVERY BOY</option>
            <option value="SYSTEMADMIN">SYSTEM ADMIN</option>
        </select>

        <button type="submit">Sign Up</button>

    </form>
</div>

</body>
</html>
