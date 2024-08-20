with 
    source as (
        select *
        from {{ source('adventure_works_source', 'store') }}
)

, transformed as (
    select
        /* primary key */ 
        cast(businessentityid as string) as store_id
        /* foreign key */
        , cast(salespersonid as string) as salesperson_id
        , name as store_name
        /* system column */
        , modifieddate  as updated_at
    from source
)

select *
from transformed