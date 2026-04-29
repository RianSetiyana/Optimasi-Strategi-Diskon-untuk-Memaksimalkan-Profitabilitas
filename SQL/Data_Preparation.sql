WITH standardized_date AS (
    SELECT
        order_id,
        CAST(
            CASE
                WHEN order_date LIKE '% %' THEN 
                    REGEXP_REPLACE(
                        SPLIT_PART(order_date, ' ', 1),
                        '(\d{4})-(\d{2})-(\d{2})',
                        '\2-\3-\1',
                        'g'
                    )
                ELSE 
                    REGEXP_REPLACE(
                        order_date,
                        '(\d{1,2})/(\d{2})/(\d{4})',
                        '\2-\1-\3',
                        'g'
                    )
            END AS DATE
        ) AS order_date,
        category,
        sales,
        quantity,
        discount,
        profit
    FROM data.superstore
),

cleaned_data AS (
    SELECT
        order_id,
        order_date,
        EXTRACT(YEAR FROM order_date) AS order_year,
        category,
        sales,
        CAST(quantity AS INTEGER) AS quantity,
        ROUND(discount * 100, 0) AS discount,
        profit
    FROM standardized_date
)

SELECT
    *
FROM cleaned_data
WHERE order_year = 2017;