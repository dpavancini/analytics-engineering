# Configurando o banco de dados

Para facilitar a aprendizagem, vamos utilizar os dados fictícios de um banco de dados transacional da Northwind, banco de dados famoso criado pela Microsoft. Esse bancos de dados possui uma série de tabelas comuns em um sistema gerencial como pedidos (orders), funcionários (employees), clientes etc.

![](ER.png)

## Utilizando o banco remoto

Um banco remoto da Northwind já está criado para uso neste livro, você pode realizar consultas neste banco via um cliente SQL como [Dbeaver](https://dbeaver.io/) e também pode utilizá-lo para extrair os dados nas etapas de ETL. As credenciais de acesso estão abaixo:

* **Host**: 35.239.223.162	
* **Port**: 5432
* **User**: stitch_extract
* **Password**: etl_101_passwd
* **Database**: northwind

## Configurando seu próprio banco de dados:

### Manualmente

Se você já possui um banco de dados PostgreSQL instalado ou quer criá-lo da forma que preferir, pode simplesmente popular esse banco usando o arquivo `northwind.sql`

1. Baixe o arquivo ou clone esse projeto para seu computador

2. Na pasta onde o arquivo `northwind.sql` estiver localizado, rode o comando abaixo para popular o banco de dados:

```
cat northwind.sql | psql -U [seu-usuario] -h [seu-host] -d northwind

```

### Utilizando o docker

#### Pré-requisitos: instalar docker e docker-compose

 https://www.docker.com/get-started

 https://docs.docker.com/compose/install/


#### 1. Rode o docker-compose

```bash
> docker-compose up

...
... Lots of messages...
...
Creating network "northwind_psql_default" with the default driver
Creating northwind_psql_db_1 ... done
db_1  | 2019-11-28 21:07:14.357 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
db_1  | 2019-11-28 21:07:14.357 UTC [1] LOG:  listening on IPv6 address "::", port 5432
db_1  | 2019-11-28 21:07:14.364 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
db_1  | 2019-11-28 21:07:14.474 UTC [1] LOG:  database system is ready to accept connections
```

#### 2. Rode o  psql client no container do docker-compose 

Abra um novo terminal, e digite:

````bash
> docker-compose exec db psql -U northwind_user -d northwind

psql (10.5 (Debian 10.5-1.pgdg90+1))
Type "help" for help.

postgres=# select * from us_states;
 state_id |      state_name      | state_abbr | state_region
----------+----------------------+------------+--------------
        1 | Alabama              | AL         | south
        2 | Alaska               | AK         | north
        ...
````

#### 3. Pare o docker-compose

Para o servidor que foi criado ao rodar `docker compose up` via `Ctrl-C`, e remova os containers via

```bash
docker-compose down
```

Suas modificações serão persistidas na pasta local `dabata/` e serão re-utilizados
quando reiniciarmos o `docker compose up`.


## Referências:

[Northwind_psql](https://github.com/pthom/northwind_psql)