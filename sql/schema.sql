
-- ============================================
-- SCHEMA E-COMMERCE PORTAFOLIO (POSTGRESQL)
-- Creación de tablas y relaciones
-- ============================================

-- Eliminar tablas en orden de dependencias
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS inventory_movements CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS product_variants CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- ============================================
-- Tabla: customers
-- ============================================
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(30),
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Tabla: products
-- ============================================
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price INTEGER NOT NULL,
    is_clothing BOOLEAN DEFAULT FALSE,
    is_shoes BOOLEAN DEFAULT FALSE,
    gender VARCHAR(10),
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Tabla: product_variants
-- ============================================
CREATE TABLE product_variants (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    variant_name VARCHAR(20) NOT NULL,
    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE,
    CONSTRAINT unique_product_variant UNIQUE (product_id, variant_name)
);

-- ============================================
-- Tabla: orders
-- ============================================
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);

-- ============================================
-- Tabla: order_items
-- ============================================
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_variant_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price INTEGER NOT NULL,
    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_variant
        FOREIGN KEY (product_variant_id)
        REFERENCES product_variants(id)
        ON DELETE CASCADE
);

-- ============================================
-- Tabla: inventory_movements
-- ============================================
CREATE TABLE inventory_movements (
    id SERIAL PRIMARY KEY,
    product_variant_id INTEGER NOT NULL,
    movement_type VARCHAR(10) NOT NULL CHECK (movement_type IN ('IN','OUT')),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    movement_date TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_inventory_variant
        FOREIGN KEY (product_variant_id)
        REFERENCES product_variants(id)
        ON DELETE CASCADE
);
