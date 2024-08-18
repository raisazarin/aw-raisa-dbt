with 

int_distribution as (

    select * from {{ ref('int_distribution') }}

)

, dim_distribution as (
    select
        /* surrogate key */
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} as distribution_sk

        /* primary key */
        , address_id
    
        , territory_id
        , territory_name
        , country_region_id
        , country_region_name
        , state_province_id
        , state_province_name
        , distribuition_center
        , spacial_location_address
        , postal_code
        , iso_state_province_code
        , is_state_equal_country_flag
        , group_region

        /* system column */
        , source_updated_at
        , current_timestamp() as updated_at
      from int_distribution
)

select * from dim_distribution