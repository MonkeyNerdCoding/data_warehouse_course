WITH dim_product AS ( 
    SELECT
        CAST(stock_item_id AS INT64) AS product_key,
        CAST(stock_item_name AS STRING) AS product_name,
        COALESCE(CAST(brand AS STRING), 'Undefined') AS brand_name,
        CAST(supplier_id AS INT) AS supplier_key,
        CAST(is_chiller_stock AS BOOLEAN) AS is_chiller_stock_boolean
        FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
), dim_product_convert_boolean AS (
        SELECT *, 
    CASE 
        WHEN is_chiller_stock_boolean IS TRUE THEN 'Chiller Stock'
        WHEN is_chiller_stock_boolean IS FALSE THEN 'Not Chiller Stock'
        WHEN is_chiller_stock_boolean IS NULL THEN 'Undefined'
        ELSE 'Invalid'
    END AS is_chiller_stock_status
    FROM dim_product 
)

SELECT dp.*,COALESCE(dp.supplier_name,'Invalid') AS supplier_name
FROM dim_product_convert_boolean dp
LEFT JOIN {{ref('dim_supplier')}} ds
 ON dp.supplier_key = ds.supplier_key


