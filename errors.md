# Errors
I got next errors the first time.

## Error #0

@workspace /explain No se encuentra el módulo `ts-jest` ni sus declaraciones de tipos correspondientes.

Solution

We need to install `@types/jest`

```bash
npm install --save-dev ts-jest @types/jest
```

Set up`tsconfig.json` file. It must include the next section `compilerOptions`

```json
{
  "compilerOptions": {
    "types": ["jest"],
    "module": "commonjs",
    "target": "es6",
    "esModuleInterop": true
  }
}
```

## Error #1

```bash
cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ docker compose -f ./docker-compose.yml up -d
[+] Running 2/3
 ⠿ Container server-ocpp-db-1      Starting                                                                                                                 7.2s
 ⠿ Container server-directus-1     Created                                                                                                                  0.0s
 ⠿ Container server-amqp-broker-1  Started                                                                                                                  7.2s
Error response from daemon: driver failed programming external connectivity on endpoint server-ocpp-db-1 (dca1698573ced5e77d394406bf8dcb6ff81ce5cc53adb5867bfd6b23a82b4613): failed to bind port 0.0.0.0:5432/tcp: Error starting userland proxy: listen tcp4 0.0.0.0:5432: bind: address already in use
```

Solution

Identify what process is using port 5432

```
sudo lsof -i :5432
```

If process is an instance of local PostgreSQL you can stop temporally

```
sudo systemctl stop postgresql
```

Update file `docker-compose.yml` to assign a new port for container `ocpp-db`

You can change this

```docker
ports:
  - 5432:5432
```

to

```docker
  ports:
  - 5433:5432
```

## Error #2

```ruby
cosi@cosi-pc:~/Documentos/datyra/citrineos-core/Server$ docker compose -f ./docker-compose.yml up -d
[+] Running 3/4
 ⠿ Container server-ocpp-db-1      Healthy                                                                                                                                                                                                                                                           10.1s
 ⠿ Container server-directus-1     Healthy                                                                                                                                                                                                                                                           20.1s
 ⠿ Container server-amqp-broker-1  Healthy                                                                                                                                                                                                                                                           14.6s
 ⠴ Container server-citrine-1      Starting                                                                                                                                                                                                                                                           2.5s
Error response from daemon: driver failed programming external connectivity on endpoint server-citrine-1 (150cf0e520a5995f7e808f4d5f5e7effb431b338dfa1f0ae0cab12566729b494): failed to bind port 0.0.0.0:8081/tcp: Error starting userland proxy: listen tcp4 0.0.0.0:8081: bind: address already in use
```

Solution

Identify what process is using port 8081

```
sudo lsof -i :8081
```

Update file `docker-compose.yml` to assign a new port for container `ocpp-db`

You can change this

```docker
ports:
  - 8081:8081
```

to

```docker
ports:
    - 8083:8081
```

### Error #3

```
node:events:368 throw er; // Unhandled 'error' event ^

Error: spawn docker-compose ENOENT at Process.ChildProcess._handle.onexit (node:internal/child_process:282:19) at onErrorNT (node:internal/child_process:477:16) at processTicksAndRejections (node:internal/process/task_queues:83:21) Emitted 'error' event on ChildProcess instance at: at Process.ChildProcess._handle.onexit (node:internal/child_process:288:12) at onErrorNT (node:internal/child_process:477:16) at processTicksAndRejections (node:internal/process/task_queues:83:21) { errno: -2, code: 'ENOENT', syscall: 'spawn docker-compose', path: 'docker-compose', spawnargs: [ 'up' ] }
```

`Server/package.json`

Change this:

```json
"scripts":{
  "start-everest":"cd ./everest && cross-env EVEREST_IMAGE_TAG=0.0.16 EVEREST_TARGET_URL=ws://host.docker.internal:8081/cp001 docker-compose up"
}
```

to:

```json
"scripts":{
  "start-everest":"cd ./everest && cross-env EVEREST_IMAGE_TAG=0.0.16 EVEREST_TARGET_URL=ws://host.docker.internal:8081/cp001 docker compose up"
}
```
```
{"success":false,"payload":"Failed updating password on cp001 station"}cosi@cosi-pc:~$ curl --location --request POST 'localhost:8080/data/configuration/password?callbackUrl=csms.pro/api/notifications' --header 'Content-Type: application/json' --data '{
  "stationId": "cp001",
  "password": "DEADBEEFDEADBEEF",
  "setOnCharger": true
}'



```

## Errors with Broker port:

You can change the number port here:

`everest-core/config/nodered/config-sil-two-evse-flow.json`
```json
"broker": "localhost",
"port": "1886"
```