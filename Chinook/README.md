# Configurando o banco de dados Chinook

O banco de dados Chinook é um banco de dados fictícios utilizado como alternativa ao banco Northwind. Esse bancos de dados representa uma loja de música digital (ex. iTunes) e possui tabelas de artistas, músicas, albuns, etc.

## Configurando seu próprio banco de dados:

### Manualmente

Se você já possui um banco de dados PostgreSQL instalado ou quer criá-lo da forma que preferir, pode simplesmente popular esse banco usando o arquivo `Chinook_PostgreSql.sql`

1. Baixe o arquivo ou clone esse projeto para seu computador

2. Na pasta onde o arquivo `Chinook_PostgreSql.sql` estiver localizado, rode o comando abaixo para popular o banco de dados:

```
dropdb --if-exists -U [seu-usuario] -h [seu-host] chinook &&
createdb -U [seu-usuario] -h [seu-host] chinook && 
cat Chinook_PostgreSql.sql | psql -U [seu-usuario] -h [seu-host] -d chinook

```

### Outros bancos de dados

Se você se sente confortável em trabalhar com outros bancos de dados como MySQL, Oracle, etc. Você pode encontrar scripts para criação das tabelas no repositório oficial do [Chinook](https://github.com/lerocha/chinook-database)

### Referências:

https://github.com/lerocha/chinook-database