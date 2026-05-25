package com.tap.dao;

import java.util.List;

import com.tap.model.Orders;

public interface OrdersDao {

    void addOrders(Orders orders);

    Orders getOrders(int orderId);

    List<Orders> getAllOrders();

    void updateOrders(Orders orders);

    void deleteOrders(int orderId);
}