with 

source as (

    select * from {{ source('adventure_works_source', 'customer') }}

)

, transformed as (

    select
        /* primary key */ 
        cast(customerid as string) as customer_id

        /* foreign key */
        , cast(personid as string) as person_id
        , cast(storeid as string) as store_id
        , cast(territoryid as string) as territory_id

        /* system column */
        , modifieddate as updated_at
    from source

)

select * from transformed