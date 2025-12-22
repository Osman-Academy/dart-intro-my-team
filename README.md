# Cosmetics Catalog App (Charlotte Tilbury)

## Description
This project is a cosmetics product catalog application developed with Flutter.
The app allows users to browse cosmetic products, search products by pattern, filter them by category, view detailed product information, and add products to a shopping cart.

The project is inspired by the official Charlotte Tilbury(cosmetics brand) website and is created for educational purposes.

## Features
- Product catalog with categories (Face, Cheek, Eyes, Lips)
- Pattern-based search (supports `*` and `?`)
- Product details page
- Shopping cart with quantity management
- Total price and item count calculation

## Architecture and Technologies
- Clean Architecture
- BLoC / Cubit for state management
- Dependency Injection (GetIt)
- Freezed annotations and JSON serialization
- Dio for HTTP requests
- Cached Network Image for product images

## Backend
The application is connected to a local backend server.

Endpoint used:
GET http://localhost:3000/products

Product data is retrieved from the backend in JSON format.
Only source code is included in the repository. Build files, node_modules, and binaries are excluded.


