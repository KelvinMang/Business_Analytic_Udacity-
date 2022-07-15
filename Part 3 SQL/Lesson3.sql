-- Concept 4 - JOIN

-- 1 
SELECT accounts.*, orders.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id 

-- 2
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty,accounts.website, accounts.primary_poc
FROM accounts
JOIN orders 
ON orders.account_id = accounts.id

-- Concept 11 - JOIH Part 2

-- 1
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

-- 2
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

-- 3
SELECT r.name Region_name, a.name Account_name, o.total_amt_usd/(o.total+0.01) AS Unit_price 
FROM accounts AS a
JOIN sales_reps AS s 
ON a.sales_rep_id = s.id 
JOIN region AS r
ON s.region_id = r.id 
JOIN orders AS o 
ON o.account_id = a.id 

SELECT r.name region, a.name account, 
 o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

-- Concept 19 - Last Check

-- 1
SELECT r.name region , s.name sales, a.name account
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON a.sales_rep_id = s.id
ORDER BY account

--2
SELECT r.name region , s.name sales, a.name account
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON a.sales_rep_id = s.id
WHERE s.name LIKE ('S%') AND r.name = 'Midwest'
ORDER BY account

-- 3
SELECT r.name region , s.name sales, a.name account
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON a.sales_rep_id = s.id
WHERE s.name LIKE ('%K') AND r.name = 'Midwest'
ORDER BY account

-- 4
SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unit_price
FROM region AS r
JOIN sales_reps AS s
ON s.region_id = r.id
JOIN accounts AS a 
ON a.sales_rep_id = s.id
JOIN orders AS o
ON o.account_id = a.id
WHERE o.standard_qty>100

-- 5
SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unit_price
FROM region AS r
JOIN sales_reps AS s
ON s.region_id = r.id
JOIN accounts AS a 
ON a.sales_rep_id = s.id
JOIN orders AS o
ON o.account_id = a.id
WHERE o.standard_qty>100 AND o.poster_qty>50
ORDER BY unit_price