with

dim_dates as (

{{ dbt_date.get_date_dimension(var('start_date'), var('end_date')) }}

)

select * from dim_dates