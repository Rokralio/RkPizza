# 🍕 RKpizza: Constructor de Pizzas y Sistema de Gestión

Este proyecto es una aplicación web full-stack desarrollada con Ruby on Rails. Permite a los clientes construir pizzas personalizadas (Frontend) y proporciona una interfaz de administración segura (Backend) para gestionar bases, ingredientes y pedidos.

## 🚀 Características Principales

* **Constructor de Pizzas (Frontend):** Interfaz para seleccionar la base, el tamaño y los ingredientes, generando un precio total dinámico.
* **Gestión de Pedidos (Backend):** CRUD para Bases e Ingredientes. Listado y actualización de estado de los pedidos de los clientes.
* **Seguridad:** Rutas administrativas protegidas por **Autenticación HTTP Basic** (`Usuario: admin`, `Contraseña: password`).
* **Diseño:** Interfaz estilizada con **Tailwind CSS**.

---

## 🛠️ Configuración Local

Sigue estos pasos para levantar el proyecto en tu máquina local:

### Requisitos del Sistema

* **Ruby:** Versión 3.x
* **Rails:** Versión 7.x
* **Base de Datos:** **PostgreSQL** (Necesitas tener el servidor de PostgreSQL instalado y corriendo localmente).
* **Gestor de Dependencias:** Bundler

### Instalación

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://docs.github.com/es/repositories/creating-and-managing-repositories/quickstart-for-repositories](https://docs.github.com/es/repositories/creating-and-managing-repositories/quickstart-for-repositories)
    cd rkpizza
    ```

2.  **Instalar dependencias de Ruby:**
    ```bash
    bundle install
    ```

3.  **Configuración de la Base de Datos (PostgreSQL):**
    Asegúrate de que tu servicio local de PostgreSQL esté activo. Rails usará las credenciales configuradas en `config/database.yml`.

    ```bash
    # Crear la base de datos (desarrollo y pruebas)
    rails db:create
    
    # Ejecutar las migraciones
    rails db:migrate
    ```

4.  **Inicializar la Base de Datos (Semillas):**
    Carga los datos iniciales de bases e ingredientes.
    ```bash
    rails db:seed
    ```

### Ejecución

Para iniciar el servidor de desarrollo:

```bash
rails server