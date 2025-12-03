-- calcular total pedido con el iva


DROP FUNCTION IF EXISTS calcular_total_pedido;

DELIMITER $$

CREATE FUNCTION calcular_total_pedido(id_pedido_parametro INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_pizzas DECIMAL(10,2);
    DECLARE total_envio DECIMAL(10,2);
    DECLARE iva_valor DECIMAL(5,4) DEFAULT 0.19;

    SELECT COALESCE(SUM(PIZZA.precio_base * PEDIDO_PIZZA.cantidad), 0)
    INTO total_pizzas
    FROM PEDIDO_PIZZA
    INNER JOIN PIZZA ON PIZZA.id_pizza = PEDIDO_PIZZA.id_pizza
    WHERE PEDIDO_PIZZA.id_pedido = id_pedido_parametro;

    SELECT COALESCE(DOMICILIO.costo_envio, 0)
    INTO total_envio
    FROM DOMICILIO
    WHERE DOMICILIO.id_pedido = id_pedido_parametro
    LIMIT 1;

    RETURN ROUND((total_pizzas + total_envio) * (1 + iva_valor), 2);
END$$

DELIMITER ;


SELECT calcular_total_pedido(1);

-- Calcular la ganancia diaria

DROP FUNCTION IF EXISTS calcular_ganancia_diaria;

DELIMITER $$

CREATE FUNCTION calcular_ganancia_diaria(fecha_consulta DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE ventas DECIMAL(10,2);
    DECLARE costos DECIMAL(10,2);

    SELECT IFNULL(SUM(total),0)
    INTO ventas
    FROM PEDIDO
    WHERE DATE(fecha_hora) = fecha_consulta;

    SELECT IFNULL(SUM(PIZZA_INGREDIENTE.cantidad * INGREDIENTE.precio_unitario),0)
    INTO costos
    FROM PEDIDO
    JOIN PEDIDO_PIZZA ON PEDIDO.id_pedido = PEDIDO_PIZZA.id_pedido
    JOIN PIZZA_INGREDIENTE ON PEDIDO_PIZZA.id_pizza = PIZZA_INGREDIENTE.id_pizza
    JOIN INGREDIENTE ON PIZZA_INGREDIENTE.id_ingrediente = INGREDIENTE.id_ingrediente
    WHERE DATE(PEDIDO.fecha_hora) = fecha_consulta;

    RETURN ventas - costos;
END$$

DELIMITER ;

SELECT calcular_ganancia_diaria(CURDATE());
SELECT calcular_ganancia_diaria('2025-12-02');


-- Actualizar estado

DROP PROCEDURE IF EXISTS actualizar_estado_entregado;

DELIMITER $$



CREATE PROCEDURE actualizar_estado_entregado()
BEGIN
    UPDATE PEDIDO
    JOIN DOMICILIO ON PEDIDO.id_pedido = DOMICILIO.id_pedido
    SET PEDIDO.estado = 'entregado'
    WHERE DOMICILIO.hora_entrega IS NOT NULL
    AND PEDIDO.estado <> 'entregado';
END$$

CALL actualizar_estado_entregado();


DELIMITER ;


