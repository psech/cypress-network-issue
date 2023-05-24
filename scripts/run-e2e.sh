echo "Starting e2e script"

echo DEBUG: Test network connection
curl -s -o /dev/null -w "%{json}" http://server.local:3000 | jq

# yarn run test:e2e-cypress-experiment-chrome
yarn run test:cypress
