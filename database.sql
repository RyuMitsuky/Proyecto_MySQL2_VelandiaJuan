-- Creacion de tablas

CREATE TABLE PERSONA (
    id_persona INT PRIMARY KEY,
    nombre VARCHAR(255),
    telefono VARCHAR(255),
    direccion VARCHAR(255),
    correo VARCHAR(255),
    tipo ENUM('cliente', 'repartidor', 'vendedor')
);

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY,
    id_persona INT,
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
);

CREATE TABLE ZONA (
    id_zona INT PRIMARY KEY,
    nombre VARCHAR(255),
    costo_envio_base DECIMAL(10,2)
);

CREATE TABLE REPARTIDOR (
    id_repartidor INT PRIMARY KEY,
    id_persona INT,
    id_zona INT,
    estado ENUM('activo', 'inactivo'),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona),
    FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona)
);

CREATE TABLE VENDEDOR (
    id_vendedor INT PRIMARY KEY,
    id_persona INT,
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
);

CREATE TABLE PIZZA (
    id_pizza INT PRIMARY KEY,
    nombre VARCHAR(255),
    precio_base DECIMAL(10,2),
    tipo ENUM('grande', 'mediana', 'pequena')
);

CREATE TABLE INGREDIENTE (
    id_ingrediente INT PRIMARY KEY,
    nombre VARCHAR(255),
    stock INT,
    stock_minimo INT,
    precio_unitario DECIMAL(10,2)
);

CREATE TABLE PIZZA_INGREDIENTE (
    id_pizza INT,
    id_ingrediente INT,
    cantidad INT,
    FOREIGN KEY (id_pizza) REFERENCES PIZZA(id_pizza),
    FOREIGN KEY (id_ingrediente) REFERENCES INGREDIENTE(id_ingrediente)
);

CREATE TABLE PEDIDO (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    id_vendedor INT,
    fecha_hora DATETIME,
    estado ENUM('pendiente', 'en_preparacion', 'enviado', 'entregado', 'cancelado'),
    metodo_pago ENUM('tarjeta', 'efectivo', 'transferencia'),
    tipo_pedido ENUM('local', 'domicilio'),
    estado_pago ENUM('pago', 'abono', 'sin_pagar'),
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES VENDEDOR(id_vendedor)
);

CREATE TABLE PEDIDO_PIZZA (
    id_pedido INT,
    id_pizza INT,
    cantidad INT,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_pizza) REFERENCES PIZZA(id_pizza)
);

CREATE TABLE DOMICILIO (
    id_domicilio INT PRIMARY KEY,
    id_pedido INT,
    id_repartidor INT,
    hora_salida DATETIME,
    hora_entrega DATETIME,
    distancia DECIMAL(10,2),
    costo_envio DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_repartidor) REFERENCES REPARTIDOR(id_repartidor)
);


-- Base de datos, la data cruda necesaria para que funciones los disparadores, funciones, consultas y las vistas

INSERT INTO PERSONA (id_persona, nombre, telefono, direccion, correo, tipo) VALUES
(1, 'Carlos López', '3001111111', 'Calle 10 #5-20', 'carlos@example.com', 'cliente'),
(2, 'María Torres', '3001112222', 'Calle 11 #4-30', 'maria@example.com', 'cliente'),
(3, 'Juan Pérez', '3001113333', 'Calle 12 #8-14', 'juan@example.com', 'cliente'),
(4, 'Ana Gómez', '3001114444', 'Calle 20 #3-12', 'ana@example.com', 'cliente'),
(5, 'Luis Rojas', '3001115555', 'Calle 21 #7-45', 'luis@example.com', 'cliente'),
(6, 'Paula Suárez', '3001116666', 'Calle 22 #9-17', 'paula@example.com', 'cliente'),
(7, 'Diana Castro', '3102221111', 'Cra 50 #10-23', 'diana@example.com', 'repartidor'),
(8, 'Ricardo Méndez', '3102222222', 'Cra 51 #3-12', 'ricardo@example.com', 'repartidor'),
(9, 'Sergio Pinto', '3102223333', 'Cra 52 #20-11', 'sergio@example.com', 'repartidor'),
(10, 'Jorge Ramírez', '3102224444', 'Cra 53 #2-14', 'jorge@example.com', 'repartidor'),
(11, 'Mateo Álvarez', '3102225555', 'Cra 54 #15-17', 'mateo@example.com', 'repartidor'),
(12, 'Luisa Herrera', '3102226666', 'Cra 55 #18-21', 'luisa@example.com', 'repartidor'),
(13, 'Camilo Vargas', '3203331111', 'Av 1 #10-10', 'camilo@example.com', 'vendedor'),
(14, 'David Cárdenas', '3203332222', 'Av 2 #20-11', 'david@example.com', 'vendedor'),
(15, 'Andrea Muñoz', '3203333333', 'Av 3 #5-33', 'andrea@example.com', 'vendedor'),
(16, 'Tatiana León', '3203334444', 'Av 4 #8-14', 'tatiana@example.com', 'vendedor'),
(17, 'Gabriel Silva', '3203335555', 'Av 5 #12-50', 'gabriel@example.com', 'vendedor'),
(18, 'Esteban Quintero', '3203336666', 'Av 6 #25-20', 'esteban@example.com', 'vendedor');

