Select *
from {{ref('dim_listing_cleansed')}}
where minimum_nights < 1 