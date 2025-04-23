# my_frist_flutter_project

Este projeto é referente ao meu estudos com flutter

- usando componentes (widgets)
- funções assincronas
- banco de dados
- dados locais
- dados em memória
- configurar rotas
- configurar widgets e ações

## Getting Started

### INICIAR API FAKER

Para iniciar a api faker você precisa primeiramente ter o NODE instalado em sua máquina, 
depois rodar o comando abaixo

```bash
npm intall -g json-server
```

para rodar o `json-sever` rodar o command 

```bash
json-server --watch lib/data/db.json
```

caso você deseje pode informar o IP da máquina local com o comand

```bash
json-server --watch --host 00.00.00.00 lib/data/db.json
```

O endereço de ip deve ser coletado com o comand (windowns)

```bash
ipconfig
```

O IP nescessário está em endereço de  Endereço IPv4. . . . . . . .  . . . . . . . :

___
## FLUXO DE AUTENTICAÇÃO

Para usar o fluxo de autenticação esse projeto usa uma json api com o json-server além o json server instalado acima vc precisa instalar o json-server-auth
````bash
npm install -g json-server-auth
````

___
# TROUBLESHOOT

### ERRO COM JSON SERVER AUTH
    durante a realização desse projeto tive alguns erros com o json-server-auth, algumas vezes tinha mensagens de error e ao rodar --version no terminal não conseguia encontrar a versão corresponde. Então para solucionar o problema precisei instalar as versões especificas do json-server e json-serve-auth

1. Rodei o command: 
````bash
npm uninstall -g json-server json-server-auth
````
2. Então instalei um por vez com suas versões corresondentes.
````bash
npm install json-server@0.17.4
npm install json-server-auth@0.15.1
````
Após executar esse commands o error foi corrigido e pude rodar novamente o JSON-SERVER-AUTH e continuar com o progresso da aplicação.
