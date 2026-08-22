{{
    config(
        materialized = 'view')
    }}


WITH src_listings as (
    Select *
    From {{ref("src_listings")}}
)

Select listing_id,
    listing_name,
CASE 
        WHEN Minimum_nights = 0 then 1
        ELSE Minimum_nights
END AS Minimum_nights,
    host_id,
    Room_type,
    replace(
        PRICE_STR,
        '$'
    ):: NUMBER(
        10,
        2
    ) AS price,
    CREATED_AT,
    UPDATED_AT
From src_listings
