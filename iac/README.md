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
1. https://docs.microsoft.com/pt-br/azure/azure-resource-manager/templates/deploy-to-subscription
2. https://docs.microsoft.com/pt-br/cli/azure/deployment/sub?view=azure-cli-latest

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
az deployment sub create `
  --name chalangeDeployment `
  --location eastus2 `
  --template-uri $template `
  --parameters $parameters
```
para uso local trocar `template-uri` por `template-file`

4 - visualizar deployment criado
``` bash
az deployment sub list
```
### Criando AKS
5 - visualizar deployment criado
``` bash
az deployment group create `
  --resource-group rg-app-aluraflix `
  --template-file $template `
  --parameters $parameters
```
### Configurando AKS
6 - Atribuir contexto do kubectl ao aks
``` bash
az aks get-credentials `
  --name aks-cluster-dev `
  --overwrite-existing `
  --resource-group rg-app-aluraflix 
```

## Vivendo e aprendendo
<b>Nota 1</b>: Barra invertida nao funciona no powershell do vs-code, ao inves disso trocar por crase. Referencia ["Expressão ausente após operador unário '--'"](https://pt.stackoverflow.com/questions/419382/express%C3%A3o-ausente-ap%C3%B3s-operador-un%C3%A1rio-ao-tentar-instalar-o-postgres-pelo)

<b>Nota 2</b>: Linha de comendao de criação de deploymente apresentava o seguinte erro: 
> `Failed to parse 'https://github.com/biondivini/challenge-devops-1/blob/master/iac/azuredeploy.json', please check whether it is a valid JSON format`

Eu estava pasando o link do github mas deveria pegar o link `raw.github`. 

<b>Nota 3</b>: O comando `az deployment sub delete` não esta funcionando. https://github.com/Azure/azure-cli/issues/20205
