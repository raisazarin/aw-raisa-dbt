with 
    source as (
        select *
        from {{ source('adventure_works_source', 'salesperson') }}
    )

    , transformed as (
        select
            /* primary key */ 
            cast(businessentityid as string) as salesperson_id
            /* foreign key */
            , cast(territoryid as string) as territory_id
            /* system column */
            , modifieddate  as updated_at
        from source
    )

select *
from transformed