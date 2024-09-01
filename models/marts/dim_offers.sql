with 
    int_offers as (
        select *
        from {{ ref('int_offers') }}
    )

    , generate_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['special_offer_id']) }} as special_offer_sk
            , special_offer_id
            , offer_name
            , discount_percentage
            , discount_category
            , offer_customer_type
            , start_offer_date
            , end_offer_date
            , source_updated_at
            , current_timestamp() as updated_at
        from int_offers
    )

select *
from generate_sk