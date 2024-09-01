{{
    config(
        severety = 'error'
    )
}}

with sales as (
    select 
        sum(unit_price * order_quantity) as total_gross_sales_2013
    from {{ ref('fact_sales') }} 
    where order_date between '2013-01-01' and '2013-12-31'
)

select 
    total_gross_sales_2013
from sales
where total_gross_sales_2013 not between 43922048 and 43922052