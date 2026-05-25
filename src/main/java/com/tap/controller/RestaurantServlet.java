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

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {

    RestaurantDaoImpl dao = new RestaurantDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("delete".equals(action)) {

            deleteRestaurant(req, resp);

        } else {

            displayRestaurants(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {

            addRestaurant(req, resp);

        } else if ("update".equals(action)) {

            updateRestaurant(req, resp);
        }
    }

    // ADD
    private void addRestaurant(HttpServletRequest req,
                               HttpServletResponse resp)
                               throws IOException {

        Restaurant r = new Restaurant();

        r.setName(req.getParameter("name"));
        r.setImgPath(req.getParameter("imgPath"));
        r.setRatings(Float.parseFloat(req.getParameter("ratings")));
        r.setEta(Integer.parseInt(req.getParameter("eta")));
        r.setCuisineType(req.getParameter("cuisineType"));
        r.setAddress(req.getParameter("address"));
        r.setActive(Boolean.parseBoolean(req.getParameter("isActive")));
        r.setRestaurantOwnerId(
                Integer.parseInt(req.getParameter("restaurantOwnerId")));

        dao.addRestaurant(r);

        resp.sendRedirect(req.getContextPath() + "/restaurants");
    }

    // UPDATE
    private void updateRestaurant(HttpServletRequest req,
                                  HttpServletResponse resp)
                                  throws IOException {

        Restaurant r = new Restaurant();

        r.setRestaurantId(
                Integer.parseInt(req.getParameter("restaurantId")));

        r.setName(req.getParameter("name"));
        r.setImgPath(req.getParameter("imgPath"));
        r.setRatings(Float.parseFloat(req.getParameter("ratings")));
        r.setEta(Integer.parseInt(req.getParameter("eta")));
        r.setCuisineType(req.getParameter("cuisineType"));
        r.setAddress(req.getParameter("address"));
        r.setActive(Boolean.parseBoolean(req.getParameter("isActive")));
        r.setRestaurantOwnerId(
                Integer.parseInt(req.getParameter("restaurantOwnerId")));

        dao.updateRestaurant(r);

        resp.sendRedirect(req.getContextPath() + "/restaurants");
    }

    // DELETE
    private void deleteRestaurant(HttpServletRequest req,
                                  HttpServletResponse resp)
                                  throws IOException {

        int id =
            Integer.parseInt(req.getParameter("restaurantId"));

        dao.deleteRestaurant(id);

        resp.sendRedirect(req.getContextPath() + "/restaurants");
    }

    // DISPLAY
    private void displayRestaurants(HttpServletRequest req,
                                    HttpServletResponse resp)
                                    throws ServletException, IOException {

        ArrayList<Restaurant> restaurantList =
                dao.getAllRestaurants();

        req.setAttribute("restaurantList", restaurantList);

        RequestDispatcher rd =
                req.getRequestDispatcher("home.jsp");

        rd.forward(req, resp);
    }
}