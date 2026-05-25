-- Switch to the tapfoods database
USE `tapfoods`;

-- Insert query for Restaurant table mapping the images from the webapp/images folder
-- Using restaurantOwnerId = 4 (Kavana) to match the existing user in your database.
INSERT INTO `Restaurant` (`name`, `img`, `ratings`, `eta`, `cuisineType`, `address`, `isActive`, `restaurantOwnerId`) VALUES
('Burger Palace', 'images/Burger Palace.jpg', 4.3, 25, 'Burgers, Fast Food, Beverages', '123 Food Street, Sector 5, Bangalore', 1, 4),
('Hong Kong Restaurant', 'images/HongKong.jpg', 4.1, 35, 'Chinese, Asian', '456 Dragon Road, Indiranagar, Bangalore', 1, 4),
('Meghana Foods', 'images/Meghana.jpg', 4.5, 20, 'Biryani, Andhra, North Indian', '88 Jayanagar 4th Block, Bangalore', 1, 4),
('Nandana Palace', 'images/Nandana.jpg', 4.2, 30, 'Andhra, Traditional, Meals', '777 Koramangala 80 Feet Road, Bangalore', 1, 4),
('Pizza Corner', 'images/Pizza.jpg', 4.0, 30, 'Italian, Pizza, Desserts', '12 Pizza Avenue, Whitefield, Bangalore', 1, 4),
('Grand Restaurant', 'images/Restaurant1.jpg', 3.9, 40, 'North Indian, South Indian, Tandoori', '101 High Street, MG Road, Bangalore', 1, 4),
('Spice Garden', 'images/Restaurant2.jpg', 4.4, 35, 'Mughlai, North Indian, Kebab', '55 Outer Ring Road, Marathahalli, Bangalore', 1, 4),
('The Bistro', 'images/Restaurant3.jpg', 4.6, 25, 'Continental, Cafe, European', '99 Brigade Road, Bangalore', 1, 4);

