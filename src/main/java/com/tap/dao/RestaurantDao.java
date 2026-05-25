package com.tap.dao;
import java.util.ArrayList;


import com.tap.model.Restaurant;


public interface RestaurantDao {
	void addRestaurant(Restaurant restaurant);
    Restaurant getRestaurant(int restaurantId);
    void updateRestaurant(Restaurant restaurant);
    void deleteRestaurant(int restaurantId);
    ArrayList<Restaurant> getAllRestaurants();
}
