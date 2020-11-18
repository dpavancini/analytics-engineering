# Configurando um Tap de Extract-Load

Singer Taps são programas que "movem" dados entre uma fonte ("tap") e um destino ("target"). Embora sejam a base das integrações da Stitch Data, os taps são uma especificação open-source e podem ser usados tanto para criarmos nossos próprios pipelines de extract-load como para criarmos novas fontes e targes que se conectam aos existentes. Por tal motivo, são muito flexíveis e interessantes para uso em projetos de analytics engineering.

Embora não sejam muito complexos, para executar e manter pipelines de taps-targets é necessário um certo conhecimento de programação e algumas configurações adicionais que nos são facilitados quando utilizamos um serviço de ETL SaaS.

Antes desta sessão você deve ter um banco de dados criado com os dados do ERP da Northwind conforme instruções [aqui](/Northwind/configurando_bd.md).

## Rodando um tap

Como taps podem ter conflito de dependências de pacotes, recomenda-se instalar cada Tap em seu próprio virtualenv (é importante tomar cuidado com a versão do python a ser utilizada, o Python 3.8 pode não ser compatível):

```
python3 -m venv ~/.virtualenvs/tap-postgres
source ~/.virtualenvs/tap-postgres/bin/activate
```

E instalamos o tap via `pip`:

```
pip install tap-postgres
```

Um tap é definido por dois arquivos: um arquivo `config.json` onde detalhamos credenciais e outros parâmetros necessários para a fonte de dados. E um arquivo `catalog.json` ou `properties.json` onde definimos o schema dos dados que o tap está extraindo assim como outras configurações como tipo de replicação (ex. incremental, full etc.)

