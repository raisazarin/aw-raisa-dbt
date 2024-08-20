with 
    product as (
        select * 
        from {{ ref('stg_product') }}
        where finished_goods_flag is true
)

, category as (
    select * 
    from {{ ref('stg_product_category') }}
)

, sub_category as (
    select *
    from {{ ref('stg_product_sub_category')}}
)

, first_join as (
    select
        product.*
        , sub_category.product_category_id
        , sub_category.product_sub_category_name
    from product
    left join sub_category
    on product.product_sub_category_id = sub_category.product_sub_category_id
)

, final_join as (
    select 
        first_join.*
        , product_category_name
        , case 
            when product_line = 'R '
                then 'Road'
            when product_line = 'M '
                then 'Mountain'
            when product_line = 'T '
                then 'Tourinhg'
            when product_line = 'S '
                then 'Standard'
            else 'not defined'
        end as product_line_name
        , case 
            when sell_end_date is null
                then 'active'
            else 'disabled'
            end as is_active
    from first_join
    left join category
    on first_join.product_category_id = category.product_category_id
)

select *
from final_join