# Minimal Cypress WebKit Setup
A minimal test setup to reproduce webkit ECONNRESET error.

See GH issue https://github.com/cypress-io/cypress/issues/26847

### Create a network
```
docker network create --driver bridge network-cypress
```

### Start App
Build
```
docker build . -t app-image -f Dockerfile-app
```

Run
```
docker run --rm -d --name app-container --add-host=server.local:127.0.0.1 --network=network-cypress app-image
```

### Start Cypress
Build
```
docker build . -t test-image -f Dockerfile-test
```

Get app container's IP
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{println .IPAddress}}{{end}}' app-container
```

Run
```
docker run --rm --name test-container \
    --add-host=server.local:<app-container-ip> --network=network-cypress \
    test-image /bin/bash -c scripts/run-e2e.sh
```
