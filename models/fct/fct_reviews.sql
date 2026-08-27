{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail')
    }}

WITH fct_reviews AS (  
    SELECT *
    FROM {{ref('src_reviews')}}
)

Select 
{{dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text' ])}} AS review_id,
 *
From fct_reviews
where review_text is not NULL

{% if is_incremental()%}
    AND review_date > (select max(review_date) from {{this }})
{% endif %}