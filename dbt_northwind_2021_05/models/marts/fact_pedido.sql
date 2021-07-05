with orders as (

    select *
    from {{ ref('stg_orders') }}

    ),
    clientes as (
        select *
        from {{ ref('dim_clientes') }}

    ),
    juntar_chaves as (
    select
       clientes.sk_cliente, --chave auto-incremental
       id_pedido,
       id_funcionario, -- preciso trocar por sk
       id_transportador, -- preciso trocar por sk       
       data_pedido,
       regiao_entrega,
       data_expedicao,
       pais_entrega,
       nome_entrega,
       cep_entrega,
       cidade_entrega,
       frete,
       endereco_entrega,
       data_prevista,
       quantidade_total,
       valor_faturado,
       quantidade_itens
    from orders
    left join clientes on orders.id_cliente = clientes.id_cliente

    )

select * from juntar_chaves