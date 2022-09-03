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