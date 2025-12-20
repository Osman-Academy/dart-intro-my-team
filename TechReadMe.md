# Technical Documentation for "Artifact Shop" Development

This document is intended for developers and describes the technical aspects of the project, including the stack, architecture, setup instructions, and database structure.

## 1. Architecture and Technology Stack

The project is implemented on a **"client-server"** principle, where the backend is a **Headless service** providing a REST API.

### 1.1. Backend

- **Language:** Java 17
- **Framework:** Spring Boot
- **Data Access:** Spring Data JPA / Hibernate
- **Database:** PostgreSQL
- **Security:** Spring Security (with JWT authentication)
- **Build System:** Apache Maven

### 1.2. Client Applications (Frontend)

The backend does not depend on the client implementation and can serve multiple applications simultaneously:
- **Web Application:** React / Next.js (or simple HTML/JS as in this project)
- **Mobile Application:** Flutter

Interaction between the client and server occurs exclusively via REST API, ensuring flexibility and independence of development.

## 2. Project Structure (Backend)

The project follows the standard Spring Boot application architecture:

```
src/main/java/com/example/onlineshop/
├── config/          # Configuration classes (e.g., SecurityConfig, JWT)
├── controller/      # REST controllers (handling HTTP requests, returning JSON)
├── dto/             # Data Transfer Objects (for data transfer between client and server)
├── entity/          # JPA entities (DB table descriptions)
├── repository/      # Spring Data repositories (for data access)
├── service/         # Service layer (business logic)
└── OnlineShopApplication.java # Main application class
```

- **`controller`**: Responsible for receiving HTTP requests, validating DTOs, and returning responses in JSON format.
- **`service`**: Contains the main business logic. Independent of HTTP, works with DTOs and entities.
- **`repository`**: Interfaces for interacting with the database.
- **`entity`**: Classes describing the data structure (tables in the DB).

## 3. Installation and Launch Instructions (Backend)

### Prerequisites:
- JDK 17 or higher
- Apache Maven 3.6+
- Installed and running PostgreSQL server

### Steps to Launch:

1.  **Clone the repository:**
    ```bash
    git clone <your-repo-url>
    cd online-shop
    ```

2.  **Configure the database:**
    - Create a new database in PostgreSQL:
      ```sql
      CREATE DATABASE online_shop_db;
      ```
    - Create a user (or use an existing one) with rights to this DB.

3.  **Configure the application:**
    - Open the `src/main/resources/application.yaml` file.
    - Specify your database connection settings (or use profiles).

4.  **Build and run the project:**
    ```bash
    mvn clean install
    mvn spring-boot:run
    ```
    The backend server will be running and available at `http://localhost:8080`.

## 4. Database Structure

Below is the schema of the main database tables.

---

### Table `users`
Stores information about registered users.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `BIGINT PRIMARY KEY` | Unique identifier |
| `username` | `VARCHAR(50) UNIQUE NOT NULL` | User login |
| `password` | `VARCHAR(255) NOT NULL` | Password hash |
| `email` | `VARCHAR(100) UNIQUE NOT NULL`| Email |
| `created_at` | `TIMESTAMP` | Registration date and time |

---

### Table `categories`
Product category directory.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `BIGINT PRIMARY KEY` | Unique identifier |
| `name` | `VARCHAR(100) UNIQUE NOT NULL`| Category name (e.g., "Furniture", "Clothing") |

---

### Table `products`
Main table with products.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `BIGINT PRIMARY KEY` | Unique identifier |
| `name` | `VARCHAR(255) NOT NULL` | Product name |
| `description`| `TEXT` | Detailed description |
| `price` | `DECIMAL(10, 2) NOT NULL` | Price |
| `status` | `VARCHAR(20) NOT NULL` | Status (`AVAILABLE`, `RESERVED`, `SOLD`) |
| `image_url` | `VARCHAR(255)` | Main image URL |
| `category_id`| `BIGINT` | Foreign key to `categories.id` |
| `created_at` | `TIMESTAMP` | Date product was added |

---

### Table `orders`
Stores information about orders.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `BIGINT PRIMARY KEY` | Unique identifier |
| `user_id` | `BIGINT NOT NULL` | Foreign key to `users.id` |
| `status` | `VARCHAR(30) NOT NULL` | Status (`NEW`, `PROCESSING`, `COMPLETED`, `CANCELLED`) |
| `total_amount`| `DECIMAL(10, 2)` | Total order amount |
| `created_at` | `TIMESTAMP` | Date and time order was created |

---

### Table `order_items`
Join table for orders and products (many-to-many relationship).

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `BIGINT PRIMARY KEY` | Unique identifier |
| `order_id` | `BIGINT NOT NULL` | Foreign key to `orders.id` |
| `product_id` | `BIGINT NOT NULL` | Foreign key to `products.id` |
| `quantity` | `INT NOT NULL` | Quantity of product units in the order |
| `price_at_purchase` | `DECIMAL(10, 2)` | Product price at the time of purchase |
