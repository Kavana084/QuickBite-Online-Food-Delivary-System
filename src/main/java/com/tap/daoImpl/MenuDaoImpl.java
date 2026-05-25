package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDao;
import com.tap.model.Menu;

public class MenuDaoImpl implements MenuDao {

    private static final String URL      = "jdbc:mysql://localhost:3306/tapfoods";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Kavanajeevu@08";

    private static final String INSERT_QUERY =
        "INSERT INTO menu(name, description, imgPath, isAvailable, restaurantID, price, ratings) VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_QUERY =
        "SELECT * FROM menu WHERE menuId = ?";

    private static final String SELECT_ALL_QUERY =
        "SELECT * FROM menu";

    private static final String SELECT_BY_RESTAURANT_QUERY =
        "SELECT * FROM menu WHERE restaurantID = ? AND isAvailable = true";

    private static final String UPDATE_QUERY =
        "UPDATE menu SET name=?, description=?, imgPath=?, isAvailable=?, restaurantID=?, price=?, ratings=? WHERE menuId=?";

    private static final String DELETE_QUERY =
        "DELETE FROM menu WHERE menuId=?";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // ── Helper to map a ResultSet row → Menu ─────────────────────────────────
    private Menu mapRow(ResultSet res) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(res.getInt("menuId"));
        menu.setName(res.getString("name"));
        menu.setDescription(res.getString("description"));
        menu.setImgPath(res.getString("imgPath"));
        menu.setAvailable(res.getBoolean("isAvailable"));
        menu.setRestaurantID(res.getInt("restaurantID"));
        menu.setPrice(res.getDouble("price"));
        menu.setRatings(res.getDouble("ratings"));
        return menu;
    }

    // ── Add Menu ─────────────────────────────────────────────────────────────
    @Override
    public int addMenu(Menu menu) {
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_QUERY)) {

            pstmt.setString(1, menu.getName());
            pstmt.setString(2, menu.getDescription());
            pstmt.setString(3, menu.getImgPath());
            pstmt.setBoolean(4, menu.isAvailable());
            pstmt.setInt(5, menu.getRestaurantID());
            pstmt.setDouble(6, menu.getPrice());
            pstmt.setDouble(7, menu.getRatings());
            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── Get Menu by ID ───────────────────────────────────────────────────────
    @Override
    public Menu getMenu(int menuId) {
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(SELECT_QUERY)) {

            pstmt.setInt(1, menuId);
            ResultSet res = pstmt.executeQuery();
            if (res.next()) return mapRow(res);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Get All Menus ────────────────────────────────────────────────────────
    @Override
    public List<Menu> getAllMenus() {
        List<Menu> menuList = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(SELECT_ALL_QUERY)) {

            ResultSet res = pstmt.executeQuery();
            while (res.next()) menuList.add(mapRow(res));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    // ── Get Menus by Restaurant ──────────────────────────────────────────────
    @Override
    public List<Menu> getMenusByRestaurantId(int restaurantId) {
        List<Menu> menuList = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(SELECT_BY_RESTAURANT_QUERY)) {

            pstmt.setInt(1, restaurantId);
            ResultSet res = pstmt.executeQuery();
            while (res.next()) menuList.add(mapRow(res));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    // ── Update Menu ──────────────────────────────────────────────────────────
    @Override
    public int updateMenu(Menu menu) {
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_QUERY)) {

            pstmt.setString(1, menu.getName());
            pstmt.setString(2, menu.getDescription());
            pstmt.setString(3, menu.getImgPath());
            pstmt.setBoolean(4, menu.isAvailable());
            pstmt.setInt(5, menu.getRestaurantID());
            pstmt.setDouble(6, menu.getPrice());
            pstmt.setDouble(7, menu.getRatings());
            pstmt.setInt(8, menu.getMenuId());
            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── Delete Menu ──────────────────────────────────────────────────────────
    @Override
    public int deleteMenu(int menuId) {
        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, menuId);
            return pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}