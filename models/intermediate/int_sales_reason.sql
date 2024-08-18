with 

sales_reason_order as (

    select * from {{ ref('stg_sales_order_header_sales_reason') }}

)

, sales_reason as (

    select * from {{ ref('stg_sales_reason') }}

)

, join_tables as (

    select 
        /* foreign key */
        o.sales_order_id
        , o.sales_reason_id

        , r.sales_reason_name
        , r.sales_reason_type

        /* system column */
        , o.updated_at as source_updated_at
    from sales_reason_order as o
    left join sales_reason as r
    on o.sales_reason_id = r.sales_reason_id

)

select * from join_tables