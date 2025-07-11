WITH dim_buyingGroup AS (
    SELECT
    CAST(buying_group_id AS INT) AS buying_group_key,
    CAST(buying_group_name AS STRING) AS buying_group_name 
    FROM `vit-lam-data.wide_world_importers.sales__buying_groups`
)

SELECT * FROM dim_buyingGroup


-- buying_group_key
-- - buying_group_name

