#!/bin/bash

script_dir=$(dirname "$0")
application_folder="${script_dir}/application"
# verify if the application folder exists to get inside it
if [ -d "$application_folder" ]; then
    cd "$application_folder"
else
    echo "Application folder not found"
    exit 1
fi
bash ./prepare-project.sh

rm -rf ./node_modules/
rm -rf ./yarn.lock*
rm -rf ./yarn-lock*
rm -rf ./package-lock*
rm -rf ./package.lock*

yarn cache clean -f

git fetch --all
git pull
git switch master
git pull
git fetch --all
git pull
git switch pre-relse

git pull

rm -rf ./envs/.env.local
cp ./envs/.env.sample ./envs/.env.local

yarn
yarn build
