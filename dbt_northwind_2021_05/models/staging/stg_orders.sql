
with pedidos as (
    select
        order_id as id_pedido
        , employee_id as id_funcionario
        , order_date as data_pedido
        , customer_id as id_cliente
        , ship_region as regiao_entrega
        , shipped_date as data_expedicao
        , ship_country as pais_entrega
        , ship_name as nome_entrega
        , ship_postal_code as cep_entrega
        , ship_city as cidade_entrega
        , freight as frete
        , ship_via as id_transportador
        , ship_address as endereco_entrega
        , required_date as data_prevista
    from {{ source('northwind_erp', 'orders' )}}
),
    pedido_item as (
        select
        order_id as id_pedido,
        sum(quantity) as quantidade_total,
        sum(unit_price*(1-discount) * quantity) as valor_faturado,
        count(*) as quantidade_itens
        from {{ source('northwind_erp', 'order_details' )}}
        group by order_id

    ),

    dados_juntados as (
        select
        pedidos.id_pedido,
        id_cliente,
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
        from pedidos
        left join pedido_item on pedidos.id_pedido = pedido_item.id_pedido

    )

select * from dados_juntados