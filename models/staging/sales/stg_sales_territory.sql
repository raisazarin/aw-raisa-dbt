with 
    source as (
        select *
        from {{ source('adventure_works_source', 'salesterritory') }}
)

, transformed as (
    select
        /* primary key */ 
        cast(territoryid as string) as territory_id
        , name as territory_name
        , countryregioncode as country_region_id
        , `group` as group_region
        /* system column */
        , modifieddate  as updated_at
    from source
)

select *
from transformed