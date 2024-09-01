with 
    source as (
        select *
        from {{ source('adventure_works_source', 'productsubcategory') }}
    )

    , transformed as (
        select
            /* primary key */ 
            cast(productsubcategoryid as string) as product_sub_category_id
            /* foreign key */
            , cast(productcategoryid as string) as product_category_id
            , name as product_sub_category_name
            /* system column */
            , modifieddate  as updated_at
        from source
    )

select *
from transformed