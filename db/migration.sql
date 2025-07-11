--- 1. Create database
CREATE DATABASE coursework;
\c coursework;

--- 2. Create the table
CREATE TABLE food_inventory (
    id VARCHAR(8),  -- Not primary key because the IDs used are not deduplicated,
                    -- which if you ask me defeats the purpose of even having an
                    -- ID but whatever, I guess ¯\_(ツ)_/¯
    item VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    expiry_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    total_value DECIMAL(10, 2) NOT NULL CHECK (total_value >= 0),
    supplier VARCHAR(255) NOT NULL,
    location VARCHAR(50) NOT NULL,
    days_until_expiry INTEGER NOT NULL
);

--- 3. Copy `food_inventory.csv` into the table
\copy food_inventory (id, item, category, expiry_date, price, quantity, total_value, supplier, location, days_until_expiry) FROM '/mnt/db/food_inventory.csv' WITH (FORMAT csv, HEADER true);

--- 4. Create user to access this database
CREATE USER coursework WITH PASSWORD 'password123';     -- This is just an example password ofc
GRANT SELECT ON food_inventory TO coursework;