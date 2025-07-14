WITH dim_product AS ( 
    SELECT
        CAST(stock_item_id AS INT64) AS product_key,
        CAST(stock_item_name AS STRING) AS product_name,
        COALESCE(CAST(brand AS STRING), 'Undefined') AS brand_name,
        CAST(supplier_id AS INT) AS supplier_key,
        CAST(is_chiller_stock AS BOOLEAN) AS is_chiller_stock_boolean
        FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
), dim_product_convert_boolean AS (
        SELECT product_key,product_name,brand_name,supplier_key,
    CASE 
        WHEN is_chiller_stock_boolean IS TRUE THEN 'Chiller Stock'
        WHEN is_chiller_stock_boolean IS FALSE THEN 'Not Chiller Stock'
        WHEN is_chiller_stock_boolean IS NULL THEN 'Undefined'
        ELSE 'Invalid'
    END AS is_chiller_stock_boolean
    FROM dim_product 
), dim_product_undefined_record AS (
    SELECT * FROM dim_product_convert_boolean
    UNION ALL
    SELECT 
    0 AS product_key,
    "Undefined" AS product_name,
    "Undefined" AS brand_name,
    0 AS supplier_key,
    "Undefined" AS is_chiller_stock_boolean
    UNION ALL
    SELECT 
    -1 AS product_key,
    "Error" AS product_name,
    "Error" AS brand_name,
    -1 AS supplier_key,
    "Error" AS is_chiller_stock_boolean
)
SELECT dp.*
FROM dim_product_convert_boolean dp
LEFT JOIN {{ref('dim_supplier')}} ds
 ON dp.supplier_key = ds.supplier_key


