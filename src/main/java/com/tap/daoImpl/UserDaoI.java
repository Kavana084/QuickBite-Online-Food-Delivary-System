package com.tap.daoImpl;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

import com.tap.dao.UserDao;
import com.tap.model.User;

public class UserDaoI implements UserDao {
	final static String insert_query = "INSERT INTO `user` (`userId`, `name`, `email`, `phoneNo`, `Address`, `username`, `password`,`role`,`createdDate`,`lastLogin`) VALUES (?, ?, ?, ?, ?, ?, ?,?,?,?)";
	final static String select_query = "SELECT * FROM `user` WHERE `userId` = ?";
	final static String update_query = "UPDATE `user` SET `name`=?, `email`=?, `phoneNo`=?, `Address`=?, `username`=?, `password`=?,  `role`=?, `createdDate`=?, `lastLogin`=? WHERE `userId`=?";
	final static String delete_query = "DELETE FROM `user` WHERE `userId` = ?";
	final static String select_all_query = "SELECT * FROM `user`";
	final static String login_query = "SELECT * FROM `user` WHERE `username` = ?";
	private Connection con = null;

	public UserDaoI() {
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
	public void addUser(User user) {
		// TODO Auto-generated method stub
		PreparedStatement prepStmt = null;
		try {
			prepStmt = con.prepareStatement(insert_query);
			prepStmt.setInt(1, user.getUserId());
			prepStmt.setString(2, user.getName());
			prepStmt.setString(3, user.getEmail());
			prepStmt.setLong(4, user.getPhoneNo());
			prepStmt.setString(5, user.getAddress());
			prepStmt.setString(6, user.getUsername());
			prepStmt.setString(7, user.getPassword());
			prepStmt.setString(8, user.getRole());
			prepStmt.setTimestamp(9, Timestamp.valueOf(user.getCreatedDate()));
			if(user.getLastLogin() != null) {

			    prepStmt.setTimestamp(10,
			        Timestamp.valueOf(user.getLastLogin()));

			} else {

			    prepStmt.setTimestamp(10, null);
			}
			prepStmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public User getUser(int userId) {
		// TODO Auto-generated method stub
		PreparedStatement prepStmt = null;
		ResultSet res = null;
		User user = null;
		try {
			prepStmt = con.prepareStatement(select_query);
			prepStmt.setInt(1, userId);
			res = prepStmt.executeQuery();
			if (res.next()) {
				int id = res.getInt("userId");
				String name = res.getString("name");
				String email = res.getString("email");
				long phoneNo = res.getLong("phoneNo");
				String Address = res.getString("Address");
				String username = res.getString("username");
				String password = res.getString("password");
				String role = res.getString("role");
				Timestamp createdTs = res.getTimestamp("createdDate");
			    Timestamp lastLoginTs = res.getTimestamp("lastLogin");

			    LocalDateTime createdDate = null;
			    LocalDateTime lastLogin = null;
			    if(createdTs != null) {
			        createdDate = createdTs.toLocalDateTime();
			    }
			    if(lastLoginTs != null) {
			        lastLogin = lastLoginTs.toLocalDateTime();
			    }
				user = new User(id, name, email, phoneNo, Address, username, password, role, createdDate, lastLogin);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public void updateUser(User user) {
		PreparedStatement prepStmt = null;
		try {
			prepStmt = con.prepareStatement(update_query);
			prepStmt.setString(1, user.getName());
			prepStmt.setString(2, user.getEmail());
			prepStmt.setLong(3, user.getPhoneNo());
			prepStmt.setString(4, user.getAddress());
			prepStmt.setString(5, user.getUsername());
			prepStmt.setString(6, user.getPassword());
			prepStmt.setString(7, user.getRole());
			prepStmt.setTimestamp(8, Timestamp.valueOf(user.getCreatedDate()));
			prepStmt.setTimestamp(9, Timestamp.valueOf(user.getLastLogin()));
			prepStmt.setInt(10, user.getUserId());
			prepStmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteUser(int userId) {
		// TODO Auto-generated method stub
		PreparedStatement prepStmt = null;
		try {
			prepStmt = con.prepareStatement(delete_query);
			prepStmt.setInt(1, userId);
			prepStmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public ArrayList<User> getAllUsers() {
		// TODO Auto-generated method stub
		Statement Stmt = null;
		ResultSet res = null;
		User user = null;
		ArrayList<User> userList = new ArrayList<User>();
		try {
			Stmt = con.createStatement();
			res = Stmt.executeQuery(select_all_query);
			while (res.next()) {
				int id = res.getInt("userId");
				String name = res.getString("name");
				String email = res.getString("email");
				long phoneNo = res.getLong("phoneNo");
				String Address = res.getString("Address");
				String username = res.getString("username");
				String password = res.getString("password");
				String role = res.getString("role");
				LocalDateTime createdDate = res.getTimestamp("createdDate").toLocalDateTime();
				LocalDateTime lastLogin = res.getTimestamp("lastLogin").toLocalDateTime();
				user = new User(id, name, email, phoneNo, Address, username, password, role, createdDate, lastLogin);
				userList.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userList;
	}

	@Override
	public User login(String username, String password) {
		PreparedStatement prepStmt = null;
		ResultSet res = null;
		User user = null;
		try {
			prepStmt = con.prepareStatement(login_query);
			prepStmt.setString(1, username);
			res = prepStmt.executeQuery();
			if (res.next()) {
				int id = res.getInt("userId");
				String name = res.getString("name");
				String email = res.getString("email");
				long phoneNo = res.getLong("phoneNo");
				String Address = res.getString("Address");
				String uname = res.getString("username");
				String pwd = res.getString("password");
				String role = res.getString("role");
				Timestamp createdTs = res.getTimestamp("createdDate");
				Timestamp lastLoginTs = res.getTimestamp("lastLogin");

				LocalDateTime createdDate = null;
				LocalDateTime lastLogin = null;

				if(createdTs != null) {
				    createdDate = createdTs.toLocalDateTime();
				}

				if(lastLoginTs != null) {
				    lastLogin = lastLoginTs.toLocalDateTime();
				}
				user = new User(id, name, email, phoneNo, Address, uname, pwd, role, createdDate, lastLogin);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

}
