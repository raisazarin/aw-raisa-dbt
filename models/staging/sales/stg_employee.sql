with 
    source as (
        select *
        from {{ source('adventure_works_source', 'employee') }}
    )

    , transformed as (
        select
            /* primary key */ 
            cast(businessentityid as string) as person_id
            , jobtitle as job_title
            /* system column */
            , modifieddate  as updated_at
        from source
    )

select *
from transformed