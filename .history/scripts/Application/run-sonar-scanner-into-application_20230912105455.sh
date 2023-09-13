#!/bin/bash
UI_REPO="https://myblenet@bitbucket.org/myblenet/ui.git"
cd ./application
echo "$(pwd)"
sleep 30

# Constants

# Repository Constants
UI_DIR="./application/ui"
UI_BRANCH="pre-release"
ENV_FILE="./envs/.env.local"
PACKAGE_JSON="package.json"
ENV_SAMPLE="./envs/.env.sample"

# SonatQube Scanner Constants
SONAR_KEY="fly-embraer"
SONAR_URL="http://localhost:9000"
SONAR_TOKEN="sqp_5cb2b15f6b5001aab92a489be1e9007db76a00de"
SONAR_BIN="/usr/local/opt/sonar-scanner-5.0.1.3006-macosx/bin/sonar-scanner"

run_sonar_scan() {
    "$SONAR_BIN" \
        -Dsonar.projectKey="$SONAR_KEY" \
        -Dsonar.sources=. \
        -Dsonar.host.url="$SONAR_URL" \ 
    -Dsonar.token="$SONAR_TOKEN"
}

# Functions

get_inside_ui() {
    cd "$UI_DIR"
}

remove_ui_files() {
    rm -rf "$UI_DIR/node_modules/"
    rm -rf "$UI_DIR/yarn.lock*"
    rm -rf "$UI_DIR/yarn-lock*"
    rm -rf "$UI_DIR/package-lock*"
    rm -rf "$UI_DIR/package.lock*"
}

clean_yarn_cache() {
    yarn cache clean -f
}

fetch_latest_code() {
    git fetch --all
    git pull
}

switch_to_branch() {
    git switch "$UI_BRANCH"
}

update_env_file() {
    rm -rf "$ENV_FILE"
    cp "$ENV_SAMPLE" "$ENV_FILE"
}

install_dependencies() {
    cd "$UI_DIR"
    yarn
}

run_ui_as_dev() {
    cd "$UI_DIR"
    yarn build
}

build_ui() {
    cd "$UI_DIR"
    yarn build
}

# Main
get_inside_ui
remove_ui_files
clean_yarn_cache
fetch_latest_code
switch_to_branch
fetch_latest_code
update_env_file
install_dependencies
run_ui_as_dev
build_ui
