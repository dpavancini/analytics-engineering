with staging as (

    select *
    from {{ ref('stg_customers')}}

)

select * from staging