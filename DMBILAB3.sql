-- 1. Monthly Sales Trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS total_sales
FROM orders
GROUP BY month
ORDER BY month;

-- 2. Top 5 Customers by Revenue
SELECT
    c.customer_id,
    c.name AS customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC
LIMIT 5;

-- 3. Best-Selling Products (by quantity)
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC
LIMIT 10;

-- 4. Revenue by Region
SELECT
    c.region,
    SUM(o.total_amount) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY revenue DESC;

-- 5. Year-over-Year Sales Growth
SELECT
    EXTRACT(YEAR FROM order_date) AS sales_year,
    SUM(total_amount) AS yearly_sales
FROM orders
GROUP BY sales_year
ORDER BY sales_year;

-- 6. Inactive Customers (No Orders)
SELECT
    c.customer_id,
    c.name AS customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 7. Sales Performance by Employee
SELECT
    e.employee_id,
    e.name AS employee_name,
    SUM(o.total_amount) AS employee_sales
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.name
ORDER BY employee_sales DESC;

-- 8. Category-wise Product Sales Revenue
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 9. Average Order Value (AOV)
SELECT
    AVG(total_amount) AS average_order_value
FROM orders;

-- 10. Daily Sales Summary (Last 7 Days)
SELECT
    order_date,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS daily_sales
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY order_date
ORDER BY order_date DESC;
