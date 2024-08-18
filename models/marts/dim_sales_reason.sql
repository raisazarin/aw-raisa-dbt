with 

int_sales_reason as (
    
    select * from {{ ref('int_sales_reason') }}

)

, dim_sales_reason as (

    select
        /* surrogate key */
        {{ dbt_utils.generate_surrogate_key(['sales_order_id', 'sales_reason_id']) }} as sales_reason_sk

        /* foreign key */
        , sales_order_id
        , sales_reason_id
    
        , sales_reason_name
        , sales_reason_type

        /* system column */
        , source_updated_at
        , current_timestamp() as updated_at
    from int_sales_reason

)

select * from dim_sales_reason