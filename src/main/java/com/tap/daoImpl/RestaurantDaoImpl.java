package com.tap.daoImpl;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.tap.dao.RestaurantDao;
import com.tap.model.Restaurant;

public  class RestaurantDaoImpl implements RestaurantDao {

	final static String insert_query ="INSERT INTO `Restaurant` (`name`, `img`, `ratings`, `eta`, `cuisineType`, `address`, `isActive`, `restaurantOwnerId`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	
	final static String select_query ="SELECT * FROM `Restaurant` WHERE `restaurantId` = ?";

	final static String update_query ="UPDATE `Restaurant` SET `name`=?, `img`=?, `ratings`=?, `eta`=?, `cuisineType`=?, `address`=?, `isActive`=?, `restaurantOwnerId`=? WHERE `restaurantId`=?";

	final static String delete_query ="DELETE FROM `Restaurant` WHERE `restaurantId`=?";

	final static String select_all_query ="SELECT * FROM `Restaurant`";

	private Connection con = null;

	public RestaurantDaoImpl() {

	    String url = "jdbc:mysql://localhost:3306/tapfoods";
	    String un = "root";
	    String pwd = "Kavanajeevu@08";

	    try {

	        System.out.println("Loading Driver...");

	        Class.forName("com.mysql.cj.jdbc.Driver");

	        System.out.println("Driver Loaded");

	        con = DriverManager.getConnection(url, un, pwd);

	        System.out.println("Database Connected");

	    } catch (ClassNotFoundException e) {

	        System.out.println("Driver Not Found");

	        e.printStackTrace();

	    } catch (SQLException e) {

	        System.out.println("SQL Exception Occurred");

	        e.printStackTrace();
	    }
	}

	@Override
	public void addRestaurant(Restaurant restaurant) {

		PreparedStatement prepStmt = null;

		try {

			prepStmt = con.prepareStatement(insert_query);

			prepStmt.setString(1, restaurant.getName());
			prepStmt.setString(2, restaurant.getImgPath());
			prepStmt.setFloat(3, restaurant.getRatings());
			prepStmt.setInt(4, restaurant.getEta());
			prepStmt.setString(5, restaurant.getCuisineType());
			prepStmt.setString(6, restaurant.getAddress());
			prepStmt.setBoolean(7, restaurant.isActive());
			prepStmt.setInt(8, restaurant.getRestaurantOwnerId());

			prepStmt.executeUpdate();

		} catch (SQLException e) {
             e.printStackTrace();
		}
	}

	@Override
	public Restaurant getRestaurant(int restaurantId) {

		PreparedStatement prepStmt = null;
		ResultSet res = null;

		Restaurant restaurant = null;

		try {

			prepStmt = con.prepareStatement(select_query);

			prepStmt.setInt(1, restaurantId);

			res = prepStmt.executeQuery();

			if (res.next()) {

				int id = res.getInt("restaurantId");
				String name = res.getString("name");
				String imgPath = res.getString("img");
				float ratings = res.getFloat("ratings");
				int eta = res.getInt("eta");
				String cuisineType = res.getString("cuisineType");
				String address = res.getString("address");
				boolean isActive = res.getBoolean("isActive");
				int restaurantOwnerId = res.getInt("restaurantOwnerId");

				restaurant = new Restaurant(id,name,imgPath,ratings,eta,cuisineType,address,isActive,restaurantOwnerId);
			}

		} catch (SQLException e) {
            e.printStackTrace();
		}

		return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {

		PreparedStatement prepStmt = null;

		try {

			prepStmt = con.prepareStatement(update_query);

			prepStmt.setString(1, restaurant.getName());
			prepStmt.setString(2, restaurant.getImgPath());
			prepStmt.setFloat(3, restaurant.getRatings());
			prepStmt.setInt(4, restaurant.getEta());
			prepStmt.setString(5, restaurant.getCuisineType());
			prepStmt.setString(6, restaurant.getAddress());
			prepStmt.setBoolean(7, restaurant.isActive());
			prepStmt.setInt(8, restaurant.getRestaurantOwnerId());
			prepStmt.setInt(9, restaurant.getRestaurantId());

			prepStmt.executeUpdate();

		} catch (SQLException e) {
            e.printStackTrace();
		}
	}

	@Override
	public void deleteRestaurant(int restaurantId) {

		PreparedStatement prepStmt = null;

		try {
            prepStmt = con.prepareStatement(delete_query);

			prepStmt.setInt(1, restaurantId);

			prepStmt.executeUpdate();

		} catch (SQLException e) {
            e.printStackTrace();
		}
	}

	@Override
	public ArrayList<Restaurant> getAllRestaurants() {

		Statement stmt = null;
		ResultSet res = null;

		ArrayList<Restaurant> restaurantList = new ArrayList<>();

		try {

			stmt = con.createStatement();

			res = stmt.executeQuery(select_all_query);

			while (res.next()) {

				int id = res.getInt("restaurantId");
				String name = res.getString("name");
				String imgPath = res.getString("img");
				float ratings = res.getFloat("ratings");
				int eta = res.getInt("eta");
				String cuisineType = res.getString("cuisineType");
				String address = res.getString("address");
				boolean isActive = res.getBoolean("isActive");
				int restaurantOwnerId = res.getInt("restaurantOwnerId");

				Restaurant restaurant = new Restaurant(id,name,imgPath,ratings,eta,cuisineType,address,isActive,restaurantOwnerId);

				restaurantList.add(restaurant);
			}

		} catch (SQLException e) {
           e.printStackTrace();
		}

		return restaurantList;
	}
}
