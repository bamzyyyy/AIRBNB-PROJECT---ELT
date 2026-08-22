Select *
From fct_reviews as R
Left Join dim_listing_cleansed as L
on  R.Listing_id = L.Listing_id
where R.review_date <= L.created_at
