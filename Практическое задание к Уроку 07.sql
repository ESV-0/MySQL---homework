-- Практическое задание к Уроку-07
-- 1. Составьте список пользователей users, которые осуществили хотя бы один
-- заказ orders в интернет магазине.
create table if not exists orders_products(
	id serial primary key,
    order_id bigint unsigned not null,
    product_id bigint unsigned not null,
    total int not null,
    foreign key (order_id) references orders (id),
    foreign key (product_id) references products (id)
);
INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Геннадий';
INSERT INTO orders_products (order_id, product_id, total)
SELECT LAST_INSERT_ID(), id, 2 FROM products
WHERE name = 'Intel Core i5-7400';
INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Наталья';
INSERT INTO orders_products (order_id, product_id, total)
SELECT LAST_INSERT_ID(), id, 1 FROM products
WHERE name IN ('Intel Core i5-7400', 'Gigabyte H310M S2H');
INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Иван';
INSERT INTO orders_products (order_id, product_id, total)
SELECT LAST_INSERT_ID(), id, 1 FROM products
WHERE name IN ('AMD FX-8320', 'ASUS ROG MAXIMUS X HERO');
SELECT id, name, birthday_at FROM users;
SELECT u.id, u.name, u.birthday_at
	FROM users AS u
	JOIN orders AS o ON u.id = o.user_id;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует
-- товару.
select * from catalogs;
SELECT
  p.id,
  p.name,
  p.price,
  c.name AS catalog
FROM products AS p
LEFT JOIN catalogs AS c ON p.catalog_id = c.id;

