with 
    salesperson as (
        select *
        from {{ ref('stg_salesperson') }}
)

, employee as (
    select *
    from {{ ref('stg_employee') }}
)

, territory as (
    select * 
    from {{ ref('stg_sales_territory')}}
)

, join_all as (
    select
        salesperson.salesperson_id
        , salesperson.territory_id
        , employee.job_title
        , territory.territory_name
        , territory.country_region_id
        , territory.group_region
        , salesperson.updated_at as source_updated_at
    from salesperson
    left join employee
    on salesperson.salesperson_id = employee.person_id
    left join territory
    on salesperson.territory_id = territory.territory_id
)

select *
from join_all