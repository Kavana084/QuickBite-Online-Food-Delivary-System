package com.tap.controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.model.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        String action = req.getParameter("action");

        if (action != null) {

            int menuId = Integer.parseInt(req.getParameter("menuId"));

            // ── UPDATE ─────────────────────────
            if ("update".equals(action)) {

                int qtyChange = Integer.parseInt(req.getParameter("qty"));

                Iterator<CartItem> iterator = cart.iterator();

                while (iterator.hasNext()) {
                    CartItem item = iterator.next();

                    if (item.getMenuId() == menuId) {

                        item.setQuantity(item.getQuantity() + qtyChange);

                        if (item.getQuantity() <= 0) {
                            iterator.remove();
                        }

                        break;
                    }
                }
            }

            // ── DELETE ─────────────────────────
            else if ("delete".equals(action)) {

                cart.removeIf(item ->
                        item.getMenuId() == menuId
                );
            }

            session.setAttribute("cart", cart);
        }

        String restaurantId = req.getParameter("restaurantId");
        if (restaurantId != null && !restaurantId.isEmpty()) {
            resp.sendRedirect("menu?restaurantId=" + restaurantId);
        } else {
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
        }
    }
}