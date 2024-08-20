with 
    source as (
        select * 
        from {{ source('adventure_works_source', 'salesorderdetail') }}
)

, transformed as (
    select
        /* primary key */ 
        cast(salesorderdetailid as string) as sales_order_detail_id
        /* foreign key */
        , cast(salesorderid as string) as sales_order_id
        , cast(productid as string) as product_id
        , cast(specialofferid as string) as special_offer_id
        /* other columns */
        , orderqty as order_quantity
        , unitprice as unit_price
        , unitpricediscount as unit_price_discount
        /* system column */
        , modifieddate  as updated_at
    from source
)

select * 
from transformed