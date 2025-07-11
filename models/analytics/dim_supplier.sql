
WITH dim_supplier AS (
  SELECT
  CAST(supplier_id AS INT) AS supplier_key,
  CAST(supplier_name AS STRING) AS supplier_name
  FROM `vit-lam-data.wide_world_importers.purchasing__suppliers`
)





-- | Tên gốc       | Tên mới       |
-- |---------------|---------------|
-- | supplier_id   | supplier_key  |
-- | supplier_name | supplier_name |