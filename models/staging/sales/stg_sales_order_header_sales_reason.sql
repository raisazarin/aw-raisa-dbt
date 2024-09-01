with 
    source as (
        select *
        from {{ source('adventure_works_source', 'salesorderheadersalesreason') }}
    )

    , transformed as (
        select
            /* foreign key */
            cast(salesorderid as string) as sales_order_id
            , cast(salesreasonid as string) as sales_reason_id
            /* system column */
            , modifieddate  as updated_at
        from source
    )

select *
from transformed