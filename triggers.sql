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
