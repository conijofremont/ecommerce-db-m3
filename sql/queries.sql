
-- 1) Buscar productos por nombre o si son ropa
-- ============================================================
SELECT p.*
FROM products p
WHERE LOWER(p.name) LIKE LOWER('%polera%')
   OR p.is_clothing = TRUE;


-- ============================================================
-- 2) Variantes con stock bajo (<10)
-- ============================================================
WITH stock AS (
    SELECT 
        pv.id,
        p.name,
        pv.variant_name,
        SUM(CASE WHEN im.movement_type='IN' THEN im.quantity ELSE -im.quantity END) AS stock
    FROM product_variants pv
    JOIN products p ON p.id = pv.product_id
    LEFT JOIN inventory_movements im ON im.product_variant_id = pv.id
    GROUP BY pv.id, p.name, pv.variant_name
)
SELECT * FROM stock
WHERE stock < 10
ORDER BY stock ASC;


-- ============================================================
-- 3) Productos sin ventas (ningún item vendido)
-- ============================================================
SELECT p.id, p.name
FROM products p
LEFT JOIN product_variants pv ON pv.product_id = p.id
LEFT JOIN order_items oi ON oi.product_variant_id = pv.id
WHERE oi.id IS NULL
GROUP BY p.id;


-- ============================================================
-- 4) Clientes frecuentes (2 o más compras)
-- ============================================================
SELECT 
    c.full_name,
    c.email,
    COUNT(o.id) AS total_orders
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.id
HAVING COUNT(o.id) >= 2
ORDER BY total_orders DESC;


-- ============================================================
-- 5) Ventas totales por día
-- ============================================================
SELECT
    DATE(o.order_date) AS day,
    SUM(oi.unit_price * oi.quantity) AS total_sales
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
GROUP BY day
ORDER BY day DESC;


-- ============================================================
-- 6) TOP 5 productos más vendidos
-- ============================================================
SELECT
    p.name,
    SUM(oi.quantity) AS total_qty,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN product_variants pv ON pv.product_id = p.id
JOIN order_items oi ON oi.product_variant_id = pv.id
GROUP BY p.name
ORDER BY total_sales DESC
LIMIT 5;


-- ============================================================
-- 7) Ventas por género (Hombre / Mujer)
-- ============================================================
SELECT
    p.gender,
    SUM(oi.unit_price * oi.quantity) AS total_sales
FROM products p
JOIN product_variants pv ON pv.product_id = p.id
JOIN order_items oi ON oi.product_variant_id = pv.id
GROUP BY p.gender
ORDER BY total_sales DESC;


-- ============================================================
-- 8) Stock total por producto (sumando tallas)
-- ============================================================
SELECT
    p.name,
    SUM(CASE 
            WHEN im.movement_type='IN'  THEN im.quantity
            WHEN im.movement_type='OUT' THEN -im.quantity
        END) AS total_stock
FROM products p
JOIN product_variants pv ON pv.product_id = p.id
LEFT JOIN inventory_movements im ON im.product_variant_id = pv.id
GROUP BY p.name
ORDER BY total_stock DESC;


-- ============================================================
-- 9) Ver todas las tallas disponibles de un producto
-- ============================================================
SELECT 
    p.name,
    pv.variant_name
FROM products p
JOIN product_variants pv ON pv.product_id = p.id
WHERE p.name = 'Polera Algodón';


-- ============================================================
-- 10) Ventas totales por talla
-- ============================================================
SELECT
    p.name AS product,
    pv.variant_name AS size,
    SUM(oi.quantity) AS quantity_sold
FROM product_variants pv
JOIN products p ON p.id = pv.product_id
JOIN order_items oi ON oi.product_variant_id = pv.id
GROUP BY p.name, pv.variant_name
ORDER BY quantity_sold DESC;


-- ============================================================
-- 11) Dinero gastado por cada cliente
-- ============================================================
SELECT
    c.full_name,
    c.email,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id
ORDER BY total_spent DESC;


-- ============================================================
-- 12) Ingresos totales del ecommerce
-- ============================================================
SELECT
    SUM(oi.unit_price * oi.quantity) AS total_revenue
FROM order_items oi;


-- ============================================================
-- 13) Cantidad de productos distintos que ha comprado un cliente
-- ============================================================
SELECT
    c.full_name,
    COUNT(DISTINCT p.id) AS different_products_purchased
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
JOIN product_variants pv ON pv.id = oi.product_variant_id
JOIN products p ON p.id = pv.product_id
GROUP BY c.id;


-- ============================================================
-- 14) Productos con más variantes (cantidad de tallas)
-- ============================================================
SELECT
    p.name,
    COUNT(pv.id) AS total_variants
FROM products p
JOIN product_variants pv ON pv.product_id = p.id
GROUP BY p.id
ORDER BY total_variants DESC;


-- ============================================================
-- 15) Ventas por tipo de producto (ropa vs zapatillas)
-- ============================================================
SELECT
    CASE 
        WHEN p.is_clothing THEN 'Ropa'
        WHEN p.is_shoes THEN 'Zapatillas'
        ELSE 'Accesorio'
    END AS category,
    SUM(oi.unit_price * oi.quantity) AS total_sales
FROM products p
JOIN product_variants pv ON pv.product_id = p.id
JOIN order_items oi ON oi.product_variant_id = pv.id
GROUP BY category
ORDER BY total_sales DESC;
