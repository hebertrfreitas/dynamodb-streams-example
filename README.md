## Exemplo de projeto usando DynamoDB Streams (WIP)


Projeto para exemplificar o uso do [dynamodb streams](https://docs.aws.amazon.com/pt_br/amazondynamodb/latest/developerguide/Streams.html)



## Arquitetura


![Imagem arquitetura](./docs/transaction-outbox-with-dynamostreams.png)



### Referências

https://engineering.zalando.com/posts/2022/02/transactional-outbox-with-aws-lambda-and-dynamodb.html



## instruções para a lambda

É recomendável criar uma ambiente virtual para excução do código python, para isso execute os seguintes comandos:

```shell
cd lambda
pip3 install virtualenv #caso não tenha o virtual environment instalado
python3 -m venv .venv
source .venv/bin/activate
```

Para instalar as dependências use:

```shell
pip3 install -r requirements.txt
```
