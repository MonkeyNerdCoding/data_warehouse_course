WITH dim_category AS (
    SELECT 
    CAST(customer_category_id AS INT) as customer_category_key,
    CASt(customer_category_name AS STRING) AS customer_category_name
FROM  `vit-lam-data.wide_world_importers.sales__customer_categories`
)

SELECT * FROM dim_category