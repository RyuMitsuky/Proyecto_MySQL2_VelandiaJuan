
-- Clientes con pedidos entre dos fechas (BETWEEN).
SELECT *
FROM pedido
WHERE fecha_hora BETWEEN '2025-01-01' AND '2025-12-31';

--Pizzas más vendidas (GROUP BY y COUNT).

SELECT p.nombre, COUNT(dp.id_pizza) AS cantidad
FROM detalle_pedido dp
JOIN pizza p ON dp.id_pizza = p.id_pizza
GROUP BY p.id_pizza, p.nombre
ORDER BY cantidad DESC;

-- Pedidos por repartidor (JOIN).
SELECT r.nombre AS repartidor, COUNT(d.id_domicilio) AS entregas
FROM domicilio d
JOIN repartidor r ON d.id_repartidor = r.id_repartidor
GROUP BY r.id_repartidor, r.nombre;

-- Promedio de entrega por zona (AVG y JOIN).

SELECT z.nombre AS zona, AVG(d.tiempo_entrega) AS tiempo_promedio
FROM domicilio d
JOIN zona z ON d.id_zona = z.id_zona
GROUP BY z.id_zona, z.nombre;

-- Clientes que gastaron más de un monto (HAVING).

SELECT c.nombre, SUM(p.total) AS gastado
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING gastado > 50000;
