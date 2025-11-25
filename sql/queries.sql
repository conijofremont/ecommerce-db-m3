-- ============================================
-- QUERIES E-COMMERCE PORTAFOLIO M3
-- ============================================

-- 1. Buscar productos por nombre (LIKE)
SELECT *
FROM products
WHERE name ILIKE '%zapatilla%';

-- 2. Listar productos con sus variantes
SELECT
    p.id AS product_id,
    p.name AS product_name,
    v.id AS variant_id,
    v.variant_name
FROM products p
JOIN product_variants v ON p.id = v.product_id
ORDER BY p.id, v.variant_name;

-- 3. Stock actual por variante
SELECT
    v.id AS variant_id,
    p.name AS product,
    v.variant_name,
    SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE -m.quantity END) AS stock_actual
FROM product_variants v
JOIN products p ON p.id = v.product_id
JOIN inventory_movements m ON m.product_variant_id = v.id
GROUP BY v.id, p.name, v.variant_name
ORDER BY v.id;

-- 4. Stock total por producto
SELECT
    p.id AS product_id,
    p.name AS product,
    SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE -m.quantity END) AS stock_total
FROM products p
JOIN product_variants v ON v.product_id = p.id
JOIN inventory_movements m ON m.product_variant_id = v.id
GROUP BY p.id, p.name
ORDER BY p.id;

-- 5. Listar órdenes con datos de cliente
SELECT
    o.id AS order_id,
    o.order_date,
    o.status,
    c.full_name,
    c.email
FROM orders o
JOIN customers c ON c.id = o.customer_id
ORDER BY o.id;

-- 6. Detalle completo de una orden específica (por ID)
SELECT
    o.id AS order_id,
    c.full_name AS cliente,
    p.name AS producto,
    v.variant_name AS variante,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS subtotal
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN order_items oi ON oi.order_id = o.id
JOIN product_variants v ON v.id = oi.product_variant_id
JOIN products p ON p.id = v.product_id
WHERE o.id = 1;  -- Cambiar el número según la orden
;

-- 7. Clientes con más compras (por número de órdenes)
SELECT
    c.full_name,
    c.email,
    COUNT(o.id) AS total_ordenes
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.id
ORDER BY total_ordenes DESC;

-- 8. Productos más vendidos (por cantidad)
SELECT
    p.name AS producto,
    SUM(oi.quantity) AS cantidad_vendida
FROM order_items oi
JOIN product_variants v ON v.id = oi.product_variant_id
JOIN products p ON p.id = v.product_id
GROUP BY p.name
ORDER BY cantidad_vendida DESC;

-- 9. Ventas totales por producto (dinero)
SELECT
    p.name AS producto,
    SUM(oi.quantity * oi.unit_price) AS total_vendido
FROM order_items oi
JOIN product_variants v ON v.id = oi.product_variant_id
JOIN products p ON p.id = v.product_id
GROUP BY p.name
ORDER BY total_vendido DESC;

-- 10. Ventas totales (monto general del negocio)
SELECT
    SUM(oi.quantity * oi.unit_price) AS ingresos_totales
FROM order_items oi;

-- 11. Listado de todos los movimientos de inventario
SELECT
    m.id AS movimiento_id,
    p.name AS producto,
    v.variant_name,
    m.movement_type,
    m.quantity,
    m.movement_date
FROM inventory_movements m
JOIN product_variants v ON v.id = m.product_variant_id
JOIN products p ON p.id = v.product_id
ORDER BY m.id;

-- 12. Variantes sin stock disponible
SELECT
    v.id AS variant_id,
    p.name AS producto,
    v.variant_name,
    COALESCE(SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE -m.quantity END), 0) AS stock
FROM product_variants v
LEFT JOIN inventory_movements m ON m.product_variant_id = v.id
JOIN products p ON p.id = v.product_id
GROUP BY v.id, p.name, v.variant_name
HAVING COALESCE(SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE -m.quantity END), 0) <= 0
ORDER BY v.id;
