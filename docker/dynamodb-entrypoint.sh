echo "Criando tabela"
  awslocal dynamodb create-table \
  --table-name User \
  --attribute-definitions AttributeName=Id,AttributeType=S \
  --key-schema AttributeName=Id,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=10,WriteCapacityUnits=5 \
  --stream-specification StreamEnabled=true,StreamViewType=NEW_IMAGE
  echo "Tabela criada com sucesso"