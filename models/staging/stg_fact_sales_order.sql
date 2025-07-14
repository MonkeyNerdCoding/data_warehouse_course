

-- Các bảng tạo trong folder staging thì nó sẽ chỉ nằm ở dạng view, không phải ở dạng table.
-- Cái này là bảng sales_order
-- WITH stg_fact_sales_order AS(
--     SELECT * 
--     FROM `vit-lam-data.wide_world_importers.sales__orders` 
-- ), stg_fact_sales_order_rename AS (
--     SELECT 
--     customer_id AS customer_key,
--     order_id AS sales_order_key
--     FROM stg_fact_sales_order
-- ), stg_fact_sales_order_CAST AS(
--     SELECT 
--         CAST(customer_key AS INT) AS customer_key,
--         CAST(sales_order_key AS INT) AS sales_order_key
--     FROM stg_fact_sales_order_rename 
-- )

-- SELECT customer_key,sales_order_key 
-- FROM  stg_fact_sales_order_rename 


WITH stg_fact_sales_order AS (
    SELECT 
    CAST(customer_id AS INT) AS customer_key,
    CAST(order_id AS INT) AS sales_order_key,
    CAST(picked_by_person_id AS INT) AS picked_by_person_key,
    CAST(order_date AS DATE) AS order_date
    FROM `vit-lam-data.wide_world_importers.sales__orders`
)

SELECT
  customer_key,
  sales_order_key,
  COALESCE(picked_by_person_key,0) AS picked_by_person_key,
  order_date
FROM stg_fact_sales_order



-- | Tên gốc                           | Tên mới             |
-- |-----------------------------------|---------------------|
-- | sales__orders.picked_by_person_id | picked_by_person_key|

-- | Tên gốc                  | Tên mới    |
-- |--------------------------|------------|
-- | sales__orders.order_date | order_date |