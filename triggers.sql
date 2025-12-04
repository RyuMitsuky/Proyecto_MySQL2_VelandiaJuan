DELIMITER //
CREATE TRIGGER trg_actualizar_stock_after_insert_pedido_pizza
AFTER INSERT ON PEDIDO_PIZZA
FOR EACH ROW
BEGIN
    UPDATE INGREDIENTE i
    JOIN PIZZA_INGREDIENTE pi ON i.id_ingrediente = pi.id_ingrediente
    SET i.stock = i.stock - (pi.cantidad * NEW.cantidad)
    WHERE pi.id_pizza = NEW.id_pizza;
END;
//
DELIMITER ;



-- Pedido de prueba para comprobar que funciona el disparador
INSERT INTO PEDIDO_PIZZA (id_pedido, id_pizza, cantidad)
VALUES (2, 3, 2);


-- Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.

CREATE TABLE historial_precios (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_pizza INT,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_pizza_cambio_precio
AFTER UPDATE ON pizza
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO historial_precios (id_pizza, precio_anterior, precio_nuevo)
        VALUES (OLD.id_pizza, OLD.precio, NEW.precio);
    END IF;
END$$

DELIMITER ;
