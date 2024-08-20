with 
    customers as (
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
            customers.customer_id
            , customers.person_id
            , customers.store_id
            , customers.territory_id
            , stores.salesperson_id
            , case
                when customers.store_id is null
                    then concat(
                        coalesce(people.first_name, '')
                        , ' '
                        , coalesce(people.middle_name, '')
                        , ' '
                        , coalesce(people.last_name, '')
                    )
                else stores.store_name
            end as customer_name
            , case
                when people.customer_email_approval = 0
                    then 'not approved'
                when people.customer_email_approval = 1
                    then 'approved adventure works'
                else 'approved adventure works and partners'
            end as customer_email_approval
            , case
                when customers.store_id is null
                    then 'retail'
                else 'reseller'
            end as customer_type
            , customers.updated_at as source_updated_at
        from customers
        left join stores
        on customers.store_id = stores.store_id
        left join people
        on customers.person_id = people.person_id 
    )

select *
from transformed