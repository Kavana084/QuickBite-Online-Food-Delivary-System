package com.tap.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tap.daoImpl.RestaurantDaoImpl;
import com.tap.model.Restaurant;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    RestaurantDaoImpl dao = new RestaurantDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("[HomeServlet] doGet called");

        try {
            ArrayList<Restaurant> restaurantList = dao.getAllRestaurants();

            System.out.println("[HomeServlet] Restaurants fetched: " +
                    (restaurantList != null ? restaurantList.size() : "NULL"));

            req.setAttribute("restaurantList", restaurantList);

            RequestDispatcher rd = req.getRequestDispatcher("home.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            System.out.println("[HomeServlet] ERROR: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect("Login.jsp?error=1");
        }
    }
}