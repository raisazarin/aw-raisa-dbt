with 

source as (

    select * from {{ source('adventure_works_source', 'salesorderheader') }}

)

, transformed as (

    select
        /* primary key */ 
        cast(salesorderid as string) as sales_order_id

        /* foreign key */
        , cast(customerid as string) as customer_id
        , cast(salespersonid as string) as salesperson_id
        , cast(territoryid as string) as territory_id
        , cast(creditcardid as string) as creditcard_id
        , cast(shiptoaddressid as string) as address_id

        , orderdate as order_date
        , duedate as due_date
        , shipdate as ship_date
        , status as order_status
        , subtotal as order_sub_total
        , taxamt as tax_amount
        , freight as freight
        , totaldue as total_due

        /* system column */
        , modifieddate  as updated_at
    from source

)

select * from transformed