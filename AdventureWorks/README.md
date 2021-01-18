# Configurando o banco de dados da Adventure Works

A Adventure Works é um banco de dados OLTP fictício disponibilizado pela Microsoft para desenvolvimento e treinamento. Ele representa os dados de uma indústria de bicicletas fictícia com 500 produtos distintos, 20000 clientes e 31000 pedidos. Esses dados estão distribuídos em 68 tabelas dividas em 5 schemas: HR (Recursos humanos), sales (vendas), production (produção) e purchasing (compras).

## Configurando seu próprio banco de dados:

### Manualmente

Se você já possui um banco de dados PostgreSQL instalado ou quer criá-lo da forma que preferir, pode simplesmente popular esse banco usando o arquivo `install.sql`

1. Baixe o arquivo ou clone esse projeto para seu computador

2. Na pasta onde o arquivo `install.sql` estiver localizado, rode o comando abaixo para popular o banco de dados:

```
dropdb --if-exists -U [seu-usuario] -h [seu-host] Adventureworks &&
createdb -U [seu-usuario] -h [seu-host] Adventureworks && 
cat install.sql | psql -U [seu-usuario] -h [seu-host] -d Adventureworks
```

# Diagrama

![](AdventureWorksERD.jpeg)

### Referências:

https://github.com/NorfolkDataSci/adventure-works-postgres
https://github.com/lorint/AdventureWorks-for-Postgres
https://msftdbprodsamples.codeplex.com/downloads/get/880662
https://txtrainingstore.blob.core.windows.net/db-backup-aw2019/AdventureWorksERD

