package com.tap.model;

public class OrderHistory {

    private int orderHistoryId;
    private int orderId;
    private int userId;

    // Default Constructor
    public OrderHistory() {
    }

    // Parameterized Constructor
    public OrderHistory(int orderHistoryId, int orderId, int userId) {
        this.orderHistoryId = orderHistoryId;
        this.orderId = orderId;
        this.userId = userId;
    }

    // Getters and Setters

    public int getOrderHistoryId() {
        return orderHistoryId;
    }

    public void setOrderHistoryId(int orderHistoryId) {
        this.orderHistoryId = orderHistoryId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}