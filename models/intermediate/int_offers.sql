with 

offer as (

    select * from {{ ref('stg_special_offer') }}

)

, transformed as (

    select
        /* primary key */
        special_offer_id

        , discount_description as offer_name
        , discount_percentage
        , discount_category
        , case
            when discount_customer_category = 'Customer'
                then 'retail'
            when discount_customer_category = 'Reseller'
                then 'reseller'
            else 'no discount'
        end as offer_customer_type
        , start_offer_date
        , end_offer_date

        /* system column */
        , updated_at as source_updated_at
    from offer
)

select * from transformed