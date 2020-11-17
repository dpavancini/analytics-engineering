# Estudo de Caso 4: Planejamento de DW da Northwind Shop

## Resumo:

Neste desafio você vai utilizar o dbt para criar um data warehouse da empresa Northwind Traders. Seu objetivo é utilizar os exemplos deste capítulo e o planejamento realizados nos capítulos anteriores para criar pelo menos as seguintes tabelas:

* Fatos de Pedidos
* Dimensão Clientes
* Dimensão Produtos
* Dimensão Transportadores
* Dimensão Fornecedores

## Dados:
Você deve utilizar uma ferramenta de E-L para mover os dados do [banco de dados da Northwind](configurando_bd) para um data warehouse na nuvem ou se preferir, utilizando um banco de dados local.

> Para utilizar um banco de dados local como DW recomendamos usar o PostgreSQL criado conforme as instruções [aqui](configurando_bd). No entanto,
> pode ser necessário a liberação de portas e outras configurações avançadas para conseguir se conectar à ferramentas na nuvem como o dbt cloud ou data studio. Se você > não tem familiariedade com gestão de bancos de dados, utilize o Big Query ou outro DW na nuvem.


## Entrega:

Um data warehouse criado com as tabelas de fatos e dimensões da Northwind Shop.
