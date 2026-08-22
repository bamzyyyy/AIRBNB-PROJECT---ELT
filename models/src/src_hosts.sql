WITH raw_hosts as (
    Select *
    From {{source('airbnb', 'hosts')}}
)

Select ID AS HOST_ID,
        NAME AS HOST_NAME,
        IS_SUPERHOST,
        CREATED_AT,
        UPDATED_AT 
 From raw_hosts