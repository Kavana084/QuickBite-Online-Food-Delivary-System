package com.tap.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tap.daoImpl.MenuDaoImpl;
import com.tap.daoImpl.RestaurantDaoImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    MenuDaoImpl menuDao = new MenuDaoImpl();
    RestaurantDaoImpl restaurantDao = new RestaurantDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
                         throws ServletException, IOException {

        int restaurantId =
                Integer.parseInt(
                        req.getParameter("restaurantId"));

        // Fetch menu items
        List<Menu> menuList =
                menuDao.getMenusByRestaurantId(restaurantId);

        // Fetch restaurant details
        Restaurant restaurant =
                restaurantDao.getRestaurant(restaurantId);

        req.setAttribute("menuList", menuList);
        req.setAttribute("restaurant", restaurant);

        RequestDispatcher rd =
                req.getRequestDispatcher("Menu.jsp");

        rd.forward(req, resp);
    }
}