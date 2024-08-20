with 
    address as (
        select *
        from {{ ref('stg_address') }}
    )

    , state as (
        select *
        from {{ ref('stg_state_province') }}
    )

    , country as (
        select *
        from {{ ref('stg_country_region') }}
    )

    , territory as (
        select *
        from {{ ref('stg_sales_territory') }}
    )

    , join_address_state as (
        select
            address.address_id
            , address.state_province_id
            , address.spacial_location_address
            , address.postal_code
            , address.updated_at as source_updated_at
            , state.country_region_id
            , state.territory_id
            , state.iso_state_province_code
            , state.state_province_name
            , state.is_state_equal_country_flag   
        from address
        left join state
        on address.state_province_id = state.state_province_id
    )

    , join_all as (
        select
            join_address_state.*
            , country.country_region_name
            , territory.territory_name
            , territory.group_region
        from join_address_state
        left join country
        on join_address_state.country_region_id = country.country_region_id
        left join territory
        on join_address_state.territory_id = territory.territory_id
    )

    , transformed as (
        select
            address_id
            , territory_id
            , territory_name
            , country_region_id
            , country_region_name
            , state_province_id
            , state_province_name
            , case
                when country_region_id = 'US'
                    then state_province_name
                else country_region_name
            end as distribuition_center
            , spacial_location_address
            , postal_code
            , iso_state_province_code
            , is_state_equal_country_flag
            , group_region
            , source_updated_at
        from join_all
    )

select *
from transformed