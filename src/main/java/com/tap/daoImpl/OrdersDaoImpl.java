// OrdersDaoImpl.java
package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.tap.dao.OrdersDao;
import com.tap.model.Orders;

public class OrdersDaoImpl implements OrdersDao {

    final static String insert_query =
            "INSERT INTO `orders` (`orderId`,`restaurantID`,`userID`,`totalAmount`,`modeOfPayment`,`status`) VALUES (?,?,?,?,?,?)";

    final static String select_query =
            "SELECT * FROM `orders` WHERE `orderId`=?";

    final static String update_query =
            "UPDATE `orders` SET `restaurantID`=?,`userID`=?,`totalAmount`=?,`modeOfPayment`=?,`status`=? WHERE `orderId`=?";

    final static String delete_query =
            "DELETE FROM `orders` WHERE `orderId`=?";

    final static String select_all_query =
            "SELECT * FROM `orders`";

    private Connection con = null;

    public OrdersDaoImpl() {

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
    public void addOrders(Orders orders) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(insert_query);

            prepStmt.setInt(1, orders.getOrderId());
            prepStmt.setInt(2, orders.getRestaurantID());
            prepStmt.setInt(3, orders.getUserID());
            prepStmt.setDouble(4, orders.getTotalAmount());
            prepStmt.setString(5, orders.getModeOfPayment());
            prepStmt.setString(6, orders.getStatus());

            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Orders getOrders(int orderId) {

        PreparedStatement prepStmt = null;
        ResultSet res = null;

        Orders orders = null;

        try {

            prepStmt = con.prepareStatement(select_query);

            prepStmt.setInt(1, orderId);

            res = prepStmt.executeQuery();

            if (res.next()) {

                int id = res.getInt("orderId");
                int restaurantID = res.getInt("restaurantID");
                int userID = res.getInt("userID");
                double totalAmount = res.getDouble("totalAmount");
                String modeOfPayment = res.getString("modeOfPayment");
                String status = res.getString("status");

                orders = new Orders(id, restaurantID, userID,
                        totalAmount, modeOfPayment, status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    @Override
    public void updateOrders(Orders orders) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(update_query);

            prepStmt.setInt(1, orders.getRestaurantID());
            prepStmt.setInt(2, orders.getUserID());
            prepStmt.setDouble(3, orders.getTotalAmount());
            prepStmt.setString(4, orders.getModeOfPayment());
            prepStmt.setString(5, orders.getStatus());
            prepStmt.setInt(6, orders.getOrderId());

             prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void deleteOrders(int orderId) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(delete_query);
            prepStmt.setInt(1, orderId);
            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        
    }

    @Override
    public ArrayList<Orders> getAllOrders() {

        Statement stmt = null;
        ResultSet res = null;

        ArrayList<Orders> ordersList = new ArrayList<Orders>();

        try {

            stmt = con.createStatement();
             res = stmt.executeQuery(select_all_query);

            while (res.next()) {

                int id = res.getInt("orderId");
                int restaurantID = res.getInt("restaurantID");
                int userID = res.getInt("userID");
                double totalAmount = res.getDouble("totalAmount");
                String modeOfPayment = res.getString("modeOfPayment");
                String status = res.getString("status");

                Orders orders = new Orders(id, restaurantID, userID,totalAmount, modeOfPayment, status);
                ordersList.add(orders);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordersList;
    }
}