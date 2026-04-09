-- DROP TABLES (reset)
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS expenses;

-- CREATE TABLES

CREATE TABLE clinic_sales (
    sale_id INT PRIMARY KEY,
    sale_date TEXT,
    amount INT,
    sales_channel TEXT
);

CREATE TABLE expenses (
    expense_id INT PRIMARY KEY,
    expense_date TEXT,
    amount INT
);

-- INSERT DATA

INSERT INTO clinic_sales VALUES
(1, '2021-11-01', 500, 'Online'),
(2, '2021-11-05', 700, 'Offline'),
(3, '2021-12-01', 800, 'Online'),
(4, '2021-12-10', 600, 'Offline');

INSERT INTO expenses VALUES
(1, '2021-11-03', 300),
(2, '2021-11-20', 200),
(3, '2021-12-05', 400),
(4, '2021-12-15', 300);

SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
GROUP BY sales_channel;
SELECT 
    r.month,
    r.total_revenue,
    e.total_expense,
    (r.total_revenue - e.total_expense) AS profit
FROM
(
    SELECT 
        substr(sale_date, 1, 7) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    GROUP BY month
) r
JOIN
(
    SELECT 
        substr(expense_date, 1, 7) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    GROUP BY month
) e
ON r.month = e.month;

SELECT 
    substr(sale_date, 1, 7) AS month,
    SUM(amount) AS total_revenue
FROM clinic_sales
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 1;
SELECT 
    substr(expense_date, 1, 7) AS month,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY month;