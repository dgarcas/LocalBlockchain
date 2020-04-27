# Descripción
Este proyecto despliega una blockchain ethereum compuesta por tres nodos en contenedores docker. Dado que se trata de una red privada, no se utiliza el tradicional algoritmo de consenso Ethash basado en proof-of-work. En su lugar se utiliza uno menos costoso en cuanto a recursos computacionales, se trata de Clique, un basado en proof-of-authority. Este algoritmo está presente en testnet como Rinkeby o Görli.
## Setup
La blockchain está compuesta por 3 nodos (node1, node2, node3), que inicialmente están vacíos. Para inicializar la blockchain se debe invocar a restart.

```console
foo@bar:~$ sudo ./restart.sh
```
Con este comando se configura la red blockchain, inicializando los 3 nodos con un address cada uno y se interconectan. Existe un fichero en la raíz del proyecto, denominado [**pass**](pass). Este configura la contraseña de todas las address por defecto y simplicidad se ha establecido como **123**. Además establece otros valores de configuración, tales como la configuración en el bloque genesis con sus respectivo firmante para el algoritmo arriba descrito.

## Deploy blockchain
Para desplegar la red, tan solo será necesaria la llamada sobre Docker-compose.
```console
foo@bar:~$ docker-compose up
```
Desplegará 3 contenedores en una red privada que ejecutan un nodo de la blockchain.

## Deploy smartcontract

Por simplicidad se ha configurado un único address capaz de desplegar contratos. Este address está alojado en el nodo 1. Para el despliege del contrato se ha habilitado un directorio donde alojar un proyecto truffle `truffle-project`. Cuando se copie el proyecto truffle al directorio, se debe tener cuidado de no machacar el fichero `truffle-project/truffle-config.js` creado durante el [setup](#Setup). Pues este configura la dirección de despliegue del contrato.

Para desplegar el contrato, en primer lugar hay que [desplegar la blockchain](#Deploy-blockchain) y tras ello compilar y migrar el contrato. Para esto se debe invoncar a truffle en el interior del nodo 1 con el siguiente comando:
```console
foo@bar:~$ docker exec node1 truffle migrate
```

## Apagado
