with int_customers as (
    select * 
    from {{ ref('int_customers') }}
)

, dim_customers as (
    select
        /* surrogate key */
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk

        /* primary key */
        , customer_id
    
        , customer_type
        , customer_name
        , customer_email_approval

        /* system column */
        , source_updated_at
        , current_timestamp() as updated_at
      from int_customers
)

select *
from dim_customers