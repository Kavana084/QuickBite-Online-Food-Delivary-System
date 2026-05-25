<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Operations</title>
</head>
<body>

<h1>Restaurant Operations</h1>

<!-- ADD RESTAURANT -->
<h2>Add Restaurant</h2>

<form action="restaurants" method="get">

    <input type="hidden" name="action" value="add">

    Name:
    <input type="text" name="name"><br><br>

    Image Path:
    <input type="text" name="imgPath"><br><br>

    Ratings:
    <input type="text" name="ratings"><br><br>

    ETA:
    <input type="text" name="eta"><br><br>

    Cuisine Type:
    <input type="text" name="cuisineType"><br><br>

    Address:
    <input type="text" name="address"><br><br>

    Active:
    <input type="text" name="isActive"><br><br>

    Restaurant Owner ID:
    <input type="text" name="restaurantOwnerId"><br><br>

    <input type="submit" value="Add Restaurant">

</form>

<hr>

<!-- UPDATE RESTAURANT -->
<h2>Update Restaurant</h2>

<form action="restaurants" method="get">

    <input type="hidden" name="action" value="update">

    Restaurant ID:
    <input type="text" name="restaurantId"><br><br>

    Name:
    <input type="text" name="name"><br><br>

    Image Path:
    <input type="text" name="imgPath"><br><br>

    Ratings:
    <input type="text" name="ratings"><br><br>

    ETA:
    <input type="text" name="eta"><br><br>

    Cuisine Type:
    <input type="text" name="cuisineType"><br><br>

    Address:
    <input type="text" name="address"><br><br>

    Active:
    <input type="text" name="isActive"><br><br>

    Restaurant Owner ID:
    <input type="text" name="restaurantOwnerId"><br><br>

    <input type="submit" value="Update Restaurant">

</form>

<hr>

<!-- DELETE RESTAURANT -->
<h2>Delete Restaurant</h2>

<form action="restaurants" method="get">

    <input type="hidden" name="action" value="delete">

    Restaurant ID:
    <input type="text" name="restaurantId"><br><br>

    <input type="submit" value="Delete Restaurant">

</form>

<hr>

<!-- DISPLAY RESTAURANTS -->
<h2>Display Restaurants</h2>

<form action="restaurants" method="get">

    <input type="hidden" name="action" value="display">

    <input type="submit" value="Display Restaurants">

</form>

</body>
</html>