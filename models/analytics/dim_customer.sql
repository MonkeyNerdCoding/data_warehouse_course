-- WITH dim_customer AS (
--   SELECT 
--     *
--   FROM `vit-lam-data.wide_world_importers.sales__customers`
-- ), dim_customer_rename AS (
--   SELECT 
--     customer_id AS customer_key,
--     customer_name
--   FROM dim_customer
-- ), dim_customer_CAST AS (
--   SELECT
--     CAST(customer_key AS INT64) AS customer_key,
--     CAST(customer_name AS STRING) AS customer_name
--   FROM dim_customer_rename
-- )


WITH dim_customer AS (
  SELECT  
    CAST(customer_id AS INT64) AS customer_key,
    CAST(customer_name AS STRING) AS customer_name,
    CAST(buying_group_id AS INT) AS buying_group_key,
    CAST(customer_category_id AS INT) AS customer_category_key,
    CAST(is_on_credit_hold AS BOOLEAN) AS is_on_credit_hold
  FROM
    `vit-lam-data.wide_world_importers.sales__customers`
), dim_customer_convert AS (
  SELECT
  customer_key,
  customer_name,
  buying_group_key,
  customer_category_key,
  CASE
    WHEN is_on_credit_hold IS TRUE THEN 'Yes'
    WHEN is_on_credit_hold IS FALSE THEN 'No'
    WHEN is_on_credit_hold IS NULL THEN 'Undefined'
    ELSE 'Invalid'
  END AS is_on_credit_hold  -- Bây giờ mới thực sự thay thế được
FROM dim_customer
), dim_customer_undefined_record AS (
  SELECT * FROM dim_customer_convert
  UNION ALL
  SELECT 
  0 AS customer_key,
  'Undefined' AS customer_name,
  0 AS buying_group_key,
  0 AS customer_category_key,
  'Undefined' AS is_on_credit_hold
  UNION ALL
  SELECT 
  -1 AS customer_key,
  'Error' AS customer_name,
  -1 AS buying_group_key,
  -1 AS customer_category_key,
  'Error' AS is_on_credit_hold
)

SELECT ds.*, COALESCE(dsc.customer_category_name,'Invalid') AS customer_category_name,
COALESCE(bg.buying_group_name,'Invalid') AS buying_group_name
FROM dim_customer_undefined_record ds
LEFT JOIN {{ref('stg_dim_buying_group')}} bg
  ON ds.buying_group_key = bg.buying_group_key
LEFT JOIN {{ref('stg_dim_customer_category')}} dsc
  On ds.customer_category_key = dsc.customer_category_key