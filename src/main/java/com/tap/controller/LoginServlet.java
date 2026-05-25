package com.tap.controller;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tap.daoImpl.UserDaoI;
import com.tap.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        System.out.println("[LoginServlet] Login attempt for username: " + username);

        UserDaoI userDao = new UserDaoI();
        User user = userDao.login(username, password);

        System.out.println("[LoginServlet] User found: " + (user != null));

        if (user != null) {
            try {
                boolean passwordMatch = BCrypt.checkpw(password, user.getPassword());
                System.out.println("[LoginServlet] BCrypt password match: " + passwordMatch);

                if (passwordMatch) {
                    HttpSession session = req.getSession();
                    session.setAttribute("loggedInUser", user);
                    System.out.println("[LoginServlet] Login SUCCESS — redirecting to home");
                    resp.sendRedirect("home");
                    return;
                }
            } catch (Exception e) {
                System.out.println("[LoginServlet] BCrypt error: " + e.getMessage());
                e.printStackTrace();
            }
        }

        // Invalid credentials or BCrypt error
        System.out.println("[LoginServlet] Login FAILED — redirecting to Login.jsp?error=1");
        resp.sendRedirect("Login.jsp?error=1");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // If already logged in, skip login page
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/restaurants?action=display");
        } else {
            resp.sendRedirect(req.getContextPath() + "/Login.jsp");
        }
    }
}
