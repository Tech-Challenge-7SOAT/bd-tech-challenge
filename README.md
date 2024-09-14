# Fast Food Database -Fiap Tech Challenge

Esse projeto é um exemplo de como criar uma instância de banco de dados AWS RDS usando Terraform e provisionar o banco de dados com um esquema SQL e todos os recursos necessários para o provisionamento do mesmo.
Objetivo do projeto é para atender aos requisitos do Tech Challenge da FIAP, onde o desafio é criar um banco de dados gerenciável com Terraform para uma lanchonete fictícia.

## Escolha do Banco de Dados

O banco de dados escolhido para este projeto é o PostgreSQL. A escolha do PostgreSQL foi baseada em vários fatores:

1. **SQL Completo**: O PostgreSQL suporta o SQL completo e oferece muitos recursos avançados, como junções complexas e transações.
2. **Extensibilidade**: O PostgreSQL é altamente extensível. Ele permite que os usuários definam seus próprios tipos de dados, operadores e funções.
3. **Compatibilidade**: O PostgreSQL é compatível com várias plataformas de hospedagem, o que oferece flexibilidade em termos de implantação.
4. **Comunidade Ativa**: O PostgreSQL tem uma comunidade ativa de desenvolvedores, o que garante atualizações regulares e disponibilidade de suporte.

## Modelo de Dados

O modelo de dados é projetado para suportar as operações do aplicativo de maneira eficiente. O modelo de dados é baseado no seguinte esquema de banco de dados:

### Tabela: `aws_db_instance`

Esta tabela armazena informações sobre a instância do banco de dados AWS RDS.

- `identifier`: Identificador único para a instância do banco de dados.
- `allocated_storage`: A quantidade de armazenamento alocado para a instância do banco de dados.
- `engine`: O mecanismo do banco de dados usado (neste caso, PostgreSQL).
- `engine_version`: A versão do mecanismo do banco de dados.
- `instance_class`: A classe de instância do banco de dados.
- `db_name`: O nome do banco de dados.
- `username`: O nome de usuário para o banco de dados.
- `password`: A senha para o banco de dados.
- `parameter_group_name`: O nome do grupo de parâmetros para o banco de dados.
- `publicly_accessible`: Se a instância do banco de dados é publicamente acessível.
- `db_subnet_group_name`: O nome do grupo de sub-redes do banco de dados.
- `vpc_security_group_ids`: Os IDs do grupo de segurança VPC para a instância do banco de dados.

### Tabela: `null_resource`

Esta tabela é usada para executar comandos locais quando a instância do banco de dados é criada.

- `command`: "export PGPASSWORD=${var.DB_PASSWORD}; sleep 60; psql -U ${var.DB_USERNAME} -d ${var.DB_NAME} -h ${aws_db_instance.default.address} -f ./db_schema.sql"

## Comandos do Provisionador

O provisionador `local-exec` executa os seguintes comandos:

- `export PGPASSWORD=${var.DB_PASSWORD}`: Define a variável de ambiente `PGPASSWORD` para a senha do banco de dados. Isso é necessário porque o comando `psql` que vem a seguir precisa dessa variável de ambiente para autenticação.

- `sleep 60`: Pausa a execução do script por 60 segundos. Isso é geralmente feito para dar tempo para que a instância do banco de dados fique pronta para aceitar conexões.

- `psql -U ${var.DB_USERNAME} -d ${var.DB_NAME} -h ${aws_db_instance.default.address} -f ./db_schema.sql`: Este é o comando que se conecta ao banco de dados e executa o script SQL encontrado no arquivo `db_schema.sql`. Ele usa a variável de ambiente `PGPASSWORD` para autenticação.

## Diagrama de Modelo de Dados

### Tabela: `aws_db_instance`

| identifier | allocated_storage | engine | engine_version | instance_class | db_name | username | password | parameter_group_name | publicly_accessible | db_subnet_group_name | vpc_security_group_ids |
|------------|-------------------|--------|----------------|----------------|---------|----------|----------|----------------------|---------------------|----------------------|------------------------|

### Tabela: `null_resource`

| command |
|---------|

Cada linha na tabela `aws_db_instance` representa uma instância de banco de dados AWS RDS. A tabela `null_resource` é usada para executar comandos locais quando a instância do banco de dados é criada.