with 
    int_sales as (
        select * 
        from {{ ref('int_sales') }}
)

, generate_sk as (
    select
        {{ dbt_utils.generate_surrogate_key(['sales_order_detail_id']) }} as sales_sk
        , {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_fk
        , {{ dbt_utils.generate_surrogate_key(['special_offer_id']) }} as special_offer_fk
        , {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_fk
        , {{ dbt_utils.generate_surrogate_key(['address_id']) }} as distribution_fk
        , {{ dbt_utils.generate_surrogate_key(['salesperson_id']) }} as sales_hierarchy_fk
        , sales_order_id
        , shipment_address_id
        , payment_method
        , order_quantity
        , unit_price
        , unit_price_discount_percentage
        , unit_price_discount_value 
        , order_date
        , due_date
        , ship_date
        , is_first_order
        , source_updated_at
        , current_timestamp() as updated_at
      from int_sales
)

select *
from generate_sk