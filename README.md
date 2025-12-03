# Modelo Entidad–Relación Pizzería Don Piccolo

Segundo diseño del modelo de base de datos para el sistema de gestión de pedidos y domicilios.

## Diagrama Mermaid

```mermaid
erDiagram
    PERSONA {
        INT id_persona PK
        VARCHAR nombre
        VARCHAR telefono
        VARCHAR direccion
        VARCHAR correo
        ENUM tipo
    }

    CLIENTE {
        INT id_cliente PK
        INT id_persona FK
    }

    ZONA {
        INT id_zona PK
        VARCHAR nombre
        DECIMAL costo_envio_base
    }

    REPARTIDOR {
        INT id_repartidor PK
        INT id_persona FK
        INT id_zona FK
        ENUM estado
    }

    VENDEDOR {
        INT id_vendedor PK
        INT id_persona FK
    }

    PIZZA {
        INT id_pizza PK
        VARCHAR nombre
        DECIMAL precio_base
        ENUM tipo
    }

    INGREDIENTE {
        INT id_ingrediente PK
        VARCHAR nombre
        INT stock
        INT stock_minimo
        DECIMAL precio_unitario
    }

    PIZZA_INGREDIENTE {
        INT id_pizza FK
        INT id_ingrediente FK
        INT cantidad
    }

    PEDIDO {
        INT id_pedido PK
        INT id_cliente FK
        INT id_vendedor FK
        DATETIME fecha_hora
        ENUM estado
        ENUM metodo_pago
        ENUM tipo_pedido
        ENUM estado_pago
        DECIMAL total
    }

    PEDIDO_PIZZA {
        INT id_pedido FK
        INT id_pizza FK
        INT cantidad
    }

    DOMICILIO {
        INT id_domicilio PK
        INT id_pedido FK
        INT id_repartidor FK
        DATETIME hora_salida
        DATETIME hora_entrega
        DECIMAL distancia
        DECIMAL costo_envio
    }

    CLIENTE ||--|| PERSONA : hereda
    REPARTIDOR ||--|| PERSONA : hereda
    VENDEDOR ||--|| PERSONA : hereda
    REPARTIDOR }|--|| ZONA : asignado_a
    CLIENTE ||--o{ PEDIDO : realiza
    VENDEDOR ||--o{ PEDIDO : toma
    PEDIDO ||--o{ PEDIDO_PIZZA : contiene
    PIZZA ||--o{ PEDIDO_PIZZA : se_incluye_en
    PIZZA ||--o{ PIZZA_INGREDIENTE : tiene
    INGREDIENTE ||--o{ PIZZA_INGREDIENTE : usa
    PEDIDO ||--o{ DOMICILIO : tiene
    REPARTIDOR ||--o{ DOMICILIO : asignado_a
<<<<<<< HEAD
```
