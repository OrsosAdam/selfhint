#!/bin/bash

echo "Selfhint is building..."

cd ../..
cd app

echo "Installing node modules..."
npm install --silent
echo "... node modules are done!"

_term() {
    echo "Caught sigterm! Shutdown..."
    kill -TERM "$child1"
}
trap _term SIGTERM

echo "Starting vuepress instance..."
npm run dev
child1=$!
wait ${child1}