-- Kpis
SELECT
    ROUND(SUM(net_revenue), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_revenue) * 1.0 / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM sales;

-- Revenue By Month
SELECT
    strftime('%Y-%m', date) AS month,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit
FROM sales
GROUP BY month
ORDER BY month;

-- Revenue By Location
SELECT
    location,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(net_revenue) * 1.0 / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM sales
GROUP BY location
ORDER BY revenue DESC;

-- Product Performance
SELECT
    product,
    category,
    ROUND(SUM(net_revenue), 2) AS revenue,
    SUM(quantity) AS units_sold,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) * 100.0 / SUM(net_revenue), 1) AS margin_pct
FROM sales
GROUP BY product, category
ORDER BY revenue DESC;

-- Category Performance
SELECT
    category,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) * 100.0 / SUM(net_revenue), 1) AS margin_pct
FROM sales
GROUP BY category
ORDER BY revenue DESC;

-- Revenue By Dow
SELECT
    day_of_week,
    ROUND(SUM(net_revenue), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM sales
GROUP BY day_of_week;

-- Revenue By Hour
SELECT
    hour,
    ROUND(SUM(net_revenue), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM sales
GROUP BY hour
ORDER BY hour;

-- Discount Impact
SELECT
    CASE WHEN discount_pct > 0 THEN 'Discounted' ELSE 'Full Price' END AS order_type,
    ROUND(SUM(net_revenue), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(SUM(profit) * 100.0 / SUM(net_revenue), 1) AS margin_pct,
    COUNT(*) AS line_items
FROM sales
GROUP BY order_type;

