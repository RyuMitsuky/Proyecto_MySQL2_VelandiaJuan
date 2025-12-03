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