INSERT INTO CLIENTE VALUES
(1, 1),(2, 2),(3, 3),(4, 4),(5, 5),(6, 6);

INSERT INTO ZONA VALUES
(1, 'Norte', 4000),
(2, 'Centro', 3000),
(3, 'Sur', 5000);

INSERT INTO REPARTIDOR VALUES
(1, 7, 1, 'activo'),
(2, 8, 2, 'activo'),
(3, 9, 3, 'inactivo'),
(4, 10, 1, 'activo'),
(5, 11, 2, 'activo'),
(6, 12, 3, 'inactivo');

INSERT INTO VENDEDOR VALUES
(1, 13),(2, 14),(3, 15),(4, 16),(5, 17),(6, 18);

INSERT INTO PIZZA VALUES
(1, 'Hawaiana', 24000, 'mediana'),
(2, 'Pepperoni', 26000, 'grande'),
(3, 'Mexicana', 28000, 'grande'),
(4, 'Pollo Champiñón', 25000, 'mediana'),
(5, 'Vegetariana', 23000, 'pequeña'),
(6, 'Carnes', 30000, 'grande');

INSERT INTO INGREDIENTE VALUES
(1, 'Queso', 200, 50, 300),
(2, 'Jamón', 150, 40, 500),
(3, 'Piña', 100, 20, 400),
(4, 'Pepperoni', 180, 30, 600),
(5, 'Carne molida', 120, 20, 700),
(6, 'Champiñones', 140, 30, 350),
(7, 'Cebolla', 160, 30, 200),
(8, 'Tomate', 170, 40, 250),
(9, 'Tocino', 130, 20, 650),
(10, 'Pollo', 150, 30, 550);

INSERT INTO PIZZA_INGREDIENTE VALUES
(1, 1, 2),(1, 2, 2),(1, 3, 2),
(2, 1, 2),(2, 4, 3),
(3, 1, 2),(3, 5, 3),(3, 7, 1),
(4, 1, 2),(4, 6, 2),(4, 10, 2),
(5, 1, 1),(5, 7, 1),(5, 8, 2),
(6, 1, 2),(6, 4, 3),(6, 5, 3),(6, 9, 2);

INSERT INTO PEDIDO VALUES
(1, 1, 1, '2025-12-02 10:00:00', 'pendiente', 'efectivo', 'domicilio', 'sin_pagar', 26000),
(2, 2, 2, '2025-12-02 11:15:00', 'en_proceso', 'tarjeta', 'local', 'pago', 24000),
(3, 3, 3, '2025-12-02 12:40:00', 'entregado', 'transferencia', 'domicilio', 'pago', 30000),
(4, 4, 4, '2025-12-02 13:10:00', 'cancelado', 'efectivo', 'local', 'sin_pagar', 0),
(5, 5, 5, '2025-12-02 14:00:00', 'en_camino', 'efectivo', 'domicilio', 'abono', 28000),
(6, 6, 6, '2025-12-02 15:30:00', 'pendiente', 'tarjeta', 'local', 'pago', 23000);

INSERT INTO PEDIDO_PIZZA VALUES
(1, 2, 1),
(2, 1, 1),
(3, 6, 1),
(5, 3, 1),
(6, 5, 1);

INSERT INTO DOMICILIO VALUES
(1, 1, 1, '2025-12-02 10:10:00', NULL, 3.2, 4000),
(2, 3, 2, '2025-12-02 12:50:00', '2025-12-02 13:20:00', 5.1, 5000),
(3, 5, 5, '2025-12-02 14:10:00', NULL, 2.8, 3000),
(4, 1, 4, '2025-12-02 10:15:00', NULL, 3.5, 4000);
