# Preparando ambiente local
Seguir os passos indicados nos seguintes links:
* [install-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)
* [quickstart-create-templates-use-visual-studio-code](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=CLI)

# Escopo do template
No universo de templates azure existem algun niveis de escopo com schemas diferentes
* Tenant
* ManagementGroups 
* subscriptions
* resourceGroup

Para criar um resource group é necessário trabalhar no nivel de subscription, posteriormente para o aks e demais recursos da aplicação o escopo desce e trabalhamos no escopo de resourceGroup.

Referências:
* https://docs.microsoft.com/pt-br/azure/azure-resource-manager/templates/deploy-to-subscription
* https://docs.microsoft.com/pt-br/cli/azure/deployment/sub?view=azure-cli-latest

### Passos para rodar os comandos az cli
1 - Realizar login no azure
``` bash
az login
```
2 - Entrar no contexto da subscrição onde serão criados os recursos
``` bash
az account set --subscription [SubscriptionID/SubscriptionName]
```
### Criando ResourceGroup
3 - Criar deployment do ambiente com base no template
``` bash
$rgtemplate=".\iac\arm-template\rg\azuredeploy.json"
$rgparameters=".\iac\arm-template\rg\azuredeploy.parameters.json"

az deployment sub create `
  --name rg-challenge `
  --location eastus2 `
  --template-file $rgtemplate `
  --parameters $rgparameters
```

### Criando ACR
4 - Criar deployment do acr com base no template

``` bash
$acrtemplate=".\iac\arm-template\acr\azuredeploy.json"
$acrparameters=".\iac\arm-template\acr\azuredeploy.parameters.json"

az deployment group create `
  --resource-group rg-app-aluraflix `
  --template-file $acrtemplate `
  --parameters $acrparameters
```

### Criando AKS
5 - Criar deployment do aks com base no template

``` bash
$akstemplate=".\iac\arm-template\aks\azuredeploy.json"
$aksparameters=".\iac\arm-template\aks\azuredeploy.parameters.json"

az deployment group create `
  --resource-group rg-app-aluraflix `
  --template-file $akstemplate `
  --parameters $aksparameters
```
Sera criado um cluster de capacidade minima com maquinas `Standard_B2ms` em rede `kubenet` integrado ao ACR criado no passo anterior.

###
6 - Vincular AKS ao ACR
``` bash
$aksname="aks-cluster-dev"
$acrname="devopschallenge101"
$rgname="rg-app-aluraflix"

az aks update --name $aksname ` 
  --resource-group $rgname `
  --attach-acr $(az acr show -n $acrname --query "id" -o tsv) 
```
7 - Verificar atribuição de acesso "AcrPull"
``` bash 
az role assignment list `
  --assignee $(az aks show -n $aksname -g $rgname --query "identityProfile.kubeletidentity.clientId" -o tsv) `
  --scope $(az acr show -n $acrname --query "id" -o tsv) 
```
### Colocando a Aplicação no Ar (manual)
8 - Atribuir contexto do kubectl ao aks
``` bash
az aks get-credentials `
  --name aks-cluster-dev `
  --overwrite-existing `
  --resource-group rg-app-aluraflix 
```
7 - Aplicar arquivos de manifesto
``` bash
kubectl apply -f ./src/manifest/configmap.yaml 
kubectl apply -f ./src/manifest/deployment.yaml 
```
8 - Para testar basta acessar o ip externo da aplicação 
``` bash
kubectl get svc 
```


-----
DRAFT - AINDA NAO FUNCIONA... .
> #### Armazenamento de Secrets com Key Vault
> 7 - Para armazenar as chaves da aplicação de forma segura vamos adicionar Key Vault.
> Como é um recurso que não vamos ficar criando a todo momento não vou utilizar template. Key Vault é um recurso global, então é necessário criar um nome unico para ele, então vamos usar esse script
> ```
> $kvname='kv-aluraflix-'+(-join ((0x30..0x39) +  ( 0x61..0x7A) | Get-Random -Count 8  | % {[char]$_}))
> ```
> Agora sim, [criando o key vault](https://docs.microsoft.com/pt-br/azure/aks/csi-secrets-store-driver#create-or-use-an-existing-azure-key-vault)
> ```
> az keyvault create --location eastus2 --name $kvname --resource-group rg-app-aluraflix
> ```
> Criando segredo da aplicação:
> ```
> az keyvault secret set --vault-name $kvname --name "django-password" --value $django-password
> ```
> [Habilitando CSI Drive no aks](https://docs.microsoft.com/pt-br/azure/aks/csi-secrets-store-driver#upgrade-an-existing-aks-cluster-with-azure-key-vault-provider-for-secrets-store-csi-driver-support) 
> ```
> az aks enable-addons --addons azure-keyvault-secrets-provider --name aks-cluster-dev --resource-group rg-app-aluraflix
> ```
> 8 - [SecretClassProvider com Key Vault](
> https://docs.microsoft.com/pt-br/azure/aks/csi-secrets-store-driver#sync-mounted-content-with-a-kubernetes-secret)
> ``` 
> apply -f secretclass.yaml
> ```
> .
-----


## Vivendo e aprendendo
<b>Nota 1</b>: Barra invertida nao funciona no powershell do vs-code, ao inves disso trocar por crase. Referencia ["Expressão ausente após operador unário '--'"](https://pt.stackoverflow.com/questions/419382/express%C3%A3o-ausente-ap%C3%B3s-operador-un%C3%A1rio-ao-tentar-instalar-o-postgres-pelo)

<b>Nota 2</b>: Linha de comendao de criação de deploymente apresentava o seguinte erro: 
> `Failed to parse 'https://github.com/biondivini/challenge-devops-1/blob/master/iac/azuredeploy.json', please check whether it is a valid JSON format`

Eu estava pasando o link do github mas deveria pegar o link `raw.github`. 

<b>Nota 3</b>: O comando `az deployment sub delete` não esta funcionando. https://github.com/Azure/azure-cli/issues/20205
