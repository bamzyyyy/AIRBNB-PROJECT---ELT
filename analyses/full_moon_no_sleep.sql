With mart_fullmoon_reviews AS (
    SELECT * FROM {{ ref('mart_fullmoon')}}
)
Select is_full_moon,
review_sentiment,
count(*) as total_reviews

FROM
    mart_fullmoon_reviews
GROUP BY
    is_full_moon,
    review_sentiment
ORDER BY
    is_full_moon,
    review_sentiment