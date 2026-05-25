
package com.tap.model;

public class Orders {

    private int orderId;
    private int restaurantID;
    private int userID;
    private double totalAmount;
    private String modeOfPayment;
    private String status;

    // Default Constructor
    public Orders() {
    }

    // Parameterized Constructor
    public Orders(int orderId, int restaurantID, int userID,double totalAmount, String modeOfPayment, String status) {
     
    	this.orderId = orderId;
        this.restaurantID = restaurantID;
        this.userID = userID;
        this.totalAmount = totalAmount;
        this.modeOfPayment = modeOfPayment;
        this.status = status;
    }

    // Getters and Setters

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getRestaurantID() {
        return restaurantID;
    }

    public void setRestaurantID(int restaurantID) {
        this.restaurantID = restaurantID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getModeOfPayment() {
        return modeOfPayment;
    }

    public void setModeOfPayment(String modeOfPayment) {
        this.modeOfPayment = modeOfPayment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
