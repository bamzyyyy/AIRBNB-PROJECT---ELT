WITH raw_listings AS (
    Select *
    From {{source('airbnb', 'listings')}}

)

SELECT ID AS LISTING_ID,
        Name AS LISTING_NAME,
        LISTING_URL,
        ROOM_TYPE,
        MINIMUM_NIGHTS,
        HOST_ID,
        PRICE AS PRICE_STR,
        CREATED_AT,
        UPDATED_AT
from raw_listings

