#!/bin/bash

# Constants
APP_DIR="./application"
UI_REPO="https://myblenet@bitbucket.org/myblenet/ui.git"
UI_BRANCH="pre-release"
ENV_FILE="envs/.env.local"
ENV_SAMPLE="envs/.env.sample"
PACKAGE_JSON="package.json"
SONAR_URL="http://localhost:9000"
SONAR_TOKEN="sqp_5cb2b15f6b5001aab92a489be1e9007db76a00de"
SONAR_KEY="fly-embraer"
SONAR_BIN="/usr/local/opt/sonar-scanner-5.0.1.3006-macosx/bin/sonar-scanner"

# Functions
setup_app_dir() {
    mkdir -p "$APP_DIR"
    cd "$APP_DIR"
}

clone_ui_repo() {
    git clone "$UI_REPO"
}

configure_ui() {
    cd ui
    git pull
    git fetch --all
    git switch "$UI_BRANCH"
    git fetch --all
    git pull
    cp "$ENV_SAMPLE" "$ENV_FILE"
    yarn
}

build_ui() {
    yarn build
    yarn dev
}

run_sonar_scan() {
    "$SONAR_BIN" \
        -Dsonar.projectKey="$SONAR_KEY" \
        -Dsonar.sources=. \
        -Dsonar.host.url="$SONAR_URL" \ 
    -Dsonar.token="$SONAR_TOKEN"
}

# Main
setup_app_dir
clone_ui_repo
bash ./prepare-project.sh
configure_ui
build_ui
run_sonar_scan
