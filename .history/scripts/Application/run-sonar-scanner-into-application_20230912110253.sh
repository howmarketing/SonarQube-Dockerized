#!/bin/bash
UI_REPO="https://myblenet@bitbucket.org/myblenet/ui.git"

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
stop_and_debug() {
    echo -e "\n\n\n===================================================\n"
    echo -e "                                       STOP AND DEBUG                                          "
    echo -e "---------------------------------------------------------------------\n"

    echo "*"
    echo "# 01."
    echo -e "PWD:\n$(pwd)"
    echo -e "------\n"

    echo "*"
    echo "# 02"
    echo -e "UI_REPO:\n$UI_REPO"
    echo -e "------\n"

    echo "*"
    echo "# 03"
    echo -e "UI_DIR:\n$UI_DIR"
    echo -e "------\n"

    echo "*"
    echo "# 04"
    echo -e "UI_BRANCH:\n$UI_BRANCH"
    echo -e "------\n"

    echo "*"
    echo "# 05"
    echo -e "ENV_FILE:\n$ENV_FILE"
    echo -e "------\n"

    echo "*"
    echo "# 06"
    echo -e "PACKAGE_JSON:\n$PACKAGE_JSON"
    echo -e "------\n"

    echo "*"
    echo "# 07"
    echo -e "ENV_SAMPLE:\n$ENV_SAMPLE"
    echo -e "------\n"

    echo "*"
    echo "# 02"
    echo -e "SONAR_KEY:\n$SONAR_KEY"
    echo -e "------\n"

    echo "*"
    echo "# 02"
    echo -e "SONAR_URL:\n$SONAR_URL"
    echo -e "------\n"

    echo "*"
    echo "# 02"
    echo -e "SONAR_TOKEN:\n$SONAR_TOKEN"
    echo -e "------\n"

    echo "*"
    echo "# 02"
    echo -e "SONAR_BIN:\n$SONAR_BIN"
    echo -e "===================================================\n\n\n\n"
    sleep 86000
}
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
stop_and_debug
remove_ui_files
clean_yarn_cache
fetch_latest_code
switch_to_branch
fetch_latest_code
update_env_file
install_dependencies
run_ui_as_dev
build_ui
