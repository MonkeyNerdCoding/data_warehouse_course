WITH dim_product AS ( 
    SELECT
        CAST(stock_item_id AS INT64) AS product_key,
        CAST(stock_item_name AS STRING) AS product_name,
        CAST(brand AS STRING) AS brand_name,
        CAST(supplier_id AS INT) AS supplier_key
    FROM
        `vit-lam-data.wide_world_importers.warehouse__stock_items`
)
SELECT dp.*,ds.supplier_name
FROM dim_product dp
LEFT JOIN {{ref('dim_supplier')}} ds
 ON dp.supplier_key = ds.supplier_key
