with 

salesperson as (

    select * from {{ ref('stg_salesperson') }}
    where territory_id is not null

)

, employee as (

    select * from {{ ref('stg_employee') }}

)

, territory as (

    select * from {{ ref('stg_sales_territory')}}

)

, join_all as (

    select
        s.salesperson_id
        , s.territory_id
        , e.job_title
        , t.territory_name
        , t.country_region_id
        , t.group_region
        , s.updated_at as source_updated_at
    from salesperson as s
    left join employee as e
    on s.salesperson_id = e.person_id
    left join territory as t
    on s.territory_id = t.territory_id

)

select * from join_all