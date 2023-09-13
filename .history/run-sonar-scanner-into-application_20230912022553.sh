#!/bin/bash

cd ui

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
