-- V1.1765201684__insert_initial_data.sql

-- Заполнение ролей
INSERT INTO roles (name) VALUES
('ROLE_USER'),
('ROLE_ADMIN');

-- Заполнение пользователей
-- Пароль для всех: "password" (в зашифрованном виде, используйте BCrypt)
-- Пример хеша для "password": $2a$10$jS2v.g5KNYG.dZJkY.c.k.Y8L8.B.C.D.E.F.G.H.I.J.K
-- ВАЖНО: Перед запуском приложения, сгенерируйте актуальные BCrypt хеши для паролей.
-- Для примера здесь используется плейсхолдер.
INSERT INTO users (username, password, email) VALUES
('admin', '$2a$10$cT.jV/mO9.dZJkY.c.k.Y8L8.B.C.D.E.F.G.H.I.J.K', 'admin@example.com'),
('user', '$2a$10$cT.jV/mO9.dZJkY.c.k.Y8L8.B.C.D.E.F.G.H.I.J.K', 'user@example.com');

-- Назначение ролей пользователям
-- ID ролей: 1 = ROLE_USER, 2 = ROLE_ADMIN
-- ID пользователей: 1 = admin, 2 = user
INSERT INTO m2m_user_roles (user_id, role_id) VALUES
(1, 2), -- admin -> ROLE_ADMIN
(1, 1), -- admin -> ROLE_USER (админ также является пользователем)
(2, 1); -- user -> ROLE_USER

-- Заполнение категорий
INSERT INTO categories (name) VALUES
('Мебель'),
('Электроника'),
('Одежда'),
('Книги');

-- Заполнение продуктов
INSERT INTO products (name, description, price, status, category_id) VALUES
('Старинный деревянный стул', 'Отреставрированный стул из дуба, начало XX века.', 1500.00, 'AVAILABLE', 1),
('Ламповый радиоприемник', 'Рабочий радиоприемник "Ригонда", 1965 год. Теплый ламповый звук.', 3500.00, 'AVAILABLE', 2),
('Винтажное пальто', 'Шерстяное пальто, 70-е годы. Отличное состояние.', 2200.00, 'AVAILABLE', 3),
('Коллекция "Мастер и Маргарита"', 'Редкое издание 1980 года.', 1200.00, 'AVAILABLE', 4),
('Торшер "Космос"', 'Футуристический торшер из 60-х. Полностью в рабочем состоянии.', 4800.00, 'AVAILABLE', 2),
('Походный рюкзак', 'Советский брезентовый рюкзак. Неубиваемый.', 800.00, 'SOLD', 3);

-- Создание тестового заказа для пользователя 'user' (id=2)
INSERT INTO orders (user_id, status, total_amount) VALUES
(2, 'COMPLETED', 2700.00);

-- Добавление товаров в тестовый заказ (order_id=1)
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 1500.00), -- Старинный деревянный стул
(1, 4, 1, 1200.00); -- Коллекция "Мастер и Маргарита"
