-- WITH fact_sales_order_line AS(
--   SELECT 
--     CAST(order_line_id AS INTEGER) AS sales_order_line_key,
--     CAST(order_id AS INT) AS sales_order_key,
--     CAST(stock_item_id AS INTEGER) AS product_key,
--     CAST(quantity AS INTEGER) AS quantity,
--     CAST(unit_price AS NUMERIC) AS unit_price,
--     quantity * unit_price AS gross_amount
--   FROM `vit-lam-data.wide_world_importers.sales__order_lines` 
--   LEFT JOIN `vit-lam-data.wide_world_importers.sales__order_lines` 
-- )

-- Select * from fact_sales_order_line



-- Cách sài không có Ref dbt
-- WITH fact_sales_order_line AS (
--   SELECT 
--     CAST(order_line_id AS INTEGER) AS sales_order_line_key,
--     CAST(order_id AS INT) AS sales_order_key,
--     CAST(stock_item_id AS INTEGER) AS product_key,
--     CAST(quantity AS INTEGER) AS quantity,
--     CAST(unit_price AS NUMERIC) AS unit_price,
--     quantity * unit_price AS gross_amount
--   FROM `vit-lam-data.wide_world_importers.sales__order_lines`
-- ),
-- stg_fact_sales_order AS (
--   SELECT
--     CAST(order_id AS INT) AS sales_order_key,
--     CAST(customer_id AS INT) AS customer_key
--   FROM `vit-lam-data.wide_world_importers.sales__orders`
-- )
-- SELECT
--   fsol.*,
--   sfso.customer_key
-- FROM fact_sales_order_line fsol
-- LEFT JOIN stg_fact_sales_order sfso
--   ON fsol.sales_order_key = sfso.sales_order_key


-- Cách sài có Ref Dbt
-- Ref Dbt có nghĩa là nó tự hiểu được mối quan hệ của các bảng luôn
-- ref() là hàm đặc biệt trong dbt dùng để liên kết giữa các model SQL với nhau.
WITH fact_sales_order_line AS (
  SELECT 
    CAST(order_line_id AS INTEGER) AS sales_order_line_key,
    CAST(order_id AS INT) AS sales_order_key,
    CAST(stock_item_id AS INTEGER) AS product_key,
    CAST(quantity AS INTEGER) AS quantity,
    CAST(unit_price AS NUMERIC) AS unit_price,
    quantity * unit_price AS gross_amount
  FROM `vit-lam-data.wide_world_importers.sales__order_lines`
)

SELECT
  fsol.*,
  COALESCE(sfso.customer_key,-1) AS customer_key,COALESCE(sfso.picked_by_person_key,-1) ASpicked_by_person_key,
  sfso.order_date
FROM fact_sales_order_line fsol
LEFT JOIN {{ ref('stg_fact_sales_order') }} sfso
  ON fsol.sales_order_key = sfso.sales_order_key


-- - Trong model [`fact_sales_order_line`](../models/analytics/fact_sales_order_line.sql), khử null cột `customer_key` bằng cách đưa về `-1`.
-- | Tên gốc                  | Tên mới    |
-- |--------------------------|------------|
-- | sales__orders.order_date | order_date |
