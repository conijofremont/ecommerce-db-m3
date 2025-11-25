-- ============================================
-- DATA DE EJEMPLO: E-COMMERCE PORTAFOLIO
-- (clientes, productos, variantes, inventario, órdenes)
-- ============================================

-- ============================================
-- CLIENTES (correos gmail)
-- ============================================
INSERT INTO customers (full_name, email, phone) VALUES
('Constanza Jofré', 'constanza@gmail.com', '+56911112222'),
('María López', 'maria.lopez@gmail.com', '+56922223333'),
('Juan Pérez', 'juan.perez@gmail.com', '+56933334444'),
('Sofía Hernández', 'sofia.h@gmail.com', '+56944445555'),
('Carlos Soto', 'carlos.soto@gmail.com', '+56955556666'),
('Ana Torres', 'ana.torres@gmail.com', '+56966667777'),
('Pedro Rivas', 'pedro.rivas@gmail.com', '+56977778888'),
('Daniela Muñoz', 'daniela.m@gmail.com', '+56988889999'),
('Ricardo Cáceres', 'ricardo.c@gmail.com', '+56999990000'),
('Valentina Díaz', 'valentina.diaz@gmail.com', '+56912345678');

-- ============================================
-- PRODUCTOS (los 12 reales de tu frontend)
-- ============================================
INSERT INTO products (name, description, price, is_clothing, is_shoes, gender) VALUES
('Polera Algodón', 'Polera de algodón peruano, manga corta.', 15999, TRUE, FALSE, 'unisex'),
('Jeans Ajustados', 'Jeans denim elástico corte moderno.', 25999, TRUE, FALSE, 'women'),
('Zapatillas Deportivas', 'Zapatillas deportivas livianas.', 45999, FALSE, TRUE, 'unisex'),
('Gorra Urbana', 'Gorra ajustable diseño streetwear.', 8999, FALSE, FALSE, 'unisex'),
('Reloj Clásico', 'Reloj suizo de alta precisión.', 89999, FALSE, FALSE, 'men'),
('Bolso de Mano', 'Bolso elegante para uso diario.', 34999, FALSE, FALSE, 'women'),
('Auriculares Wireless', 'Auriculares con cancelación de ruido.', 59999, FALSE, FALSE, 'unisex'),
('Mochila Viajera', 'Mochila resistente al agua.', 49999, FALSE, FALSE, 'unisex'),
('Poleron Oversize', 'Sudadera oversize con capucha.', 28999, TRUE, FALSE, 'unisex'),
('Billetera de Cuero', 'Billetera elegante con múltiples ranuras.', 19999, FALSE, FALSE, 'men'),
('Zapatillas Casual', 'Zapatillas cómodas estilo urbano.', 39999, FALSE, TRUE, 'unisex'),
('Bufanda de Lana', 'Bufanda abrigada para invierno.', 12999, TRUE, FALSE, 'unisex');

-- ============================================
-- VARIANTES DE PRODUCTOS
-- ============================================

-- ROPA → S, M, L, XL
INSERT INTO product_variants (product_id, variant_name) VALUES
(1, 'S'), (1, 'M'), (1, 'L'), (1, 'XL'),
(2, 'S'), (2, 'M'), (2, 'L'), (2, 'XL'),
(9, 'S'), (9, 'M'), (9, 'L'), (9, 'XL'),
(12, 'S'), (12, 'M'), (12, 'L'), (12, 'XL');

-- ZAPATILLAS → 35 a 43
INSERT INTO product_variants (product_id, variant_name) VALUES
(3, '35'), (3, '36'), (3, '37'), (3, '38'), (3, '39'),
(3, '40'), (3, '41'), (3, '42'), (3, '43'),

(11, '35'), (11, '36'), (11, '37'), (11, '38'), (11, '39'),
(11, '40'), (11, '41'), (11, '42'), (11, '43');

-- ACCESORIOS → Standard
INSERT INTO product_variants (product_id, variant_name) VALUES
(4, 'Standard'),
(5, 'Standard'),
(6, 'Standard'),
(7, 'Standard'),
(8, 'Standard'),
(10, 'Standard');

-- ============================================
-- MOVIMIENTOS DE INVENTARIO
-- ============================================

-- Stock inicial ROPA
INSERT INTO inventory_movements (product_variant_id, movement_type, quantity) VALUES
(1, 'IN', 20), (2, 'IN', 25), (3, 'IN', 30), (4, 'IN', 15),
(5, 'IN', 18), (6, 'IN', 20), (7, 'IN', 12), (8, 'IN', 25),
(9, 'IN', 30), (10, 'IN', 25), (11, 'IN', 20), (12, 'IN', 18),
(13, 'IN', 40), (14, 'IN', 35), (15, 'IN', 30), (16, 'IN', 20);

-- Stock inicial ZAPATILLAS (ID 17 a 34)
INSERT INTO inventory_movements (product_variant_id, movement_type, quantity) VALUES
(17, 'IN', 10), (18, 'IN', 12), (19, 'IN', 15), (20, 'IN', 10),
(21, 'IN', 5),  (22, 'IN', 7),  (23, 'IN', 9),  (24, 'IN', 6),
(25, 'IN', 4),
(26, 'IN', 10), (27, 'IN', 12), (28, 'IN', 10), (29, 'IN', 8),
(30, 'IN', 7),  (31, 'IN', 9),  (32, 'IN', 11), (33, 'IN', 6),
(34, 'IN', 5);

-- Stock inicial ACCESORIOS (IDs 35 a 40)
INSERT INTO inventory_movements (product_variant_id, movement_type, quantity) VALUES
(35, 'IN', 50),
(36, 'IN', 20),
(37, 'IN', 40),
(38, 'IN', 30),
(39, 'IN', 15),
(40, 'IN', 25);

-- Movimientos OUT (ventas simuladas)
INSERT INTO inventory_movements (product_variant_id, movement_type, quantity) VALUES
(1, 'OUT', 2),
(10, 'OUT', 1),
(23, 'OUT', 1);

-- ============================================
-- ÓRDENES
-- ============================================
INSERT INTO orders (customer_id, status) VALUES
(1, 'completed'),
(3, 'completed'),
(5, 'pending'),
(7, 'pending'),
(2, 'completed'),
(8, 'completed');

-- ============================================
-- ITEMS DE ÓRDENES
-- ============================================
INSERT INTO order_items (order_id, product_variant_id, quantity, unit_price) VALUES
-- Orden 1 (Constanza)
(1, 2, 2, 15999),
(1, 36, 1, 59999),

-- Orden 2 (Juan)
(2, 7, 1, 25999),
(2, 20, 1, 45999),

-- Orden 3 (Carlos)
(3, 10, 1, 28999),

-- Orden 4 (Pedro)
(4, 27, 1, 39999),
(4, 40, 1, 34999),

-- Orden 5 (María)
(5, 14, 2, 12999),

-- Orden 6 (Daniela)
(6, 37, 1, 59999),
(6, 5, 1, 89999);
