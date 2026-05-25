package com.tap.model;

import java.io.Serializable;

public class Menu implements Serializable {
	private static final long serialVersionUID = 1L; 
    private int menuId;
    private String name;
    private String description;
    private String imgPath;
    private boolean isAvailable;
    private int restaurantID;
    private double price;
    private double ratings;

    // Zero Parameterized Constructor
    public Menu() {
    }

    // Parameterized Constructor
    public Menu(int menuId, String name, String description, String imgPath,
                boolean isAvailable, int restaurantID, double price, double ratings) {

        this.menuId = menuId;
        this.name = name;
        this.description = description;
        this.imgPath = imgPath;
        this.isAvailable = isAvailable;
        this.restaurantID = restaurantID;
        this.price = price;
        this.ratings = ratings;
    }

    // Getters and Setters

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public int getRestaurantID() {
        return restaurantID;
    }

    public void setRestaurantID(int restaurantID) {
        this.restaurantID = restaurantID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getRatings() {
        return ratings;
    }

    public void setRatings(double ratings) {
        this.ratings = ratings;
    }
}