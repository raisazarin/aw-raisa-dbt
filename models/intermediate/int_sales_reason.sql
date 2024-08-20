with 
    sales_reason_order as (
        select *
        from {{ ref('stg_sales_order_header_sales_reason') }}
    )

    , sales_reason as (
        select *
        from {{ ref('stg_sales_reason') }}
    )

    , join_tables as (
        select 
            sales_reason_order.sales_order_id
            , sales_reason_order.sales_reason_id
            , sales_reason.sales_reason_name
            , sales_reason.sales_reason_type
            , sales_reason_order.updated_at as source_updated_at
        from sales_reason_order
        left join sales_reason
        on sales_reason_order.sales_reason_id = sales_reason.sales_reason_id
    )

select *
from join_tables