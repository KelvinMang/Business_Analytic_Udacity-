

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

-- Concept 20 - DISTINCT

-- 1 
-- Both results have 351 rows, so no account works more than 1 region
SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;
--
SELECT DISTINCT id, name
FROM accounts;

-- 2
/*      all of the sales reps have worked on more than one account. 
        The fewest number of accounts any sales rep works on is 3. 
        There are 50 sales reps, and they all have more than one account.*/
        
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;
--
SELECT DISTINCT id, name
FROM sales_reps;

-- Concept 23 - HAVING

-- 1 
SELECT COUNT(*) no_of_sales_reps
FROM(SELECT s.name, COUNT(*) accounts
FROM sales_reps AS s
JOIN accounts AS a
ON a.sales_rep_id = s.id 
GROUP BY s.name
HAVING COUNT(*) > 5
ORDER BY accounts) AS Table_1

-- 2 
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

-- 3
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

-- 4
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

-- 5
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

-- 6
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1

-- 7
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent 
LIMIT 1

-- 8
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

-- 9 
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
WHERE w.channel = 'facebook'
ORDER BY use_of_channel DESC
LIMIT 1;

-- 10 
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;

-- Concept 27 - Date Function

-- 1 
SELECT DATE_PART('year', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- 2 
SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC; 

-- 3 
SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- 4 
SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_order
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC

-- 5 
SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o 
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--  Concept 31 CASE

-- 1 
SELECT account_id, total_amt_usd,
CASE WHEN total_amt_usd > 3000 THEN 'Large'
ELSE 'Small' END AS order_level
FROM orders;

-- 2 
SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;

-- 3 
SELECT a.name, SUM(total_amt_usd) total_spent, 
CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC;

-- 4 
SELECT a.name, SUM(total_amt_usd) total_spent, 
CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31' 
GROUP BY 1
ORDER BY 2 DESC;

-- 5
SELECT s.name, COUNT(*) num_ords,
  CASE WHEN COUNT(*) > 200 THEN 'top'
  ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;

-- 6
SELECT s.name, COUNT(*) num_ords, SUM(o.total_amt_usd) total_sales,
  CASE  WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
        WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 50000 THEN 'middle'
  ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;