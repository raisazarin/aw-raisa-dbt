with
    sales as (
        select
            sales_sk
            , sales_hierarchy_fk
            , product_fk
            , salesperson_id
            , case
                when salesperson_id is null
                then 'retail'
                else 'resseler'
            end as customer_type
            , territory_id
            , sales_order_id
            , payment_method
            , order_quantity
            , unit_price
            , unit_price_discount_percentage
            , unit_price_discount_value 
            , date(order_date) as order_date
            , is_first_order
        from {{ ref('fact_sales') }}
    )

    , dates as (
        select 
            date_day
            , year_number as year
            , month_name as month
            , month_name_short
        from {{ ref('dim_dates') }}
    )

    , products as (
        select
            product_sk
            , standard_cost
        from {{ ref("dim_products") }}
    )

    , join_date as (
        select
            dates.*
            , sales.*
            , products.standard_cost
        from sales
        left join dates
        on sales.order_date = dates.date_day
        left join products
        on sales.product_fk = products.product_sk
    )

    , aggregate as (
        select
            sales_hierarchy_fk
            , customer_type
            , date_day
            , year
            , month
            , month_name_short
            , case
                when date_day = max(date_day) over()
                    then "last day"
                else null
            end as last_day
            , count(distinct sales_order_id) as total_orders
            , sum(unit_price) as unit_price
            , sum(standard_cost) as standard_cost
            , sum(unit_price_discount_value) as discount
            , sum(order_quantity) as total_units_sold
            , sum (unit_price * order_quantity) as gross_sales
            , sum ((unit_price - unit_price_discount_value) * order_quantity) as net_sales
        from join_date
        group by 
            year
            , month
            , customer_type
            , sales_hierarchy_fk
            , date_day
    )

    select *
    from aggregate


