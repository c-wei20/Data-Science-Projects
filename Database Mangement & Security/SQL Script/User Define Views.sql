-- Create Views
USE DBS_ASSIGNMENT;
GO

--transaction details
CREATE OR ALTER View [dbo].[ORDERS_DETAILS]
AS
SELECT
	t.member_id,
	t.transaction_id,
	t.transaction_date,
	p.pur_item_id,
	e.equipment_name,
	p.quantity_purchased,
	e.price_per_unit,
	e.tax_rate,
	ISNULL(p.quantity_purchased * e.price_per_unit * (1+e.tax_rate), 0) AS sub_total_price,
	ISNULL(d.discount_rate, 0) * 100 AS discount_rate,
	CAST(ISNULL(p.quantity_purchased * e.price_per_unit * (1+e.tax_rate) * (1 - d.discount_rate), 0) 
		 AS NUMERIC(5, 2)) AS final_sub_total_price,
	IIF(ISNULL(d.discount_rate, 0) != 0, 'TRUE', 'FALSE') AS is_discount_item,
	IIF(DATEDIFF(day, GETDATE(), t.transaction_date) >= -3, 'TRUE', 'FALSE') AS is_refundable
FROM [TRANSACTION] AS t
LEFT JOIN PURCHASED_ITEM AS p
	ON t.transaction_id = p.transaction_id
LEFT JOIN EQUIPMENT AS e
	ON p.equipment_id = e.equipment_id
LEFT JOIN DISCOUNT AS d
	ON e.category_id = d.category_id
	AND t.transaction_date BETWEEN d.start_date AND d.end_date;
GO

-- transaction overview
CREATE OR ALTER View [dbo].[ORDERS_VIEW]
AS
SELECT
	t.member_id,
	t.transaction_id,
	t.transaction_date,
	COUNT(DISTINCT(e.equipment_name)) AS total_equipment_types,
	SUM(p.quantity_purchased) AS total_quantity,
	SUM(p.quantity_purchased * e.price_per_unit * (1+e.tax_rate)) AS total_price,
	CAST(SUM(p.quantity_purchased * e.price_per_unit * (1+e.tax_rate) * (1 - d.discount_rate)) 
		AS NUMERIC(5, 2)) AS final_total_price,
	IIF(SUM(d.discount_rate) != 0, 'TRUE', 'FALSE') AS is_discount_order,
	IIF(DATEDIFF(day, GETDATE(), t.transaction_date) >= -3, 'TRUE', 'FALSE') AS is_refundable
FROM [TRANSACTION] AS t
LEFT JOIN PURCHASED_ITEM AS p
	ON t.transaction_id = p.transaction_id
LEFT JOIN EQUIPMENT AS e
	ON p.equipment_id = e.equipment_id
LEFT JOIN DISCOUNT AS d
	ON e.category_id = d.category_id
	AND t.transaction_date BETWEEN d.start_date AND d.end_date
GROUP BY t.member_id,
	t.transaction_id,
	t.transaction_date;
GO


-- EQUIPMENT View
CREATE OR ALTER VIEW[dbo].[AVAILABLE_EQUIPMENT]
AS
SELECT e.equipment_id, e.equipment_name, c.category_name, e.quantity_in_stock, e.price_per_unit, e.country,
	   CONCAT(CAST((e.tax_rate * 100) AS INT), '%') AS tax_rate, CONCAT(CAST((d.discount_rate * 100) AS INT), '%') AS discount_rate, 
	   CAST((e.price_per_unit * (1+e.tax_rate) *(1-d.discount_rate)) AS NUMERIC(5, 2)) AS final_price_per_unit, 
	   d.end_date AS discount_end_date
FROM EQUIPMENT e
LEFT JOIN CATEGORY c ON 
	e.category_id = c.category_id
LEFT JOIN DISCOUNT d ON
	e.category_id = d.category_id
WHERE e.quantity_in_stock > 0;
GO





