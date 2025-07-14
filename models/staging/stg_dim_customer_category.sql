WITH dim_category AS (
    SELECT 
    CAST(customer_category_id AS INT) as customer_category_key,
    CASt(customer_category_name AS STRING) AS customer_category_name
FROM  `vit-lam-data.wide_world_importers.sales__customer_categories`
),dim_category_undefined_record AS (
    SELECT 
    customer_category_key,
    customer_category_name
    FROM dim_category
    UNION ALL
    SELECT
    0 AS customer_category_key,
    'Undefined' AS customer_category_name
    UNION ALL 
    SELECT
    -1 AS customer_category_key,
    'Error' AS customer_category_name
)

SELECT * FROM dim_category_undefined_record