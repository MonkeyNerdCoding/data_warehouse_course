WITH dim_buyingGroup AS (
    SELECT
    CAST(buying_group_id AS INT) AS buying_group_key,
    CAST(buying_group_name AS STRING) AS buying_group_name 
    FROM `vit-lam-data.wide_world_importers.sales__buying_groups`
),dim_buyingGroup_undefined_record AS (
    SELECT 
    buying_group_key,
    buying_group_name
    FROM dim_buyingGroup
    UNION ALL
    SELECT
    0 AS buying_group_key,
    'Undefined' AS buying_group_name
    UNION ALL 
    SELECT
    -1 AS buying_group_key,
    'Error' AS buying_group_name
)
SELECT * FROM dim_buyingGroup_undefined_record


