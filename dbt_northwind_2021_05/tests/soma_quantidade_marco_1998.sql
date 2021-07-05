with
    soma_quantidade as (
        select
            sum(quantidade_total) as qnt
        from {{ref('fact_pedido')}}
        where data_pedido
        between '1998-03-01' and '1998-03-31'
    )

select * from soma_quantidade where qnt != 4065