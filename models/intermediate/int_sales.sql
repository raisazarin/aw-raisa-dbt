with 

order_header as (

    select * from {{ ref('stg_sales_order_header') }}

)

, order_detail as (

    select * from {{ ref('stg_sales_order_detail') }}

)

, join_sales as (

    select
        /* primary key */ 
        d.sales_order_detail_id

        /* foreign key */
        , d.sales_order_id
        , d.product_id
        , d.special_offer_id
        , h.customer_id
        , h.salesperson_id
        , h.territory_id
        , h.creditcard_id
        , h.address_id

        , d.order_quantity
        , d.unit_price
        , case
            when d.unit_price_discount != 0
                then d.unit_price_discount
            else null
        end as unit_price_discount_percentage
        , round(d.unit_price_discount * d.unit_price * d.order_quantity, 3) as unit_price_discount_value 
        , cast(h.order_date as timestamp) as order_date
        , cast(h.due_date as timestamp) as due_date
        , cast(h.ship_date as timestamp) as ship_date
        , h.order_status

        /* system column */
        , d.updated_at as source_updated_at

    from order_detail as d
    left join order_header as h
    on d.sales_order_id = h.sales_order_id
    /* 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled */
    where h.order_status = 5

)

select * from join_sales