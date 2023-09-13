#!/bin/bash


mkdir -p ./application/

cd application

git clone https://myblenet@bitbucket.org/myblenet/ui.git 

cd ui
git switch pre-release
git fetch --all
git pull
git branch
cp envs/.env.sample envs/.env.local

yarn
echo -e "$(cat package.json)" | jq '.scripts'
yarn build
yarn dev

/usr/local/opt/sonar-scanner-5.0.1.3006-macosx/bin/sonar-scanner \
  -Dsonar.projectKey=fly-embraer \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token=sqp_5cb2b15f6b5001aab92a489be1e9007db76a00de
