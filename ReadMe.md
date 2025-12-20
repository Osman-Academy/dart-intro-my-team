# Diploma Project: Social Online Shop "Artifact Shop"

## 1. Concept and Social Significance

**"Artifact Shop"** is a web platform developed as a diploma project. The project represents a non-profit online shop created to address important social and environmental issues.

The main idea is to give a second life to items that are no longer needed by their previous owners and to direct the proceeds to help socially vulnerable groups of the population.

### Problems the project solves:

1.  **Waste Reduction.** In the modern world, a huge amount of usable items (clothing, appliances, household items) are sent to landfills. Our project offers a centralized mechanism for collecting, sorting, restoring, and further selling these items, promoting a culture of conscious consumption.

2.  **Inefficiency of "Flea Markets".** Platforms like classified ads work as bulletin boards where valuable and quality items get lost in a huge stream of offers without finding a new owner. "Artifact Shop" acts as a curator, presenting goods in a convenient and structured catalog.

3.  **Helping the Needy.** The project provides access to necessary and quality items at a symbolic price for people with low incomes.

4.  **Support for Social Foundations.** All proceeds from the sale of goods are directed to charitable foundations, providing them with a stable source of funding.

## 2. System Functionality

### User Roles:
*   **Guest (Unauthorized User):** Can view the product catalog.
*   **Customer (Registered User):** Can form a cart, place orders, and apply for items.
*   **Donor (Registered User):** Can donate items to the fund. The system can track donor activity for rewards.
*   **Admin:** Manages the product catalog, orders, users, and content on the site.

### Main Functionality:

1.  **Registration and Authorization:** Users can create an account and log in to access full functionality.
2.  **Product Catalog:**
    *   View a list of all products with filtering by category.
    *   Search for products by name, description, or SKU.
    *   Detailed page for each product.
3.  **Product Management (for Admin):**
    *   Add, edit, and delete products.
    *   Audit and inventory control.
    *   **Stagnation Control:** The system can track items that have not been sold for a long time for subsequent transfer to orphanages or other institutions.
4.  **Order System:**
    *   Shopping cart formation.
    *   Placing an order with a choice of receipt method (delivery or pickup/reserve).
    *   View order history in the personal account.
5.  **Social Functionality:**
    *   A registered user can apply for a free item by attaching the necessary supporting documents.

## 3. Technical Implementation

### Technology Stack:
*   **Backend:** Java 17, Spring Boot
*   **Database:** PostgreSQL
*   **Data Access:** Spring Data JPA (Hibernate)
*   **Security:** Spring Security
*   **Frontend:** HTML/CSS/JS (Single Page Application approach)
*   **Build Tool:** Maven

### API Architecture (REST-like endpoints):

*   **Users (`/users`):**
    *   `POST /register` - Register a new user.
    *   `GET /users` - Get a list of all users (Admin only).
    *   `PUT /users/{id}` - Update user data.
    *   `DELETE /users/{id}` - Delete a user.
*   **Products (`/products`):**
    *   `GET /products` - Get a list of all products.
    *   `GET /products/{id}` - Get a product by ID.
    *   `GET /products/search?q={query}` - Search by name/description.
    *   `POST /products` - Add a new product (Admin only).
    *   `PUT /products/{id}` - Update a product (Admin only).
    *   `DELETE /products/{id}` - Delete a product (Admin only).
*   **Orders (`/orders`):**
    *   `POST /orders` - Create a new order from the cart.
    *   `GET /orders` - Get a list of all orders (for Admin).
    *   `GET /users/{userId}/orders` - Get orders for a specific user.

### Order Workflow:
1.  The user forms a cart and places an order.
2.  The administrator sees the new order in the control panel.
3.  When issuing the item (e.g., at a pickup point), the customer provides their ID or login.
4.  The administrator finds the order in the system, closes it, and records the sale for reporting.
