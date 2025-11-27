-- ============================================================
-- SEED – Carga inicial de datos reales
-- ============================================================

-- ============================================================
-- 1. INSERTAR PRODUCTOS
-- ============================================================

INSERT INTO products (name, description, price, is_clothing, is_shoes, gender)
VALUES
( 'Polera Algodón', 'Polera de Algodón Peruano, mangas cortas', 15999, TRUE, FALSE, 'Hombre' ),
( 'Jeans Ajustados', 'Pantalón denim elástico con corte moderno', 25999, TRUE, FALSE, 'Hombre' ),
( 'Zapatillas Deportivas', 'Zapatillas cómodas para correr o caminar', 45999, FALSE, TRUE, 'Hombre' ),
( 'Gorra Urbana', 'Gorra ajustable con diseño streetwear', 8999, FALSE, FALSE, 'Hombre' ),
( 'Reloj Clásico', 'Mecanismo suizo de alta precisión', 89999, FALSE, FALSE, 'Hombre' ),
( 'Bolso de Mano', 'Bolso elegante con múltiples compartimentos', 34999, FALSE, FALSE, 'Mujer' ),
( 'Auriculares Wireless', 'Cancelación de ruido y batería de 20h', 59999, FALSE, FALSE, 'Hombre' ),
( 'Mochila Viajera', 'Resistente al agua con espacio para laptop', 49999, FALSE, FALSE, 'Mujer' ),
( 'Poleron Oversize', 'Sudadera cómoda con capucha y estilo urbano', 28999, TRUE, FALSE, 'Hombre' ),
( 'Billetera de Cuero', 'Cartera minimalista con ranuras para tarjetas', 19999, FALSE, FALSE, 'Hombre' ),
( 'Zapatillas Casual', 'Zapatillas versátiles para ciudad y ocio', 39999, FALSE, TRUE, 'Mujer' ),
( 'Bufanda de Lana', 'Suave y abrigada para invierno', 12999, TRUE, FALSE, 'Mujer' );

