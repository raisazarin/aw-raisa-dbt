with 
    header as (
        select * 
        from {{ ref('stg_sales_order_header') }}
    )

    , detail as (
        select * 
        from {{ ref('stg_sales_order_detail') }}
    )

    /* to define if order_date is the date of the first order of that customer */
    , first_order as (
        select 
            customer_id
            , cast(min(order_date) as timestamp) as first_order
        from header
        group by customer_id
    )

    , join_sales as (
        select
            detail.sales_order_detail_id
            , detail.sales_order_id
            , detail.product_id
            , detail.special_offer_id
            , header.customer_id
            , header.salesperson_id
            , header.territory_id
            , header.shipment_address_id
            , case
                when header.creditcard_id is null
                    then 'other payment method'
                else 'credit card'
            end as payment_method
            , detail.order_quantity
            , detail.unit_price
            , case
                when detail.unit_price_discount != 0
                    then detail.unit_price_discount
                else null
            end as unit_price_discount_percentage
            , round(detail.unit_price_discount * detail.unit_price * detail.order_quantity, 3) as unit_price_discount_value 
            , cast(header.order_date as timestamp) as order_date
            , cast(header.due_date as timestamp) as due_date
            , cast(header.ship_date as timestamp) as ship_date
            , header.order_status
            , detail.updated_at as source_updated_at
        from detail
        left join header
        on detail.sales_order_id = header.sales_order_id
        /* 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled */
        where header.order_status = 5
    )

    , final as (
        select
            join_sales.*
            , case
                when first_order.first_order = join_sales.order_date
                    then 'true'
                else 'false'
            end as is_first_order
        from join_sales
        left join first_order
        on join_sales.customer_id = first_order.customer_id
    )

select * 
from final