with 

source as (

    select * from {{ source('adventure_works_source', 'store') }}

)

, transformed as (

    select
        /* primary key */ 
        businessentityid as store_id

        /* foreign key */
        , salespersonid as salesperson_id

        , name as store_name

        /* system column */
        , modifieddate  as updated_at
    from source

)

select * from transformed