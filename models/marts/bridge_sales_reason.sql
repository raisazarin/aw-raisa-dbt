with 
    sales_reason as (  
        select * 
        from {{ ref('int_sales_reason') }}
    )

    , sales as (
        select *
        from {{ ref('int_sales')}}
    )

    , join_tables as (
        select
            sales.sales_order_detail_id
            , sales_reason.sales_order_id
            , sales_reason.sales_reason_id
        from sales
        full join sales_reason
        on sales.sales_order_id = sales_reason.sales_order_id
        where sales_reason.sales_reason_id is not null
    )

    , generate_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_order_id', 'sales_reason_id', 'sales_order_detail_id']) }} as bridge_sales_reason_sk
            , {{ dbt_utils.generate_surrogate_key(['sales_order_detail_id']) }} as sales_fk
            , {{ dbt_utils.generate_surrogate_key(['sales_order_id', 'sales_reason_id']) }} as sales_reason_fk
        from join_tables
    )

select *
from generate_sk
