with 

source as (

    select * from {{ source('adventure_works_source', 'salesreason') }}

)

, transformed as (

    select
        /* primary key */ 
        cast(salesreasonid as string) as sales_reason_id
        
        , name as sales_reason_name
        , reasontype as sales_reason_type

        /* system column */
        , modifieddate as updated_at
    from source

)

select * from transformed