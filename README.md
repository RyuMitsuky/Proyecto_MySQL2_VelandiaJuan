# Modelo Entidad–Relación Pizzería Don Piccolo

Primer diseño del modelo de base de datos para el sistema de gestión de pedidos y domicilios.

## Diagrama Mermaid

```mermaid
erDiagram

    usuario {
        int id_usuario
        string nombre
        string telefono
        string email
        string tipo_usuario
        string password
    }

    cliente {
        int id_cliente
        string direccion
    }

    repartidor {
        int id_repartidor
        string zona
        string estado
    }

    pizzas {
        int id_pizza
        string nombre
        string tamaño
        float precio_base
        string tipo
    }

    ingredientes {
        int id_ingrediente
        string nombre
        string tipo
        int stock
        int stock_minimo
    }

    pizza_ingrediente {
        int id_pizza_ingrediente
        int cantidad
    }

    pedidos {
        int id_pedido
        string fecha_hora
        string estado
        float total
        string metodo_pago
    }

    pedido_pizza {
        int id_pedido_pizza
        int cantidad
    }

    domicilios {
        int id_domicilio
        string hora_salida
        string hora_entrega
        float distancia
        float costo_envio
    }

    pagos {
        int id_pago
        float monto
    }

    usuario ||--|{ cliente : es
    usuario ||--|{ repartidor : es

    cliente ||--o{ pedidos : realiza
    pedidos ||--o{ pedido_pizza : contiene
    pedido_pizza ||--|| pizzas : pizza
    pizzas ||--o{ pizza_ingrediente : requiere
    ingredientes ||--o{ pizza_ingrediente : ingrediente

    pedidos ||--|| domicilios : tiene
    pedidos ||--|| pagos : pago
    repartidor ||--o{ pedidos : entrega
