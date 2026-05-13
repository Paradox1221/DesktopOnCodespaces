#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_URL="https://git.mollomm1.dev/Mollomm1/DesktopOnCodespaces"
IMAGE_NAME="desktoponcodespaces"
CONTAINER_NAME="DesktopOnCodespaces"

if [ -f "${SCRIPT_DIR}/Dockerfile" ] && [ -f "${SCRIPT_DIR}/installer.py" ]; then
    REPO_DIR="${SCRIPT_DIR}"
else
    REPO_DIR="${PWD}/DesktopOnCodespaces"

    if [ ! -d "${REPO_DIR}/.git" ]; then
        rm -rf "${REPO_DIR}"
        git clone "${REPO_URL}" -b main "${REPO_DIR}"
    fi
fi

SAVE_DIR="$(dirname "${REPO_DIR}")/Save"

cd "${REPO_DIR}"

python3 -m pip install textual
sleep 2
python3 installer.py
docker build -t "${IMAGE_NAME}" . --no-cache

cd ..

sudo apt update
sudo apt install -y jq

mkdir -p "${SAVE_DIR}"
cp -r "${REPO_DIR}/root/config/." "${SAVE_DIR}/"

json_file="${REPO_DIR}/options.json"

docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true

docker_run_args=(
    docker run -d
    --name="${CONTAINER_NAME}"
    -e PUID=1000
    -e PGID=1000
    --security-opt seccomp=unconfined
    -e TZ=Etc/UTC
    -e SUBFOLDER=/
    -e TITLE=GamingOnCodespaces
    -p 3000:3000
    --shm-size=2gb
    -v "${SAVE_DIR}:/config"
    --restart unless-stopped
)

if jq -e '.enablekvm == true' "${json_file}" >/dev/null; then
    docker_run_args+=(--device=/dev/kvm)
fi

docker_run_args+=("${IMAGE_NAME}")
"${docker_run_args[@]}"

for _ in $(seq 1 60); do
    if curl -fsS http://127.0.0.1:3000 >/dev/null 2>&1; then
        clear
        echo "INSTALL FINISHED!"
        echo "Open http://127.0.0.1:3000"
        exit 0
    fi
    sleep 2
done

echo "Desktop container started, but port 3000 is still warming up."
echo "Open http://127.0.0.1:3000"
