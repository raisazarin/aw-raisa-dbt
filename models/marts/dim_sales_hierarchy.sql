with 
    int_sales_hierarchy as (
        select *
        from {{ ref('int_sales_hierarchy') }}
    )

    , generate_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['salesperson_id']) }} as sales_hierarchy_sk
            , salesperson_id
            , territory_id
            , territory_name
            , country_region_id
            , group_region
            , source_updated_at
            , current_timestamp() as updated_at
        from int_sales_hierarchy
    )

select *
from generate_sk