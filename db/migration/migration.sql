--- Set environment variables
\set DB_PASSWORD `echo $DB_PASSWORD`
\set DB_USER `echo $DB_USER`

--- 1. Create the table
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

--- 2. Copy `food_inventory.csv` into the table
\copy food_inventory (id, item, category, expiry_date, price, quantity, total_value, supplier, location, days_until_expiry) FROM '/mnt/db/food_inventory.csv' WITH (FORMAT csv, HEADER true);

--- 3. Create user to access this database
CREATE USER :DB_USER WITH PASSWORD :'DB_PASSWORD';
GRANT SELECT ON food_inventory TO :DB_USER;