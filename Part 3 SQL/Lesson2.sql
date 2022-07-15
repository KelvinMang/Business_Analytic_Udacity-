-- Concept 18 - ORDER BY

-- 1 
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at 
LIMIT 10 

-- 2
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

-- 3
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

-- Concept 21 - ORDER BY part 2

-- 1
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC

--2 
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id

-- Concept 24 - WHERE 

-- 1
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

-- 2
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

-- Concept 30 - Arithmetic Operators

-- 1 
SELECT id, account_id, 
	standard_amt_usd/standard_qty AS unit_amt_usd
FROM orders
LIMIT 10

-- Concept 34 - LIKE 

-- 1
SELECT name
FROM accounts
WHERE name LIKE 'C%';

-- 2
SELECT name
FROM accounts
WHERE name LIKE '%one%';

-- 3
SELECT name
FROM accounts
WHERE name LIKE '%s';

-- Concept 37 - IN

-- 1
SELECT name, primary_poc, sales_rep_id
FROM accounts 
WHERE name IN ('Walmart','Target', 'Nordstrom')

-- 2
SELECT *
FROM web_events 
WHERE channel IN ('organic','adwords')

-- Concept 40 - NOT

-- 1
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart','Target', 'Nordstrom')

-- 2
SELECT *
FROM web_events
WHERE channel NOT IN ( 'organic', 'adwords')

-- 3
SELECT name
FROM web_events
WHERE channel NOT IN ( 'organic', 'adwords')

-- 4
SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

-- 5
SELECT name 
FROM accounts 
WHERE name NOT LIKE ('%s')

-- Concept 43 - AND and BETWEEN

-- 1 
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0 ;

-- 2
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

-- 3
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29 ;

-- 4
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

-- Concept 46 - OR

-- 1 
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

-- 2
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

-- 3
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
           AND primary_poc NOT LIKE '%eana%');