with product as (
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
        p.*
        , s.product_category_id
        , s.product_sub_category_name
    from product as p
    left join sub_category as s
    on p.product_sub_category_id = s.product_sub_category_id
)

, final as (
    select 
        f.*
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
    from first_join as f
    left join category as c
    on f.product_category_id = c.product_category_id
)

select *
from final