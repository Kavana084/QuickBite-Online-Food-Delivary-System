-- Switch to the tapfoods database
USE `tapfoods`;

-- Insert query for Menu table mapping the images from the webapp/Foods folder.
-- Resolving restaurantID dynamically using subqueries on restaurant names to prevent foreign key errors.
INSERT INTO `menu` (`name`, `description`, `imgPath`, `isAvailable`, `restaurantID`, `price`, `ratings`) VALUES
-- Restaurant: Burger Palace
('Classic Chicken Burger', 'Juicy chicken patty with fresh lettuce, cheese, and special sauce.', 'Foods/Burger1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Burger Palace' LIMIT 1), 149.00, 4.4),
('Double Cheese Burger', 'Two grilled beef patties with melted cheddar cheese.', 'Foods/Burger2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Burger Palace' LIMIT 1), 199.00, 4.6),
('Veggie Delight Burger', 'Crispy vegetable patty with mayo and fresh onions.', 'Foods/Burger3.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Burger Palace' LIMIT 1), 129.00, 4.2),
('French Fries', 'Crispy golden salted potato fries.', 'Foods/Fries.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Burger Palace' LIMIT 1), 89.00, 4.1),
('Mexican Quesadilla', 'Warm tortilla stuffed with cheesy Mexican filling.', 'Foods/Mexican1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Burger Palace' LIMIT 1), 179.00, 4.3),

-- Restaurant: Hong Kong Restaurant
('Chicken Hakka Noodles', 'Stir-fried noodles with chicken and fresh vegetables.', 'Foods/chinese1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Hong Kong Restaurant' LIMIT 1), 189.00, 4.2),
('Veg Manchurian Dry', 'Deep-fried veggie balls tossed in spicy manchurian sauce.', 'Foods/chinese2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Hong Kong Restaurant' LIMIT 1), 159.00, 4.0),
('Schezwan Fried Rice', 'Spicy fried rice with chicken, egg, and schezwan peppers.', 'Foods/chinese3.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Hong Kong Restaurant' LIMIT 1), 199.00, 4.3),

-- Restaurant: Meghana Foods
('Meghana Chicken Biryani', 'Special spicy Andhra style chicken biryani.', 'Foods/Biryani.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Meghana Foods' LIMIT 1), 310.00, 4.7),
('Boneless Chicken Biryani', 'Biryani rice served with delicious boneless chicken gravy.', 'Foods/Birayani2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Meghana Foods' LIMIT 1), 330.00, 4.6),
('Special Veg Biryani', 'Flavorful basmati rice cooked with fresh seasonal vegetables and spices.', 'Foods/Veg Biryani.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Meghana Foods' LIMIT 1), 240.00, 4.2),
('Paneer Biryani', 'Fragrant biryani rice served with spiced paneer cubes.', 'Foods/Veg Biryani2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Meghana Foods' LIMIT 1), 270.00, 4.3),

-- Restaurant: Nandana Palace
('Nandana Special Meals', 'Traditional Andhra meals served with ghee, pappu, and curries.', 'Foods/south.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Nandana Palace' LIMIT 1), 220.00, 4.5),
('Andhra Chicken Curry', 'Spicy and flavorful chicken curry cooked in Andhra spices.', 'Foods/south2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Nandana Palace' LIMIT 1), 260.00, 4.3),
('Mutton Fry', 'Tender mutton pieces slow-cooked with pepper and spices.', 'Foods/south3.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Nandana Palace' LIMIT 1), 340.00, 4.6),
('Sankranthi Special Combo', 'Traditional festival assortment of south Indian delicacies.', 'Foods/south4.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Nandana Palace' LIMIT 1), 280.00, 4.4),

-- Restaurant: Pizza Corner
('Margherita Pizza', 'Classic cheese pizza with fresh tomato sauce and mozzarella.', 'Foods/Pizza1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Pizza Corner' LIMIT 1), 249.00, 4.1),
('Pepperoni Feast Pizza', 'Loaded with pork pepperoni and extra mozzarella cheese.', 'Foods/Pizza2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Pizza Corner' LIMIT 1), 399.00, 4.5),
('Veggie Supreme Pizza', 'Olives, bell peppers, onions, mushrooms, and sweet corn.', 'Foods/Pizza3.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Pizza Corner' LIMIT 1), 329.00, 4.3),
('Paneer Tikka Pizza', 'Spiced paneer cubes with onions and capsicum.', 'Foods/Pizza4.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Pizza Corner' LIMIT 1), 349.00, 4.4),

-- Restaurant: Grand Restaurant
('Butter Chicken with Naan', 'Rich creamy butter chicken served with hot butter naan.', 'Foods/north1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Grand Restaurant' LIMIT 1), 299.00, 4.6),
('Paneer Butter Masala', 'Cottage cheese cubes in a rich tomato gravy.', 'Foods/North2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Grand Restaurant' LIMIT 1), 249.00, 4.3),
('Hyderabadi Veg Dum Biryani', 'Slow-cooked authentic Hyderabadi vegetable biryani.', 'Foods/Veg Biaryani.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Grand Restaurant' LIMIT 1), 220.00, 4.2),
('Jackfruit Biryani', 'Unique flavorful biryani made with tender jackfruit.', 'Foods/Veg Birayni3.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Grand Restaurant' LIMIT 1), 260.00, 4.4),

-- Restaurant: Spice Garden
('Masala Dosa', 'Crispy rice crepe filled with potato masala served with chutney.', 'Foods/Dosa1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Spice Garden' LIMIT 1), 90.00, 4.4),
('Rava Onion Dosa', 'Crispy semolina crepe with chopped onions and green chillies.', 'Foods/Dosa2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Spice Garden' LIMIT 1), 110.00, 4.2),
('Filter Coffee', 'Traditional south Indian hot frothy filter coffee.', 'Foods/Coffee1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Spice Garden' LIMIT 1), 45.00, 4.6),
('Cappuccino', 'Espresso shot with steamed milk and thick foam.', 'Foods/Coffee2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Spice Garden' LIMIT 1), 95.00, 4.2),
('Iced Latte', 'Cold brewed espresso with milk and vanilla syrup over ice.', 'Foods/Coffee3.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'Spice Garden' LIMIT 1), 120.00, 4.3),

-- Restaurant: The Bistro
('Bruschetta', 'Toasted garlic bread topped with tomatoes, basil, and olive oil.', 'Foods/Italian1.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 149.00, 4.1),
('Lasagna', 'Baked layers of pasta, minced chicken, cheese, and marinara.', 'Foods/Italian2.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 289.00, 4.5),
('Tiramisu', 'Coffee-flavored Italian dessert made of ladyfingers and mascarpone.', 'Foods/italian3.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 199.00, 4.6),
('Panna Cotta', 'Smooth, sweetened cream dessert thickened with gelatin.', 'Foods/italian4.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 169.00, 4.3),
('Creamy Alfredo Pasta', 'Penne pasta tossed in rich white alfredo sauce.', 'Foods/Pasta.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 219.00, 4.2),
('Greek Salad', 'Fresh cucumbers, tomatoes, olives, and feta cheese in vinaigrette.', 'Foods/Salad.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 179.00, 4.0),
('Club Sandwich', 'Toasted sandwich with layers of chicken, lettuce, tomato, and egg.', 'Foods/Sandwich.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 159.00, 4.1),
('Spaghetti Bolognese', 'Spaghetti with minced meat sauce and parmesan.', 'Foods/Sphagetti.jpg', 1, (SELECT `restaurantId` FROM `Restaurant` WHERE `name` = 'The Bistro' LIMIT 1), 249.00, 4.4);
