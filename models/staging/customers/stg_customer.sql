with 

source as (

    select * from {{ source('adventure_works_source', 'customer') }}

)

, transformed as (

    select
        /* primary key */ 
        customerid as customer_id

        /* foreign key */
        , personid as person_id
        , storeid as store_id
        , territoryid as territory_id

        /* system column */
        , modifieddate  as updated_at
    from source

)

select * from transformed