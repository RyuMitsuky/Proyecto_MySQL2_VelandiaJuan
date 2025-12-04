-- Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).

CREATE VIEW vista_resumen_pedidos_cliente AS
SELECT 
    p.nombre AS nombre_cliente,
    COUNT(pe.id_pedido) AS cantidad_pedidos,
    SUM(pe.total) AS total_gastado
FROM CLIENTE c
JOIN PERSONA p ON c.id_persona = p.id_persona
LEFT JOIN PEDIDO pe ON c.id_cliente = pe.id_cliente
GROUP BY p.nombre;

-- Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).

CREATE VIEW vista_desempeno_repartidores AS
SELECT 
    per.nombre AS nombre_repartidor,
    COUNT(d.id_domicilio) AS numero_entregas,
    AVG(TIMESTAMPDIFF(MINUTE, d.hora_salida, d.hora_entrega)) AS tiempo_promedio,
    z.nombre AS zona
FROM REPARTIDOR r
JOIN PERSONA per ON r.id_persona = per.id_persona
JOIN ZONA z ON r.id_zona = z.id_zona
LEFT JOIN DOMICILIO d ON r.id_repartidor = d.id_repartidor
GROUP BY per.nombre, z.nombre;



-- Vista de stock de ingredientes por debajo del mínimo permitido.

CREATE VIEW vista_stock_bajo AS
SELECT 
    nombre,
    stock,
    stock_minimo
FROM INGREDIENTE
WHERE stock < stock_minimo;
