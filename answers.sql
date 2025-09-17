-- 🔄 Disable foreign key checks to safely drop dependent tables
SET FOREIGN_KEY_CHECKS = 0;

-- 🔄 Drop tables in reverse dependency order
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductDetail1NF;

-- ✅ Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- 🛠️ Create ProductDetail1NF table (Achieving 1NF)
CREATE TABLE ProductDetail1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
) ENGINE=InnoDB;

-- 📥 Insert normalized product data (each product in its own row)
INSERT INTO ProductDetail1NF (OrderID, CustomerName, Product)
VALUES 
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- 🧩 Create Orders table (Achieving 2NF by removing partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
) ENGINE=InnoDB;

-- 📥 Insert unique order-customer pairs
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- 📦 Create OrderItems table (Achieving 2NF with full dependency on composite key)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
) ENGINE=InnoDB;

-- 📥 Insert item-level order details
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES 
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
