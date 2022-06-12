
# Boas praticas para repositório publico
Encontrei uma lista interessante de boas praticas em: https://www.datree.io/resources/github-best-practices

### 0 – Don’t git push straight to master
Apliquei este item pois gosto de sempre que possivel praticar um pouco de gitflow, e esta regrinha ajuda a forçar essa pratica também. No caso vou trabalhar especificamente com github-flow pois encaixa melhor no cenário usando apenas:  
* feature-branches
* master

Referência: https://yarax.medium.com/git-flows-and-modern-deployment-pipelines-11eec1a07a2b
### 1 – Don’t commit code as an unrecognized author
Justo, nada a adicionar quanto a isso.

### 2 – Define code owners for faster code reviews
Não faz sentido implementar aqui, só eu vou trabalhar netes repositório.
### 3 – Don’t leak secrets into source control
Vou tentar praticar isso. No caso meu ambiente será Azure, então creio que devo utilizar Azure Key Vault quando for o momento.

Referência: https://docs.microsoft.com/pt-br/azure/devops/pipelines/release/azure-key-vault?view=azure-devops&tabs=yaml

### 4 – Don’t commit dependencies into source control
Next...
### 5 – Don’t commit local config files into source control
Next...
### 6 – Create a meaningful git ignore file
Ao meu ver os itens 4, 5 podem ser resumidos neste e a ferramenta indicada https://www.gitignore.io é bem interessante.

### 7 – Archive dead repositories
Será aplicado quando a hora chegar.

### 8 – Lock package version
Justo, nada a adicionar quanto a isso.
### 9 – Specify standard package versions
Não faz sentido implementar aqui, só eu vou trabalhar netes repositório.
### 10 - Leverage task list
Skip... atividades são controladas no trello
### 11 - Use a branch naming convention
Mencionado no item #0:
* feature-branches
* master
### 12 - Delete stale branches
Justo, nada a adicionar quanto a isso.
### 13 - Keep branches up to date
Justo, nada a adicionar quanto a isso.
### 14 - Remove inactive GitHub members
Não faz sentido implementar aqui, só eu vou trabalhar netes repositório.
### 15 - Enable security alerts
Vou estudar a melhor forma de implementar isso. O GitHub oferece bastante recrusos referente a politicas de segurança.