create database project;
use project;
-- Create the Customers table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL
);

-- Create the Restaurants table
CREATE TABLE IF NOT EXISTS Restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating FLOAT CHECK (rating BETWEEN 0 AND 5)
);

-- Create the Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_time TIMESTAMP NOT NULL,
    delivery_time TIMESTAMP NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- Create the Delivery_Details table
CREATE TABLE IF NOT EXISTS Delivery_Details (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    delivery_person_id INT,
    region VARCHAR(50) NOT NULL,
    delivery_duration INT NOT NULL,  -- Duration in minutes
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Create the Reviews table
CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Insert sample data into Customers table
INSERT INTO Customers (customer_name, region)
VALUES 
    ('John Doe', 'New York'),
    ('Jane Smith', 'Los Angeles'),
    ('Alice Johnson', 'Chicago'),
    ('Michael Brown', 'Houston'),
    ('Emily Davis', 'Phoenix'),
    ('Sophia Taylor', 'Philadelphia'),
    ('Daniel Anderson', 'San Antonio'),
    ('Jessica Martinez', 'San Diego'),
    ('David Thomas', 'Dallas'),
    ('Isabella Lee', 'San Jose'),
    ('James Wilson', 'Austin'),
    ('Mia Garcia', 'San Francisco'),
    ('Ethan Martinez', 'Seattle'),
    ('Olivia Rodriguez', 'Denver'),
    ('Liam Hernandez', 'San Jose'),
    ('Ava Young', 'Columbus'),
    ('Noah King', 'Charlotte'),
    ('Sophia Wright', 'Fort Worth'),
    ('Jackson Scott', 'Indianapolis'),
    ('Harper Green', 'Seattle'),
    ('Lucas Baker', 'San Antonio'),
    ('Ella Hill', 'Washington D.C.'),
    ('Benjamin Adams', 'Boston'),
    ('Chloe Nelson', 'Baltimore'),
    ('Alexander Carter', 'Atlanta'),
    ('Zoe Mitchell', 'Nashville');

-- Insert sample data into Restaurants table
INSERT INTO Restaurants (restaurant_name, cuisine, rating)
VALUES
    ('Pizza Palace', 'Italian', 4.5),
    ('Sushi World', 'Japanese', 4.8),
    ('Taco Town', 'Mexican', 4.2),
    ('Burger Haven', 'American', 4.0),
    ('Indian Spice', 'Indian', 4.7),
    ('Chinese Delight', 'Chinese', 4.4),
    ('French Bakery', 'French', 4.6),
    ('Thai Treasure', 'Thai', 4.3),
    ('Vegan Bistro', 'Vegan', 4.5),
    ('BBQ Spot', 'Barbecue', 4.1),
    ('Steakhouse Elite', 'Steak', 4.9),
    ('Seafood Galore', 'Seafood', 4.5),
    ('Breakfast Bliss', 'Breakfast', 4.8),
    ('Deli Delights', 'Deli', 4.4),
    ('Pasta Paradise', 'Italian', 4.6),
    ('Sweet Tooth', 'Dessert', 4.7),
    ('Sandwich Station', 'Sandwich', 4.2),
    ('Poke Bowl Heaven', 'Hawaiian', 4.8),
    ('Indian Fusion', 'Indian', 4.5),
    ('Falafel House', 'Middle Eastern', 4.6),
    ('Coffee Corner', 'Cafe', 4.3),
    ('Wine & Dine', 'European', 4.7),
    ('Curry Castle', 'Indian', 4.4),
    ('Tandoori Nights', 'Indian', 4.2),
    ('Grill & Chill', 'Barbecue', 4.6),
    ('Chilis Grill', 'Mexican', 4.5);
    
-- Insert 25 Orders (valid customer_id and restaurant_id)
INSERT INTO Orders (customer_id, restaurant_id, order_time, delivery_time)
VALUES
    (1, 1, '2024-10-21 12:30:00', '2024-10-21 12:50:00'),
    (2, 2, '2024-10-21 13:00:00', '2024-10-21 13:30:00'),
    (3, 3, '2024-10-21 14:00:00', '2024-10-21 14:20:00'),
    (4, 4, '2024-10-21 15:00:00', '2024-10-21 15:30:00'),
    (5, 5, '2024-10-21 16:00:00', '2024-10-21 16:25:00'),
    (6, 6, '2024-10-21 17:00:00', '2024-10-21 17:15:00'),
    (7, 7, '2024-10-21 18:00:00', '2024-10-21 18:40:00'),
    (8, 8, '2024-10-21 19:00:00', '2024-10-21 19:20:00'),
    (9, 9, '2024-10-21 20:00:00', '2024-10-21 20:50:00'),
    (10, 10, '2024-10-21 21:00:00', '2024-10-21 21:30:00'),
    (11, 11, '2024-10-22 12:30:00', '2024-10-22 12:50:00'),
    (12, 12, '2024-10-22 13:00:00', '2024-10-22 13:30:00'),
    (13, 13, '2024-10-22 14:00:00', '2024-10-22 14:20:00'),
    (14, 14, '2024-10-22 15:00:00', '2024-10-22 15:30:00'),
    (15, 15, '2024-10-22 16:00:00', '2024-10-22 16:25:00'),
    (16, 16, '2024-10-22 17:00:00', '2024-10-22 17:15:00'),
    (17, 17, '2024-10-22 18:00:00', '2024-10-22 18:40:00'),
    (18, 18, '2024-10-22 19:00:00', '2024-10-22 19:20:00'),
    (19, 19, '2024-10-22 20:00:00', '2024-10-22 20:50:00'),
    (20, 20, '2024-10-22 21:00:00', '2024-10-22 21:30:00'),
    (21, 21, '2024-10-22 12:30:00', '2024-10-22 12:50:00'),
    (22, 22, '2024-10-22 13:00:00', '2024-10-22 13:30:00'),
    (23, 23, '2024-10-22 14:00:00', '2024-10-22 14:20:00'),
    (24, 24, '2024-10-22 15:00:00', '2024-10-22 15:30:00'),
    (25, 25, '2024-10-22 16:00:00', '2024-10-22 16:25:00');
    
-- Insert sample data into Delivery_Details table
INSERT INTO Delivery_Details (order_id, delivery_person_id, region, delivery_duration)
VALUES
    (1, 101, 'New York', 20),
    (2, 102, 'Los Angeles', 30),
    (3, 103, 'Chicago', 25),
    (4, 104, 'Houston', 35),
    (5, 105, 'Phoenix', 15),
    (6, 106, 'Philadelphia', 30),
    (7, 107, 'San Antonio', 40),
    (8, 108, 'San Diego', 30),
    (9, 109, 'Dallas', 20),
    (10, 110, 'San Jose', 25),
    (11, 111, 'Austin', 15),
    (12, 112, 'San Francisco', 30),
    (13, 113, 'Seattle', 25),
    (14, 114, 'Denver', 20),
    (15, 115, 'Columbus', 30),
    (16, 116, 'Charlotte', 35),
    (17, 117, 'Fort Worth', 40),
    (18, 118, 'Indianapolis', 20),
    (19, 119, 'Seattle', 25),
    (20, 120, 'San Antonio', 30),
    (21, 121, 'Washington D.C.', 35),
    (22, 122, 'Boston', 15),
    (23, 123, 'Baltimore', 20),
    (24, 124, 'Atlanta', 25),
    (25, 125, 'Nashville', 30);
    
-- Insert sample data into Reviews table
INSERT INTO Reviews (restaurant_id, customer_id, rating, review_text)
VALUES
    (1, 1, 5, 'The pizza was excellent!'),
    (2, 2, 4, 'The sushi was fresh and tasty.'),
    (3, 3, 3, 'The tacos were okay, not the best.'),
    (4, 4, 4, 'The burger was juicy and delicious!'),
    (5, 5, 5, 'Authentic Indian flavors, loved it!'),
    (6, 6, 4, 'Good Chinese food, would order again.'),
    (7, 7, 4, 'Great French pastries!'),
    (8, 8, 5, 'Amazing Thai curry!'),
    (9, 9, 3, 'The vegan options were limited.'),
    (10, 10, 4, 'BBQ ribs were tasty but could be better.'),
    (11, 11, 5, 'The steak was cooked to perfection!'),
    (12, 12, 4, 'Seafood was fresh and well-prepared.'),
    (13, 13, 5, 'Breakfast items were delicious!'),
    (14, 14, 3, 'Deli sandwiches could use more flavor.'),
    (15, 15, 4, 'Pasta was good, but the sauce was too thick.'),
    (16, 16, 5, 'Desserts are heavenly!'),
    (17, 17, 4, 'Good sandwich selection.'),
    (18, 18, 5, 'Hawaiian poke bowls were fantastic!'),
    (19, 19, 4, 'Indian curry had a nice spice to it.'),
    (20, 20, 5, 'Middle Eastern falafel was the best!'),
    (21, 21, 4, 'Cafe had great coffee and pastries.'),
    (22, 22, 5, 'European dining experience was exquisite.'),
    (23, 23, 4, 'Indian food was good but a bit spicy.'),
    (24, 24, 5, 'BBQ was smoky and flavorful!'),
    (25, 25, 4, 'Mexican food was very authentic!');
    
SELECT * FROM Customers;
SELECT * FROM Restaurants;
SELECT * FROM Orders;
SELECT * FROM Delivery_Details;
SELECT * FROM Reviews;

