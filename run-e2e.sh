echo "Starting e2e script"

echo Test network connection
curl -i server.local:3000

# yarn run test:e2e-cypress-experiment-chrome
yarn run test:cypress
