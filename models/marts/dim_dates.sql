with params as (
    select
        cast('{{ var("start_date") }}' as date) as start_date
        , cast('{{ var("end_date") }}' as date) as end_date
)

, date_range as (
    select
        date_add(start_date, interval x day) as date
    from params
    cross join unnest(generate_array(0, date_diff(end_date, start_date, day))) as x
)

select
    date as date_key
    , extract(year from date) as year
    , extract(month from date) as month
    , extract(day from date) as day
    , extract(dayofweek from date) as day_of_week
    , case 
        when extract(dayofweek from date) in (1, 7) then 'weekend'
        else 'weekday'
    end as day_type
    , extract(quarter from date) as quarter
    , date_trunc(date, month) as start_of_month
    , date_trunc(date, year) as start_of_year
from date_range