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
    *,
    CASE
      WHEN is_on_credit_hold IS TRUE THEN 'Yes'
      WHEN is_on_credit_hold IS FALSE THEN 'No'
      WHEN is_on_credit_hold IS NULL THEN 'Undefined'
      ELSE 'Invalid'
    END AS is_on_credit_hold_status
  FROM dim_customer
)

SELECT ds.*,dsc.customer_category_name,bg.buying_group_name
FROM dim_customer_convert ds
LEFT JOIN {{ref('stg_dim_buying_group')}} bg
  ON ds.buying_group_key = bg.buying_group_key
LEFT JOIN {{ref('stg_dim_customer_category')}} dsc
  On ds.customer_category_key = dsc.customer_category_key