# Descripción
## Setup
Este respositorio pretende desplegar en contenedores una blockchain en la cual automáticamente se levantan todos los nodos y interconectan.

La blockchain está compuesta por 3 nodos (node1, node2, node3), que inicialmente están vacíos. Para inicializar la blockchain se debe invocar a restart.

```console
foo@bar:~$ sudo ./restart
```
Con este comando se configura la red blockchain, inicializando los 3 nodos con un address cada uno y se interconectan.

##Deploy
Para desplegar la red, tan solo será necesaria la llamada sobre Docker-compose.
```console
foo@bar:~$ docker-compose up
```
Desplegará 3 contenedores en una red privada que ejecutan un nodo de la blockchain.
