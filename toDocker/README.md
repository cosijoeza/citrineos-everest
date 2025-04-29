Rutas donde hay archivos de configuración

`Server/src/config/envs/` *

`Server/dist/config/envs/`

Cambio de nombres a los servicios en `Server/docker-compose.yml` `docker-compose-v2.yml`

Nombres anteriores -> Nuevos nombres

- amqp-broker -> citrineos-rabbitmq
- ocpp-db -> citrineos-postgis
- citrine -> citrineos-directus-core 8080     *
- directus -> citrineos-directus-webui 8055

Edite los archivos: `docker.ts` `swarn.docker.ts` `local.ts`
```json
    data: {
      sequelize: {
        host: 'ocpp-db',
        port: 5432,
        database: 'citrine',
        dialect: 'postgres',
        username: 'citrine',
        password: 'postgres_4',
        storage: '',
        sync: false,
      },
    },
```


Para hacer los procesos de abajo, previament elimine la carpeta `Server/data`

```
cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ docker compose -f docker-compose-v2.yml up -d citrineos-postgis
[+] Running 2/2
 ⠿ Network citrineos-net        Created                                                                                                                                                                                                                                                                    0.8s
 ⠿ Container citrineos-postgis  Started
 ```
Acceder al contenedor para revisar la contraseña
```bash
docker exec -it citrineos-postgis bash
```
user: `citrine` psswd:`postgres_4`
```
root@5a4bfe54009f:/# psql -U citrine -d postgres_4
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "postgres_4" does not exist
```
user: `citrine` psswd:`citrine`
```
root@5a4bfe54009f:/# psql -U citrine -d citrine
psql (16.2 (Debian 16.2-1.pgdg110+2))
Type "help" for help.

citrine=#

```
Reviso los logs
```
docker logs citrineos-postgis
```
[postgis-logs](logs/postgis.logs)

Modifiqué los permisos de la carpeta, detengo el contenedor y luego lo elimino.

```bash
cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ sudo chown -R cosi:cosi data
ta[sudo] contraseña para cosi:

cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ sudo chmod -R +777 data

cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ docker compose -f docker-compose-v2.yml up -d citrineos-postgis
[+] Running 1/0
 ⠿ Container citrineos-postgis  Running                                                                                                                                                                                                                                                                    0.0s

cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ docker compose -f docker-compose-v2.yml stop citrineos-postgis
[+] Running 1/1
 ⠿ Container citrineos-postgis  Stopped                                                                                                                                                                                                                                                                    3.3s

cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ docker remove citrineos-postgis
citrineos-postgis
```

Levanto el servicio `citrineos-postgis` de nuevo y vuelvo a intentar conectarme a la base de datos y reviso los logs.

```bash
cosi@cosi-pc:~$ docker exec -it citrineos-postgis bash

root@ea02e43dc6f2:/# psql -U citrine -d postgres_4
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "postgres_4" does not exist

root@ea02e43dc6f2:/# psql -U citrine -d citrine
psql (16.2 (Debian 16.2-1.pgdg110+2))
Type "help" for help.

citrine=#
```
[postgis-logs](logs/postgis-2.logs)