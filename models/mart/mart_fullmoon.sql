{{
config(materialized = 'table')

}}


With FCT_REVIEWS AS (
    Select *
    From {{ref('fct_reviews')}}
    
),

full_moon_date AS (
    Select *
    From {{ref('seed_full_moon_dates')}}
)


Select r.*,
        CASE
            When fm.full_moon_date is null then 'not_full_moon'
            Else 'full_moon'
        End as is_full_moon 
From FCT_REVIEWS as r
Left join full_moon_date as Fm
ON (TO_DATE(r.review_date) = DATEADD(DAY, 1, fm.full_moon_date))