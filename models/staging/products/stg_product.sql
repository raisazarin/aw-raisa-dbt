with 
    source as (
        select *
        from {{ source('adventure_works_source', 'product') }}
    )

    , transformed as (
        select
            /* primary key */ 
            cast(productid as string) as product_id
            /* foreign key */
            , cast(productsubcategoryid as string) as product_sub_category_id
            , name as product_name
            , finishedgoodsflag as finished_goods_flag
            , cast(standardcost as numeric) as standard_cost
            , cast(listprice as numeric) as unit_price
            , productline as product_line
            , sellstartdate as sell_start_date
            , sellenddate as sell_end_date
            /* system column */
            , modifieddate  as updated_at
        from source
    )

select *
from transformed