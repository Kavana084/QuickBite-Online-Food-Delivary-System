package com.tap.dao;

import java.util.ArrayList;

import com.tap.model.User;

public interface UserDao {
   void addUser(User user);
   User getUser(int userId);
   void updateUser(User user);
   void deleteUser(int userId);
   ArrayList<User> getAllUsers();
   User login(String username, String password);
}
