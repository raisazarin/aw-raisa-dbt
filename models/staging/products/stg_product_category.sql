with 
    source as (
        select *
        from {{ source('adventure_works_source', 'productcategory') }}
    )

    , transformed as (
        select
            /* primary key */ 
            cast(productcategoryid as string) as product_category_id
            , name as product_category_name
            /* system column */
            , modifieddate  as updated_at
        from source
    )

select *
from transformed