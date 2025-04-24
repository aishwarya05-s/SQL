/*All customers from California, ordered by last name*/
use bikes;
select * from customers
where state = "CA"
order by last_name;

/*List all products with a price greater than 500, grouped by brand*/
SELECT brand_id, COUNT(*) AS product_count
FROM products
WHERE list_price > 500
GROUP BY brand_id;

/*Count orders made by each customer*/
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

/*Orders with the names of the customers who placed them*/
SELECT o.order_id, c.first_name, c.last_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

/*Show all products and their stock levels*/
SELECT p.product_name, s.quantity
FROM products p
LEFT JOIN stocks s ON p.product_id = s.product_id;

/*Show all stock entries and include product info where available:*/
SELECT p.product_name, s.quantity
FROM stocks s
RIGHT JOIN products p ON s.product_id = p.product_id;


SELECT product_name, list_price,
  (SELECT AVG(list_price) FROM products) AS avg_price
FROM products;

/*Total revenue per store*/
SELECT s.store_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.store_name;


CREATE VIEW view_store_revenue AS
SELECT s.store_id, s.store_name,
       SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM stores s
JOIN orders o ON s.store_id = o.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_id, s.store_name;

select * from view_store_revenue;



