package com.tap.controller;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tap.daoImpl.UserDaoI;
import com.tap.model.User;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String name = req.getParameter("name");
            String email = req.getParameter("email");

            long phoneNo =
                    Long.parseLong(req.getParameter("phoneNo"));

            String address = req.getParameter("address");

            String username =
                    req.getParameter("username");

            String password = req.getParameter("password");
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            String role = req.getParameter("role");

            User user = new User();

            user.setName(name);
            user.setEmail(email);
            user.setPhoneNo(phoneNo);
            user.setAddress(address);
            user.setUsername(username);
            user.setPassword(hashedPassword);
            user.setRole(role);

            user.setCreatedDate(LocalDateTime.now());

            UserDaoI dao = new UserDaoI();

            dao.addUser(user);

            resp.sendRedirect("Login.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "Signup Failed"
            );
        }
    }
}