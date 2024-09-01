with 
    source as (
        select *
        from {{ source('adventure_works_source', 'stateprovince') }}
    )

    , transformed as (
        select
            /* primary key */ 
            cast(stateprovinceid as string) as state_province_id
            /* foreign key */
            , cast(countryregioncode as string) as country_region_id
            , cast(territoryid as string) as territory_id
            , stateprovincecode as iso_state_province_code
            , name as state_province_name
            , isonlystateprovinceflag as is_state_equal_country_flag
            /* system column */
            , modifieddate as updated_at
        from source
    )

select *
from transformed