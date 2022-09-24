echo "Criando tabela"
  awslocal dynamodb create-table \
  --table-name Users \
  --attribute-definitions AttributeName=Id,AttributeType=S \
  --key-schema AttributeName=Id,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=10,WriteCapacityUnits=5 \
  --stream-specification StreamEnabled=true,StreamViewType=NEW_IMAGE
echo "Tabela criada com sucesso"

echo "Criando role iam para lambda"
awslocal iam create-role --role-name LambdaRole \
    --path "/service-role/" \
    --assume-role-policy-document file:///tmp/docker-files/policies/assume-role-policy.json
echo "role iam criada"

echo "Configurando role policy para lambda"
awslocal iam put-role-policy --role-name LambdaRole \
    --policy-name LambdaRolePolicy \
    --policy-document file:///tmp/docker-files/policies/role-policy.json
echo "role policy configurada"

echo "Criando fila SQS"
awslocal sqs create-queue --queue-name users-queue
echo "fila sqs criada"


echo "Criando lambda"

## 1 - grep "Arn" filtra somente a linha com "Arn", 
### resultado após comando 
### "Arn": "arn:aws:iam::000000000000:role/service-role/LambdaRole",

## 2 - cut -d':' -f2- corta fazendo split por : e pega a segunda ocorrência até o final
### resultado após o comando
###  "arn:aws:iam::000000000000:role/service-role/LambdaRole",

## 3 - sed 's|[",]||g' substitui todas as ocorrências de " e , por vazio
### resultado após o comando
### arn:aws:iam::000000000000:role/service-role/LambdaRole
LAMBDA_ARN=$(awslocal iam get-role --role-name LambdaRole | grep "Arn" | cut -d':' -f2- | sed 's|[",]||g')

awslocal lambda create-function \
    --region us-east-1 \
    --function-name users_lambda \
    --zip-file fileb:///tmp/docker-files/lambda/users-lambda.zip \
    --role $LAMBDA_ARN \
    --handler users_lambda.handler \
    --timeout 5 \
    --runtime python

# echo "lambda criada"


echo "Criando trigger para a lambda usando o dynamodb stream"

STREAM_ARN=$(awslocal dynamodb describe-table --table-name Users | grep "LatestStreamArn"  | grep "Arn" | cut -d':' -f2- | sed 's|[",]||g')

awslocal lambda create-event-source-mapping \
    --region us-east-1 \
    --function-name users_lambda \
    --event-source $STREAM_ARN \
    --batch-size 1 \
    --starting-position TRIM_HORIZON


echo "Trigger criada"
