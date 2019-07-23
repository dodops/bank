Bank API

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

### Criar conta
SHOW

```code
GET: http://localhost:3000/products/:id
```

Resposta:

```JSON
{
    "product": {
        "id": 1,
        "code": "9138555461722",
        "description": "Repellendus saepe non consequuntur.",
        "price": "73.72",
        "data": null,
        "name": "Intelligent Wooden Lamp",
        "quantity": 49
    }
}
```

```bash
curl -H 'Content-Type: application/json' -d '{"balance": "930,00"}' -X POST 'http://localhost:3000/accounts'
```

### Consulta de Saldo
```bash
curl -H 'Content-Type: application/json' -d '{"account_id": "1"}' -X GET 'http://localhost:3000/accounts/balance'
```

### Transferencia
```bash
curl -H 'Content-Type: application/json' -d '{"source_account_id": "1", "destination_account_id": "2", "amount": "450,00"}' -X POST 'http://localhost:3000/accounts/transfer'
```

