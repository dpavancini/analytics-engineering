## Estudo de Caso: Northwind Traders

Um dos  objetivos deste livro  é conseguir mostrar na prática a aplicação dos conceitos, técnicas e ferramentas de analytics modernas. Para isso vamos utilizar como base um banco de dados fictício muito utilizado para ensino de bancos de dados da Northwind. Nosso objetivo será ao final do livro termos projetado e criado uma infra-estrutura de analytics completa para a Northwind, deste a extração dos dados até a visualização em uma ferramenta de BI moderna.

### Contexto:

A Northwind Traders é uma loja fictícia que gerencia pedidos, produtos, clientes, fornecedores e muitos outros aspectos de uma pequena empresa. Hoje a empresa possui cerca de 30 funcionários e um faturamento mensal de 1 milhão e meio de reais. Seus clientes e fornecedores estão distribuídos em diversos países. Seus principais produtos hoje são alimentos, bebidas e utilidades domésticas.

Hoje a Northwind possui relatórios feitos em planilhas feitos de forma sob demanda. Quando a empresa era pequena esse formato funcionava, mas agora com o crescimento acelerado da empresa os dados de diferentes áreas começaram a não bater e as reuniões começaram a ficar mais conflituosas. A empresa também quer entender melhor seus dados para aumentar o ticket médio e reduzir o churn, dois objetivos considerados estratégicos no médio prazo.

O CEO da Northwind, Tony Stark está convencido que dados são a chave para o crescimento da empresa e agora quer ter uma visão integrada de todos os dados da empresa em um só lugar. No entanto, o gerente de TI da empresa, John Snow, é receoso sobre a dificuldade técnica, custos e prazos para esse projeto. Pior, John já participou de projetos de BI no passado usando ferramentas de grandes empresas de tecnologia que não tiveram o sucesso esperado. A gerente comercial da empresa, Maria Antonieta, embora muito competente na sua área não conhece o mundo de dados e de BI e ainda não conseguiu chegar em uma conclusão sobre o projeto. Por outro lado, o recém-contratado Gerente de Inovação da empresa, Pedro Pedreiro, também está apostando alto no projeto para tornar a Northwind uma empresa data-driven.

O banco de dados do ERP da empresa é um sistema PostgreSQL em um servidor nuvem. Além disso a empresa utiliza um CRM da Salesforce e um sistema de contabilidade da ContaAzul. Atualmente a empresa não possui um BI, mas estaria aberta a utilizar ferramentas como Tableau, Data Studio, PowerBI, entre outros.

Você foi contratado como engenheiro de Analytics na Northwind e sua tarefa é estruturar uma infra-estrutura de Analytics completa utilizando os conceitos e ferramentas adequadas para essa tarefa. Para isso serão necessárias algumas etapas ao longo do caminho:

* [Configurando o banco de dados](configurando_bd.md)
* [Estudo de Caso 1:  Entendimento do Problema](estudo_caso_1.md)
* [Estudo de Caso 2:  Planejamento do Projeto](estudo_caso_2.md)
* [Estudo de Caso 3:  Arquitetura do DW](estudo_caso_3.md)
* [Estudo de Caso 4:  Transformação de Dados](estudo_caso_4.md)
* [Estudo de Caso 5:  Visualização de Dados](estudo_caso_5.md)
