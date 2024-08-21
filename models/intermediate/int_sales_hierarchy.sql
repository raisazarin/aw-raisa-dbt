with 
    order_header as (
        select distinct
            salesperson_id
            , territory_id
        from {{ ref('stg_sales_order_header') }}    
    )

    , person as (
        select 
            person_id
            , first_name
            , last_name
        from {{ ref('stg_person') }}
    )

    , territory as (
        select * 
        from {{ ref('stg_sales_territory')}}
    )

    , join_all as (
        select
            order_header.salesperson_id
            , order_header.territory_id
            , concat(person.first_name,' ',person.last_name) as salesperson_name
            , territory.territory_name
            , territory.country_region_id
            , territory.group_region
        from order_header
        left join person
        on order_header.salesperson_id = person.person_id
        left join territory
        on order_header.territory_id = territory.territory_id
    )

select *
from join_all