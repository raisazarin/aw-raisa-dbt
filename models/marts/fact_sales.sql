with 

int_sales as (

    select * from {{ ref('int_sales') }}

)

, fact_sales as (
    select
        /* surrogate key */
        {{ dbt_utils.generate_surrogate_key(['sales_order_detail_id']) }} as sales_sk

        /* primary key */
        , sales_order_detail_id
    
        /* foreign key */
        , {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_fk
        , {{ dbt_utils.generate_surrogate_key(['special_offer_id']) }} as special_offer_fk
        , {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_fk
        , {{ dbt_utils.generate_surrogate_key(['address_id']) }} as distribution_fk
        , {{ dbt_utils.generate_surrogate_key(['salesperson_id']) }} as sales_hierarchy_fk
        , sales_order_id
        , address_id as shipment_address_id

        , payment_method
        , order_quantity
        , unit_price
        , unit_price_discount_percentage
        , unit_price_discount_value 
        , order_date
        , due_date
        , ship_date

        /* system column */
        , source_updated_at
        , current_timestamp() as updated_at
      from int_sales
)

select * from fact_sales