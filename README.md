# Bank API

* Simple Bank Account System
* Rails 5 API only

## Configuração inicial

O projeto depende das sequintes libs:

* Ruby 2.6.3, ou superior.
* PostgreSQL deve ser instalado e rodando na porta default

Clonando e configurando o banco:

* Clonar o repo: `git clone https://github.com/dodops/bank.git`
* Instalar as gems `cd bank && bundle`
* Criar e migrar o banco de dados `bundle exec rails db:create db:migrate`

## Exemplo de uso

1. Execute `rspec spec` para rodar os testes.
2. Execute `rails s` para iniciar a aplicação. 

-------
* A API é protegida por autenticação via Token, sendo necessário criar um usuário para ter acesso a mesma
* Todos os valores monetários devem ser passados no padrão br: "1.232,00"
* USER_TOKEN = Token do usuário para logar na API

-------

### Criar usuário
Exemplo de requisição:
```bash
curl -X POST \
  http://localhost:3000/users \
  -H 'Content-Type: application/json' \
  -d '{
    "user": {
      "email": "marco@bar.com",
      "password": "testeteste",
      "password_confirmation": "testeteste"
      }
  }'
```

Resposta:

```json
{
  "api_token": "5d2994cdc45b68633785a4bf5cc84cc6"
}
```

### Criar conta
Para criar conta é necessário infomar um valor inicial positivo, em reais.
Requisição:

```bash
curl -X POST http://localhost:3000/accounts \
  -H 'Authorization: Bearer USER_TOKEN' -H 'Content-Type: application/json' \
  -d '{
    "account": {
      "balance": "5.000,00"
    }
  }'
```

### Consulta de Saldo
```bash
curl -X GET http://localhost:3000/accounts/balance -H 'Authorization: Bearer USER_TOKEN' -H 'Content-Type: application/json' -d '{ "account_id": 1 }'
```

### Transferencia

Requisição:
source_account_id: ID da conta do usuário logado onde será debitado o valor
destination_account_id: ID da conta onde será creditado o valor
amount: Valor da transferência

```bash
curl -X POST \
  http://localhost:3000/accounts/transfer -H 'Authorization: Bearer USER_TOKEN' \
  -H 'Content-Type: application/json' \
  -d '{
    "source_account_id": "1",
    "destination_account_id": "2",
    "amount": "300,00"
  }'
```

Resposta:
```json
{
  "message": "Transferencia realizada com sucesso. Saldo restante: 4700,00"
}
```
