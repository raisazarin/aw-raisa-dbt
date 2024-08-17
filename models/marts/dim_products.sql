with int_products as (
    select *
    from {{ ref('int_products') }}
)

, transformed as (
    select
        /* surrogate key */
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk

        /* primary key */
        , product_id
    
        , product_name
        , product_category_id
        , product_category_name
        , product_sub_category_id
        , product_sub_category_name
        , product_line
        , product_line_name
        , standard_cost
        , unit_price
        , is_active

        /* system column */
        , updated_at as source_updated_at
        , current_timestamp() as updated_at
      from int_products
)

select *
from transformed