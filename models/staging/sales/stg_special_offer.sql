with 
    source as (
        select *
        from {{ source('adventure_works_source', 'specialoffer') }}
)

, transformed as (
    select
        /* primary key */ 
        cast(specialofferid as string) as special_offer_id
        , description as discount_description
        , discountpct as discount_percentage
        , type as discount_category
        , category as discount_customer_category
        , startdate as start_offer_date
        , enddate as end_offer_date
        , minqty as min_quantity
        , maxqty as max_quantity
        /* system column */
        , modifieddate  as updated_at
    from source
)

select *
from transformed