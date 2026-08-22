With L AS ( 
    SELECT *
    From {{ ref('src_listings')}}
),

H AS ( 
    SELECT *
    From {{ ref('src_hosts')}}
)

Select 
    L.LISTING_ID,
    L.LISTING_NAME,
    L.ROOM_TYPE,
    L.MINIMUM_NIGHTS,
    L.PRICE_STR,    
    L.HOST_ID,
    H.HOST_NAME,
    H.IS_SUPERHOST as Host_is_superhost,
    L.CREATED_AT,
    Greatest( L.UPDATED_AT, H.UPDATED_AT) as UPDATED_AT
From L
Left Join H
ON L.HOST_ID = H.HOST_ID
