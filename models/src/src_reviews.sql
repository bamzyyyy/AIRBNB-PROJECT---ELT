With raw_reviews AS (
    Select *
    FROM {{source('airbnb', 'reviews')}}

)

Select LISTING_ID,
        DATE AS review_date,
        REVIEWER_NAME,
        COMMENTS AS review_text,
        SENTIMENT AS review_sentiment
From raw_reviews