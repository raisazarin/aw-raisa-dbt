with 
    source as (
        select *
        from {{ source('adventure_works_source', 'person') }}
)

, transformed as (
    select
        /* primary key */ 
        cast(businessentityid as string) as person_id
        , persontype as person_type
        , namestyle as name_style
        , firstname as first_name
        , middlename as middle_name
        , lastname as last_name
        , emailpromotion as customer_email_approval
        /* system column */
        , modifieddate  as updated_at
    from source
)

select *
from transformed