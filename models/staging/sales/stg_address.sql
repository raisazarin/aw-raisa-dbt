with 
    source as (
        select *
        from {{ source('adventure_works_source', 'address') }}
    )

    , transformed as (
        select
            /* primary key */ 
            cast(addressid as string) as address_id
            /* foreign key */
            , cast(stateprovinceid as string) as state_province_id
            , city as city_name
            , spatiallocation as spacial_location_address
            , postalcode as postal_code
            /* system column */
            , modifieddate  as updated_at
        from source
    )

select *
from transformed