Um exemplo de arquivo `config.json` para o `tap-postgres' é apresntado abaixo:

```json
{
    "host": "localhost",
    "port": 5432,
    "dbname": "northwind",
    "user": "postgres",
    "password": "postgres",
    "schema": "public"
}
```

O próximo passa é definir o `schema`. Felizmente, alguns taps facilitam nosso trabalho através do modo "discovery" que gera o `properties.json` de forma automática:

```
tap-postgres --config config.json --discover > properties.json
```

Para rodar o tap de fato, chamado de modo `sync`,  passamos o `properties.json` como argumento:

```
~/.virtualenvs/tap-postgres/bin/tap-postgres --config config.json --properties properties.json
INFO User postgres connected with SSL = False
INFO Selected streams: [] 
INFO No currently_syncing found
```
Como podemos ver no resultado acima, precisamos selecionar quais `streams` (neste caso, tabelas) que queremos sincronizar. Para isso adicionamos uma entrada `"selected": True` nas propriedades de `metadata` do stream e o tipo de replicação que queremos utilizar, neste caso `replication-method: "FULL_TABLE"`:

```json
  "streams": [
    {
      "table_name": "suppliers",
      "stream": "suppliers",
      "metadata": [
        {
          "breadcrumb": [],
          "metadata": {
            "table-key-properties": [
              "supplier_id"
            ],
            "schema-name": "public",
            "database-name": "postgres",
            "row-count": 29,
            "is-view": false,
            "selected":true,
            "replication-method":"FULL_TABLE"
          }
        }

```

Ao rodar novamente o Tap, cada registro da tabela é enviado para o `STDOUT` como um `RECORD`. 

```
{"type": "RECORD", "stream": "suppliers", "record": {"address": "Bat. B 3, rue des Alpes", "city": "Annecy", "company_name": "Gai p\u00e2turage", "contact_name": "Eliane Noz", "contact_title": "Sales Representative", "country": "France", "fax": "38.76.98.58", "homepage": null, "phone": "38.76.98.06", "postal_code": "74000", "region": null, "supplier_id": 28}, "version": 1605660793598, "time_extracted": "2020-11-18T00:53:13.598625Z"}
{"type": "RECORD", "stream": "suppliers", "record": {"address": "148 rue Chasseur", "city": "Ste-Hyacinthe", "company_name": "For\u00eats d'\u00e9rables", "contact_name": "Chantal Goulet", "contact_title": "Accounting Manager", "country": "Canada", "fax": "(514) 555-2921", "homepage": null, "phone": "(514) 555-2955", "postal_code": "J2S 7S8", "region": "Qu\u00e9bec", "supplier_id": 29}, "version": 1605660793598, "time_extracted": "2020-11-18T00:53:13.598625Z"}
INFO METRIC: {"type": "counter", "metric": "record_count", "value": 29, "tags": {}}
{"type": "ACTIVATE_VERSION", "stream": "suppliers", "version": 1605660793598}
{"type": "STATE", "value": {"bookmarks": {"postgres-public-suppliers": {"last_replication_method": "FULL_TABLE", "version": 1605660793598, "xmin": null}}, "currently_syncing": null}}
```

O próximo passo é direcionar esse fluxo de dados, "stream", para um destino, "target".

## Definindo um target

Targets podem ser utilizados com qualquer tap para mover dados para um destino, geralmente um data warehouse. Eles recebem os dados e schema no `stream` e os convertem para tabelas ou outro objeto apropriado. Para mostrar seu funcionamento vamos iniciar utilizando um target simples que salva os dados do tap em arquivos CSV. Para evitar conflitos de versões, vamos instalar o target também em um virtualenv próprio:

```
python3 -m venv ~/.virtualenvs/target-csv
source ~/.virtualenvs/target-csv/bin/activate
pip install target-csv
```

Como o target CSV não precisa de configurações adicionais, basta agora apontar a saída do tap para ele e exportar os streams selecionados como arquivos:

```
~/.virtualenvs/tap-postgres/bin/tap-postgres --config config.json --properties properties.json | ~/.virtualenvs/target-csv/bin/target-csv
```

Que em nosso caso deve gerar um arquivo CSV com este formato:

```csv
address,city,company_name,contact_name,contact_title,country,fax,homepage,phone,postal_code,region,supplier_id
49 Gilbert St.,London,Exotic Liquids,Charlotte Cooper,Purchasing Manager,UK,,,(171) 555-2222,EC1 4SD,,1
P.O. Box 78934,New Orleans,New Orleans Cajun Delights,Shelley Burke,Order Administrator,USA,,#CAJUN.HTM#,(100) 555-4822,70117,LA,2
707 Oxford Rd.,Ann Arbor,Grandma Kelly's Homestead,Regina Murphy,Sales Representative,USA,(313) 555-3349,,(313) 555-5735,48104,MI,3
9-8 Sekimai Musashino-shi,Tokyo,Tokyo Traders,Yoshi Nagase,Marketing Manager,Japan,,,(03) 3555-5011,100,,4
```

### Configurando um target para um data warehouse

Em projetos de ELT, nosso target é em geral um data warehouse. O Singer hoje possui targets para os principais cloud DW como [Amazon Redshift](https://pypi.org/project/target-redshift/) e [Google Big Query](https://github.com/RealSelf/target-bigquery) além de bancos de dados como o [PostgreSQL](https://pypi.org/project/singer-target-postgres/) ou mesmo para o [Google Sheets](https://github.com/singer-io/target-gsheet).

Para simplificar o entendimento, vamos utilizar nosso DW local em Postgres que criamos no ínicio desse tutorial. Embora haja formas mais fáceis de movimentar dados entre bancos de dados no mesmo servidor PostgreSQL, em casos reais nós estaríamos conversando com servidores distintos e geralmente não poderíamos usar o banco de dados transacional como DW. Se você quiser utilizar o Big Query ou outro DW fique à vontade de seguir as instruções na página de cada um desses targets.

Novamente vamos iniciar instalando o target-postgres em um ambiente isolado:

```
python3 -m venv ~/.virtualenvs/singer-target-postgres
source ~/.virtualenvs/singer-target-postgres/bin/activate
pip install singer-target-postgres
```

Primeiramente, precisamos criar um outro arquivo de configurações com as credenciais do banco target, vamos chamar esse arquivo de `dw_postgres_config.json`:

```
{
  "postgres_host": "localhost",
  "postgres_port": 5432,
  "postgres_database": "analytics",
  "postgres_username": "postgres",
  "postgres_password": "postgres",
  "postgres_schema": "northwind_raw"
}

Antes de rodar nosso pipeline, precisamos criar o banco "Analytics" e o schema "northwind_raw"em nosso DW para receber os dados banco transacional da Northwind:

```
psql -U postgres -h localhost -c "CREATE DATABASE analytics"
psql -U postgres -h localhost -d analytics -c "CREATE SCHEMA northwind_raw"
```

Em seguida podemos iniciar nosso pipeline de E-L usando a especificação singer:

```
~/.virtualenvs/tap-postgres/bin/tap-postgres --config config.json --properties properties.json | ~/.virtualenvs/singer-target-postgres/bin/target-postgres --config dw_postgres_config.json
```

Se listarmos as tabelas em nosso DW veremos que a tabela "Suppliers" foi gerada, replicando a tabela original do banco de dados do ERP:

```psql
analytics=# \dt northwind_raw.
              List of relations
    Schema     |   Name    | Type  |  Owner   
---------------+-----------+-------+----------
 northwind_raw | suppliers | table | postgres
(1 row)
```

Por último precisamos configurar a replicação das demais tabelas, conforme fizemos anteriormente. Ao final, devemos ter todas as 12 tabelas da northwind materializadas em nosso schema `northwind_raw` no data warehouse:

```psql
analytics=# \dt northwind_raw.
                    List of relations
    Schema     |         Name         | Type  |  Owner   
---------------+----------------------+-------+----------
 northwind_raw | categories           | table | postgres
 northwind_raw | customers            | table | postgres
 northwind_raw | employee_territories | table | postgres
 northwind_raw | employees            | table | postgres
 northwind_raw | order_details        | table | postgres
 northwind_raw | orders               | table | postgres
 northwind_raw | products             | table | postgres
 northwind_raw | region               | table | postgres
 northwind_raw | shippers             | table | postgres
 northwind_raw | suppliers            | table | postgres
 northwind_raw | territories          | table | postgres
 northwind_raw | us_states            | table | postgres
(12 rows)
```


## Agendando a execução

Fica um próximo desafio: como garantir que esse pipeline execute com um intervalo pré-determinado? Ao utilizar um serviço gerencindo nós não precisamos nos preocupar com manutenção do servidor, alertas de falhas, orquestração, etc. Ao executar os pipeline localmente ou em um servidor gerenciado por nós, é importante entender que muitas coisas podem dar errado. No entanto, os ganhos de flexibilidade podem vir a compensar, principalmente se você ou sua equipe tiver o conhecimento técnico em engenharia de dados para fazer a manutenção dos pipelines.

### Utilizando Cronjobs

A primeira opção pode ser criar um `cronjob`, que é um agendador de tarefas baseado em tempo para sistemas Linux e Mac (ou seu equivalente no Windows). Como boa prática vamos criar um arquivo shell `run_tap.sh` e incluí-lo no `crontab` do usuário:

```bash
#!/bin/bash

~/.virtualenvs/tap-postgres/bin/tap-postgres --config config.json --properties properties.json | ~/.virtualenvs/singer-target-postgres/bin/target-postgres --config dw_postgres_config.json 

```

E torne-o executável (no Linux):

```
chmod +x run_bash.sh
```

Edit ou crie seu cruntab rodando no terminal:

```
crontab -e
```

E adicione a seguinte linha (substituindo pelo caminho do seu arquivo `run_tap.sh`) para rodar o tap 1x a cada hora:

```
* 1 * * * * /path/to/run_tap.sh >/dev/null 2>&1
```

### Utilizando um Orquestrador de Tarefas

Em projetos reais é comum que nosso pipeline possua diferentes etapas de extração, transformação, avisos  de falha etc. Por isso aplicações específicas de orquestração de tarefas através dos chamados DAGs (do inglês, ~directed acyclic graphs~) foram desenvolvidas e são utilizadas por equipes de empresas de todos os portes. Duas dessas aplicações são o [Apache Airflow](https://airflow.apache.org/) e o [Prefect](https://www.prefect.io/)