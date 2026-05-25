package com.tap.controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.daoImpl.MenuDaoImpl;
import com.tap.model.CartItem;
import com.tap.model.Menu;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    MenuDaoImpl menuDao = new MenuDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        if(req.getParameter("menuId") == null){
            resp.getWriter().println("Menu ID missing");
            return;
        }

        int menuId = Integer.parseInt(req.getParameter("menuId"));

        HttpSession session = req.getSession();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if(cart == null){
            cart = new ArrayList<>();
        }

        boolean found = false;

        for(CartItem item : cart){

            if(item.getMenuId() == menuId){
                item.setQuantity(item.getQuantity()+1);
                found = true;
                break;
            }
        }

        if(!found){
            cart.add(new CartItem(menuId,1));
        }

        session.setAttribute("cart", cart);

        String redirect = req.getParameter("redirect");
        if ("menu".equals(redirect)) {
            String restaurantId = req.getParameter("restaurantId");
            resp.sendRedirect("menu?restaurantId=" + restaurantId);
        } else {
            resp.sendRedirect("cart");
        }
    }
}