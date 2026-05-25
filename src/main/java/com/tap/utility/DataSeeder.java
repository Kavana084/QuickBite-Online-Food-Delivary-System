package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class DataSeeder {

    private static final String URL = "jdbc:mysql://localhost:3306/tapfoods";
    private static final String USER = "root";
    private static final String PASSWORD = "Kavanajeevu@08";

    public static void main(String[] args) {
        Connection con = null;
        try {
            System.out.println("Loading MySQL JDBC Driver...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver Loaded successfully.");

            System.out.println("Connecting to database: " + URL);
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connected to database successfully.");

            // 1. Insert restaurants mapped to the user Kavana (userId = 4)
            seedRestaurants(con);

            // 2. Insert menu items mapped to the restaurants (dynamically resolved)
            seedMenus(con);

            System.out.println("\nDatabase seeding completed successfully!");

        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found in classpath. Please ensure mysql-connector-java is in your project build path.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database error occurred.");
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                    System.out.println("Database connection closed.");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static void seedRestaurants(Connection con) throws SQLException {
        String checkRestaurantSql = "SELECT COUNT(*) FROM `Restaurant`";
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(checkRestaurantSql)) {
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("The Restaurant table already contains data. Skipping restaurant seeding.");
                return;
            }
        }

        System.out.println("Seeding restaurants table...");
        String insertRestaurantSql = "INSERT INTO `Restaurant` (`name`, `img`, `ratings`, `eta`, `cuisineType`, `address`, `isActive`, `restaurantOwnerId`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        Object[][] restaurantsData = {
            {"Burger Palace", "images/Burger Palace.jpg", 4.3f, 25, "Burgers, Fast Food, Beverages", "123 Food Street, Sector 5, Bangalore", true, 4},
            {"Hong Kong Restaurant", "images/HongKong.jpg", 4.1f, 35, "Chinese, Asian", "456 Dragon Road, Indiranagar, Bangalore", true, 4},
            {"Meghana Foods", "images/Meghana.jpg", 4.5f, 20, "Biryani, Andhra, North Indian", "88 Jayanagar 4th Block, Bangalore", true, 4},
            {"Nandana Palace", "images/Nandana.jpg", 4.2f, 30, "Andhra, Traditional, Meals", "777 Koramangala 80 Feet Road, Bangalore", true, 4},
            {"Pizza Corner", "images/Pizza.jpg", 4.0f, 30, "Italian, Pizza, Desserts", "12 Pizza Avenue, Whitefield, Bangalore", true, 4},
            {"Grand Restaurant", "images/Restaurant1.jpg", 3.9f, 40, "North Indian, South Indian, Tandoori", "101 High Street, MG Road, Bangalore", true, 4},
            {"Spice Garden", "images/Restaurant2.jpg", 4.4f, 35, "Mughlai, North Indian, Kebab", "55 Outer Ring Road, Marathahalli, Bangalore", true, 4},
            {"The Bistro", "images/Restaurant3.jpg", 4.6f, 25, "Continental, Cafe, European", "99 Brigade Road, Bangalore", true, 4}
        };

        try (PreparedStatement pstmt = con.prepareStatement(insertRestaurantSql)) {
            for (Object[] restaurant : restaurantsData) {
                pstmt.setString(1, (String) restaurant[0]);
                pstmt.setString(2, (String) restaurant[1]);
                pstmt.setFloat(3, (Float) restaurant[2]);
                pstmt.setInt(4, (Integer) restaurant[3]);
                pstmt.setString(5, (String) restaurant[4]);
                pstmt.setString(6, (String) restaurant[5]);
                pstmt.setBoolean(7, (Boolean) restaurant[6]);
                pstmt.setInt(8, (Integer) restaurant[7]);

                pstmt.addBatch();
                System.out.println("Added restaurant to batch: " + restaurant[0]);
            }
            pstmt.executeBatch();
            System.out.println("All restaurants inserted successfully via batch execution!");
        }
    }

    private static void seedMenus(Connection con) throws SQLException {
        String checkMenuSql = "SELECT COUNT(*) FROM `menu`";
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(checkMenuSql)) {
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("The menu table already contains data. Skipping menu seeding.");
                return;
            }
        }

        // Fetch the generated restaurantIds from the Restaurant table to map menus correctly
        Map<String, Integer> restaurantMap = new HashMap<>();
        String fetchRestaurantsSql = "SELECT `restaurantId`, `name` FROM `Restaurant`";
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(fetchRestaurantsSql)) {
            while (rs.next()) {
                restaurantMap.put(rs.getString("name"), rs.getInt("restaurantId"));
            }
        }

        System.out.println("Seeding menu table...");
        String insertMenuSql = "INSERT INTO `menu` (`name`, `description`, `imgPath`, `isAvailable`, `restaurantID`, `price`, `ratings`) VALUES (?, ?, ?, ?, ?, ?, ?)";

        Object[][] menuData = {
            // Restaurant: Burger Palace
            {"Classic Chicken Burger", "Juicy chicken patty with fresh lettuce, cheese, and special sauce.", "Foods/Burger1.jpg", true, "Burger Palace", 149.00, 4.4},
            {"Double Cheese Burger", "Two grilled beef patties with melted cheddar cheese.", "Foods/Burger2.jpg", true, "Burger Palace", 199.00, 4.6},
            {"Veggie Delight Burger", "Crispy vegetable patty with mayo and fresh onions.", "Foods/Burger3.jpg", true, "Burger Palace", 129.00, 4.2},
            {"French Fries", "Crispy golden salted potato fries.", "Foods/Fries.jpg", true, "Burger Palace", 89.00, 4.1},
            {"Mexican Quesadilla", "Warm tortilla stuffed with cheesy Mexican filling.", "Foods/Mexican1.jpg", true, "Burger Palace", 179.00, 4.3},

            // Restaurant: Hong Kong Restaurant
            {"Chicken Hakka Noodles", "Stir-fried noodles with chicken and fresh vegetables.", "Foods/chinese1.jpg", true, "Hong Kong Restaurant", 189.00, 4.2},
            {"Veg Manchurian Dry", "Deep-fried veggie balls tossed in spicy manchurian sauce.", "Foods/chinese2.jpg", true, "Hong Kong Restaurant", 159.00, 4.0},
            {"Schezwan Fried Rice", "Spicy fried rice with chicken, egg, and schezwan peppers.", "Foods/chinese3.jpg", true, "Hong Kong Restaurant", 199.00, 4.3},

            // Restaurant: Meghana Foods
            {"Meghana Chicken Biryani", "Special spicy Andhra style chicken biryani.", "Foods/Biryani.jpg", true, "Meghana Foods", 310.00, 4.7},
            {"Boneless Chicken Biryani", "Biryani rice served with delicious boneless chicken gravy.", "Foods/Birayani2.jpg", true, "Meghana Foods", 330.00, 4.6},
            {"Special Veg Biryani", "Flavorful basmati rice cooked with fresh seasonal vegetables and spices.", "Foods/Veg Biryani.jpg", true, "Meghana Foods", 240.00, 4.2},
            {"Paneer Biryani", "Fragrant biryani rice served with spiced paneer cubes.", "Foods/Veg Biryani2.jpg", true, "Meghana Foods", 270.00, 4.3},

            // Restaurant: Nandana Palace
            {"Nandana Special Meals", "Traditional Andhra meals served with ghee, pappu, and curries.", "Foods/south.jpg", true, "Nandana Palace", 220.00, 4.5},
            {"Andhra Chicken Curry", "Spicy and flavorful chicken curry cooked in Andhra spices.", "Foods/south2.jpg", true, "Nandana Palace", 260.00, 4.3},
            {"Mutton Fry", "Tender mutton pieces slow-cooked with pepper and spices.", "Foods/south3.jpg", true, "Nandana Palace", 340.00, 4.6},
            {"Sankranthi Special Combo", "Traditional festival assortment of south Indian delicacies.", "Foods/south4.jpg", true, "Nandana Palace", 280.00, 4.4},

            // Restaurant: Pizza Corner
            {"Margherita Pizza", "Classic cheese pizza with fresh tomato sauce and mozzarella.", "Foods/Pizza1.jpg", true, "Pizza Corner", 249.00, 4.1},
            {"Pepperoni Feast Pizza", "Loaded with pork pepperoni and extra mozzarella cheese.", "Foods/Pizza2.jpg", true, "Pizza Corner", 399.00, 4.5},
            {"Veggie Supreme Pizza", "Olives, bell peppers, onions, mushrooms, and sweet corn.", "Foods/Pizza3.jpg", true, "Pizza Corner", 329.00, 4.3},
            {"Paneer Tikka Pizza", "Spiced paneer cubes with onions and capsicum.", "Foods/Pizza4.jpg", true, "Pizza Corner", 349.00, 4.4},

            // Restaurant: Grand Restaurant
            {"Butter Chicken with Naan", "Rich creamy butter chicken served with hot butter naan.", "Foods/north1.jpg", true, "Grand Restaurant", 299.00, 4.6},
            {"Paneer Butter Masala", "Cottage cheese cubes in a rich tomato gravy.", "Foods/North2.jpg", true, "Grand Restaurant", 249.00, 4.3},
            {"Hyderabadi Veg Dum Biryani", "Slow-cooked authentic Hyderabadi vegetable biryani.", "Foods/Veg Biaryani.jpg", true, "Grand Restaurant", 220.00, 4.2},
            {"Jackfruit Biryani", "Unique flavorful biryani made with tender jackfruit.", "Foods/Veg Birayni3.jpg", true, "Grand Restaurant", 260.00, 4.4},

            // Restaurant: Spice Garden
            {"Masala Dosa", "Crispy rice crepe filled with potato masala served with chutney.", "Foods/Dosa1.jpg", true, "Spice Garden", 90.00, 4.4},
            {"Rava Onion Dosa", "Crispy semolina crepe with chopped onions and green chillies.", "Foods/Dosa2.jpg", true, "Spice Garden", 110.00, 4.2},
            {"Filter Coffee", "Traditional south Indian hot frothy filter coffee.", "Foods/Coffee1.jpg", true, "Spice Garden", 45.00, 4.6},
            {"Cappuccino", "Espresso shot with steamed milk and thick foam.", "Foods/Coffee2.jpg", true, "Spice Garden", 95.00, 4.2},
            {"Iced Latte", "Cold brewed espresso with milk and vanilla syrup over ice.", "Foods/Coffee3.jpg", true, "Spice Garden", 120.00, 4.3},

            // Restaurant: The Bistro
            {"Bruschetta", "Toasted garlic bread topped with tomatoes, basil, and olive oil.", "Foods/Italian1.jpg", true, "The Bistro", 149.00, 4.1},
            {"Lasagna", "Baked layers of pasta, minced chicken, cheese, and marinara.", "Foods/Italian2.jpg", true, "The Bistro", 289.00, 4.5},
            {"Tiramisu", "Coffee-flavored Italian dessert made of ladyfingers and mascarpone.", "Foods/italian3.jpg", true, "The Bistro", 199.00, 4.6},
            {"Panna Cotta", "Smooth, sweetened cream dessert thickened with gelatin.", "Foods/italian4.jpg", true, "The Bistro", 169.00, 4.3},
            {"Creamy Alfredo Pasta", "Penne pasta tossed in rich white alfredo sauce.", "Foods/Pasta.jpg", true, "The Bistro", 219.00, 4.2},
            {"Greek Salad", "Fresh cucumbers, tomatoes, olives, and feta cheese in vinaigrette.", "Foods/Salad.jpg", true, "The Bistro", 179.00, 4.0},
            {"Club Sandwich", "Toasted sandwich with layers of chicken, lettuce, tomato, and egg.", "Foods/Sandwich.jpg", true, "The Bistro", 159.00, 4.1},
            {"Spaghetti Bolognese", "Spaghetti with minced meat sauce and parmesan.", "Foods/Sphagetti.jpg", true, "The Bistro", 249.00, 4.4}
        };

        try (PreparedStatement pstmt = con.prepareStatement(insertMenuSql)) {
            for (Object[] item : menuData) {
                String restaurantName = (String) item[4];
                Integer restaurantId = restaurantMap.get(restaurantName);
                if (restaurantId == null) {
                    System.err.println("Warning: Restaurant '" + restaurantName + "' not found in database. Skipping menu item: " + item[0]);
                    continue;
                }

                pstmt.setString(1, (String) item[0]);
                pstmt.setString(2, (String) item[1]);
                pstmt.setString(3, (String) item[2]);
                pstmt.setBoolean(4, (Boolean) item[3]);
                pstmt.setInt(5, restaurantId);
                pstmt.setDouble(6, ((Number) item[5]).doubleValue());
                pstmt.setDouble(7, ((Number) item[6]).doubleValue());

                pstmt.addBatch();
                System.out.println("Added menu item to batch: " + item[0] + " (Restaurant ID: " + restaurantId + ")");
            }
            pstmt.executeBatch();
            System.out.println("All menu items inserted successfully via batch execution!");
        }
    }
}
