with 

int_sales_hierarchy as (

    select * from {{ ref('int_sales_hierarchy') }}

)

, dim_sales_hierarchy as (
    select
        /* surrogate key */
        {{ dbt_utils.generate_surrogate_key(['salesperson_id']) }} as sales_hierarchy_sk

        /* primary key */
        , salesperson_id

        , territory_id
        , territory_name
        , country_region_id
        , group_region

        /* system column */
        , source_updated_at
        , current_timestamp() as updated_at
      from int_sales_hierarchy
)

select * from dim_sales_hierarchy