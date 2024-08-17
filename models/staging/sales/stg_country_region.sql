with 

source as (

    select * from {{ source('adventure_works_source', 'countryregion') }}

)

, transformed as (

    select
        /* primary key */ 
        cast(countryregioncode as string) as country_region_id

        , name as country_region_name

        /* system column */
        , modifieddate  as updated_at
    from source

)

select * from transformed