

-- Concept 7 - SUM

-- 1 
SELECT SUM(poster_qty) as total_poster 
FROM orders

-- 2
SELECT SUM(standard_qty) as total_standard
FROM orders

-- 3
SELECT SUM(total_amt_usd) as total_dollar_sales
FROM orders

-- 4
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders

-- 5
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

-- Concept 11 - MIN, MAX, Average

-- 1 
SELECT MIN(occurred_at) AS earliest_date
FROM orders

-- 2
SELECT occurred_at 
FROM orders 
ORDER BY occurred_at
LIMIT 1;

-- 3
SELECT MAX(occurred_at) AS latest_event
FROM web_events

-- 4
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1

-- 5 
SELECT AVG(standard_qty) mean_standard, AVG(gloss_qty) mean_gloss, 
        AVG(poster_qty) mean_poster, AVG(standard_amt_usd) mean_standard_usd, 
        AVG(gloss_amt_usd) mean_gloss_usd, AVG(poster_amt_usd) mean_poster_usd
FROM orders;

-- 6
SELECT *
FROM (SELECT total_amt_usd
   FROM orders
   ORDER BY total_amt_usd
   LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- Concept 14 - Group By

-- 1
SELECT o.occurred_at, a.name
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
ORDER BY o.occurred_at, a.name
LIMIT 1;

-- 2
SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

-- 3
SELECT a.name,w.channel, w.occurred_at
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
ORDER BY occurred_at DESC
LIMIT 1;

-- 4
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel

-- 5
SELECT a.primary_poc
FROM web_events w
JOIN accounts AS a
ON w.account_id = a.id
ORDER BY w.occurred_at 
LIMIT 1

-- 6
SELECT a.name, SUM(o.total_amt_usd) total_usd 
FROM orders AS o 
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_usd

-- 7
SELECT r.name, COUNT(*) number_of_sales_reps
FROM sales_reps AS s 
JOIN region AS r
ON s.region_id = r.id
GROUP BY r.name
ORDER BY number_of_sales_reps

-- Concept 17 - Group By Part 2

-- 1 
SELECT a.name, AVG(o.standard_qty) standard, AVG(o.gloss_qty) gloss, AVG(o.poster_qty) poster
FROM accounts AS a 
JOIN orders AS o 
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY a.name

-- 2 
SELECT a.name, AVG(o.standard_amt_usd) standard_usd, AVG(o.gloss_amt_usd) gloss_usd, AVG(o.poster_amt_usd) poster_usd
FROM accounts AS a 
JOIN orders AS o 
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY a.name

-- 3
SELECT s.name, w.channel, COUNT(*) no_of_time
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY no_of_time DESC

-- 4 
SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;
