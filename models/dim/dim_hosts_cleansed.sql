{{
    config(
        materialized = 'view')
    }}


WITH src_hosts AS (
    Select *
    From {{ ref('src_hosts')}}
)

Select HOST_ID,
    NVL(HOST_NAME, 'Anonymous') as HOST_NAME,
    IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
From src_hosts