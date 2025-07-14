Tương tự các bảng dimension khác, cột date cũng sẽ cần có 1 bảng dimension để lưu các thông tin về ngày/tháng/năm, ví dự như: thứ mấy trong ngày dạng chữ, tháng dạng chữ, trong tuần hay cuối tuần, ngày lễ, năm tài chính.
Tuy nhiên, bảng `dim_date` là một bảng đặc biệt, vì mình sẽ dùng code để tạo ra chứ không xử lý từ data thô.

Yêu cầu của `lesson-0111b`:
- Mở file [`models/analytics/dim_date.sql`](../models/analytics/dim_date.sql), viết câu query để sinh ra bảng `dim_date` trong khoảng 2010-01-01 đến 2030-12-31
- Cần có các cột sau:

| Tên cột               | Ví dụ             | Giải thích                       |
|-----------------------|-------------------|----------------------------------|
| date                  | 2022-02-15        | Loại dữ liệu là DATE             |
| day_of_week           | Monday, Tuesday   |                                  |
| day_of_week_short     | Mon, Tue          |                                  |
| is_weekday_or_weekend | Weekday, Weekend  |                                  |
| year_month            | 2022-02-01        | Đưa về đầu tháng (date truncate) |
| month                 | January, February |                                  |
| year                  | 2022-01-01        | Đưa về đầu năm (date truncate)   |
| year_number           | 2022              |                                  |


-- Dùng câu Select ở bên dưới, có muốn thêm các ngày lễ đặc biệt thì hỏi chat


<!-- SELECT
  d AS date,  -- DATE gốc
  FORMAT_DATE('%A', d) AS day_of_week,            -- Monday, Tuesday, ...
  FORMAT_DATE('%a', d) AS day_of_week_short,      -- Mon, Tue, ...
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM d) IN (1, 7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS is_weekday_or_weekend,                   -- Weekday / Weekend
  DATE_TRUNC(d, MONTH) AS year_month,             -- 2022-02-01
  FORMAT_DATE('%B', d) AS month,                  -- January, February
  DATE_TRUNC(d, YEAR) AS year,                    -- 2022-01-01
  EXTRACT(YEAR FROM d) AS year_number             -- 2022
FROM
  UNNEST(GENERATE_DATE_ARRAY('2010-01-01', '2030-12-31', INTERVAL 1 DAY)) AS d -->
