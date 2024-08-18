with 

address as (

    select * from {{ ref('stg_address') }}

)

, state as (

    select * from {{ ref('stg_state_province') }}

)

, country as (

    select * from {{ ref('stg_country_region') }}

)

, territory as (

    select * from {{ ref('stg_sales_territory') }}

)

, join_address_state as (

    select
        a.address_id
        , a.state_province_id
        , a.spacial_location_address
        , a.postal_code
        , a.updated_at as source_updated_at
        , s.country_region_id
        , s.territory_id
        , s.iso_state_province_code
        , s.state_province_name
        , s.is_state_equal_country_flag   
    from address as a
    left join state as s
    on a.state_province_id = s.state_province_id

)

, join_all as (

    select
        j.*
        , c.country_region_name
        , t.territory_name
        , t.group_region
    from join_address_state as j
    left join country as c
    on j.country_region_id = c.country_region_id
    left join territory as t
    on j.territory_id = t.territory_id

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

select * from transformed