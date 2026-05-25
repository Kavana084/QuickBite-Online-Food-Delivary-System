package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.tap.dao.OrderItemDao;
import com.tap.model.OrderItem;

public class OrderItemImpl implements OrderItemDao {

    final static String insert_query =
            "INSERT INTO `OrderItems` (`orderItemId`,`orderId`,`userId`,`menuId`,`itemName`,`quantity`,`ratings`,`price`) VALUES (?,?,?,?,?,?,?,?)";

    final static String select_query =
            "SELECT * FROM `OrderItems` WHERE `orderItemId`=?";

    final static String update_query =
            "UPDATE `OrderItems` SET `orderId`=?,`userId`=?,`menuId`=?,`itemName`=?,`quantity`=?,`ratings`=?,`price`=? WHERE `orderItemId`=?";

    final static String delete_query =
            "DELETE FROM `OrderItems` WHERE `orderItemId`=?";

    final static String select_all_query =
            "SELECT * FROM `OrderItems`";

    private Connection con = null;

    public OrderItemImpl() {

        String url = "jdbc:mysql://localhost:3306/tapfoods";
        String un = "root";
        String pwd = "Kavanajeevu@08";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, un, pwd);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addOrderItem(OrderItem orderItem) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(insert_query);

            prepStmt.setInt(1, orderItem.getOrderItemId());
            prepStmt.setInt(2, orderItem.getOrderId());
            prepStmt.setInt(3, orderItem.getUserId());
            prepStmt.setInt(4, orderItem.getMenuId());
            prepStmt.setString(5, orderItem.getItemName());
            prepStmt.setInt(6, orderItem.getQuantity());
            prepStmt.setDouble(7, orderItem.getRatings());
            prepStmt.setDouble(8, orderItem.getPrice());

            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItemById(int orderItemId) {

        PreparedStatement prepStmt = null;
        ResultSet res = null;

        OrderItem orderItem = null;

        try {

            prepStmt = con.prepareStatement(select_query);

            prepStmt.setInt(1, orderItemId);

            res = prepStmt.executeQuery();

            if (res.next()) {

                int id = res.getInt("orderItemId");
                int orderId = res.getInt("orderId");
                int userId = res.getInt("userId");
                int menuId = res.getInt("menuId");
                String itemName = res.getString("itemName");
                int quantity = res.getInt("quantity");
                double ratings = res.getDouble("ratings");
                double price = res.getDouble("price");

                orderItem = new OrderItem(id, orderId, userId, menuId,
                        itemName, quantity, ratings, price);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }

    @Override
    public void updateOrderItem(OrderItem orderItem) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(update_query);

            prepStmt.setInt(1, orderItem.getOrderId());
            prepStmt.setInt(2, orderItem.getUserId());
            prepStmt.setInt(3, orderItem.getMenuId());
            prepStmt.setString(4, orderItem.getItemName());
            prepStmt.setInt(5, orderItem.getQuantity());
            prepStmt.setDouble(6, orderItem.getRatings());
            prepStmt.setDouble(7, orderItem.getPrice());
            prepStmt.setInt(8, orderItem.getOrderItemId());

            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(delete_query);

            prepStmt.setInt(1, orderItemId);

            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<OrderItem> getAllOrderItems() {

        Statement stmt = null;
        ResultSet res = null;

        ArrayList<OrderItem> orderItemList = new ArrayList<OrderItem>();

        try {

            stmt = con.createStatement();

            res = stmt.executeQuery(select_all_query);

            while (res.next()) {

                int id = res.getInt("orderItemId");
                int orderId = res.getInt("orderId");
                int userId = res.getInt("userId");
                int menuId = res.getInt("menuId");
                String itemName = res.getString("itemName");
                int quantity = res.getInt("quantity");
                double ratings = res.getDouble("ratings");
                double price = res.getDouble("price");

                OrderItem orderItem = new OrderItem(id, orderId, userId, menuId,
                        itemName, quantity, ratings, price);

                orderItemList.add(orderItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemList;
    }

}