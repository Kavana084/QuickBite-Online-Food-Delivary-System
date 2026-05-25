// OrderHistoryDaoImpl.java
package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.tap.dao.OrderHistoryDao;
import com.tap.model.OrderHistory;

public class OrderHistoryImpl implements OrderHistoryDao {

    final static String insert_query ="INSERT INTO `OrderHistory` (`orderHistoryId`,`orderId`,`userId`) VALUES (?,?,?)";

    final static String select_query = "SELECT * FROM `OrderHistory` WHERE `orderHistoryId`=?";

    final static String update_query ="UPDATE `OrderHistory` SET `orderId`=?,`userId`=? WHERE `orderHistoryId`=?";

    final static String delete_query = "DELETE FROM `OrderHistory` WHERE `orderHistoryId`=?";

    final static String select_all_query = "SELECT * FROM `OrderHistory`";

    private Connection con = null;

    public OrderHistoryImpl() {

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
    public void addOrderHistory(OrderHistory orderHistory) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(insert_query);

            prepStmt.setInt(1, orderHistory.getOrderHistoryId());
            prepStmt.setInt(2, orderHistory.getOrderId());
            prepStmt.setInt(3, orderHistory.getUserId());

            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderHistory getOrderHistory(int orderHistoryId) {

        PreparedStatement prepStmt = null;
        ResultSet res = null;

        OrderHistory orderHistory = null;

        try {

            prepStmt = con.prepareStatement(select_query);

            prepStmt.setInt(1, orderHistoryId);

            res = prepStmt.executeQuery();

            if (res.next()) {

                int id = res.getInt("orderHistoryId");
                int orderId = res.getInt("orderId");
                int userId = res.getInt("userId");

                orderHistory = new OrderHistory(id, orderId, userId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderHistory;
    }

    @Override
    public ArrayList<OrderHistory> getAllOrderHistory() {

        Statement stmt = null;
        ResultSet res = null;

        ArrayList<OrderHistory> orderHistoryList = new ArrayList<OrderHistory>();

        try {

            stmt = con.createStatement();

            res = stmt.executeQuery(select_all_query);

            while (res.next()) {

                int id = res.getInt("orderHistoryId");
                int orderId = res.getInt("orderId");
                int userId = res.getInt("userId");

                OrderHistory orderHistory =
                        new OrderHistory(id, orderId, userId);

                orderHistoryList.add(orderHistory);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderHistoryList;
    }

    @Override
    public void updateOrderHistory(OrderHistory orderHistory) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(update_query);

            prepStmt.setInt(1, orderHistory.getOrderId());
            prepStmt.setInt(2, orderHistory.getUserId());
            prepStmt.setInt(3, orderHistory.getOrderHistoryId());

            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderHistory(int orderHistoryId) {

        PreparedStatement prepStmt = null;

        try {

            prepStmt = con.prepareStatement(delete_query);

            prepStmt.setInt(1, orderHistoryId);

            prepStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            
        }
    }
}