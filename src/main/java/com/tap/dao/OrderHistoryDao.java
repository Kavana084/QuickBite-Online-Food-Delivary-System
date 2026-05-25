package com.tap.dao;

import java.util.List;

import com.tap.model.OrderHistory;

public interface OrderHistoryDao {

    void addOrderHistory(OrderHistory orderHistory);

    OrderHistory getOrderHistory(int orderHistoryId);

    List<OrderHistory> getAllOrderHistory();

    void updateOrderHistory(OrderHistory orderHistory);

    void deleteOrderHistory(int orderHistoryId);
}