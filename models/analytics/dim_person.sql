


-- Giải thích đôi chút về vấn đề xử lý bảng fact bị null

-- Bảng dim thì nó chỉ có 1 mình nó nên mình chơi trò coalesce được, nhưng ở đây bảng fact thì nó là bảng 
--chính sẽ phải join rất nhiều với các bảng khác. 

-- Hướng xử lý là thêm dòng từ bảng dim, rồi bảng fact sẽ map theo dim

WITH dim_person AS (
  SELECT
  CAST(person_id AS INT) AS person_key,
  CAST(full_name AS STRING) AS full_name
  FROM `vit-lam-data.wide_world_importers.application__people`
), dim_person_add_undefined_record AS (
  SELECT * FROM dim_person
  UNION ALL
  SELECT 
  0 AS person_key,
  "Undefined" AS full_name --Undefined có nghĩa là không có thông tin, tức là người đó là người không xác định

  UNION ALL
  SELECT 
  -1 AS person_key,
  "Error" AS full_name -- Error có nghĩa là cái thông tin đó bị lỗi
)


SELECT * FROM dim_person_add_undefined_record




-- | Tên gốc   | Tên mới          |
-- |-----------|------------------|
-- | person_id | person_key       |
-- | full_name | full_name        |