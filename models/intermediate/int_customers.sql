with customers as (
    select * 
    from {{ ref('stg_customer') }}
)

, stores as (
    select * 
    from {{ ref('stg_store') }}
)

, people as (
    select *
    from {{ ref('stg_person')}}
)

, transformed as (
    select
        c.customer_id
        , c.person_id
        , c.store_id
        , c.territory_id
        , s.salesperson_id
        , case
            when c.store_id is null
                then concat(
                    coalesce(p.first_name, ''),
                    ' ',
                    coalesce(p.middle_name, ''),
                    ' ',
                    coalesce(p.last_name, '')
                )
            else s.store_name
        end as customer_name
        , case
            when p.customer_email_approval = 0
                then 'not approved'
            when p.customer_email_approval = 1
                then 'approved adventure works'
            else 'approved adventure works and partners'
        end as customer_email_approval
        , case
            when c.store_id is null
                then 'retail'
            else 'reseller'
        end as customer_type
        , c.updated_at as source_updated_at
    from customers as c
    left join stores as s
    on c.store_id = s.store_id
    left join people as p
    on c.person_id = p.person_id 
)

select *
from transformed