# DesktopOnCodespaces (Beta)
## PLEASE NOTE: THIS WAS MADE BY [**Mollomm1**](https://git.mollomm1.dev/Mollomm1/DesktopOnCodespaces)! THIS REPOSITORY WILL NOT BE UPDATED, PLEASE FORK YOUR OWN FOR UPDATES!
[**See Screenshots**](https://git.mollomm1.dev/Mollomm1/DesktopOnCodespaces/src/branch/main/screenshots.md)

> ⚠️ This project is currently a work in progress and is still unfinished. While I'm actively working on it and making progress, there may still be bugs and incomplete features. ⚠️

> it also works on [gitpod](https://gitpod.io/workspaces)

## Performance Defaults (Cloud Environments)

This repository now includes:

* Reduced Docker build overhead by consolidating package install + cleanup into one build layer.
* Fewer package index refreshes during optional app installs (less repeated `apt update` work).
* Lightweight default `options.json` (`I3`, minimal default apps) for faster first-time cloud startup.
* A `.devcontainer/devcontainer.json` with cloud-friendly defaults (`--shm-size=2gb`, port 3000 auto-forward, host requirements).
* Startup scripts that `exec` the desktop session directly to reduce wrapper process overhead.

# Supported Stuff

* 1080p 60fps

* Sound

* Windows apps (wine)

* Browsering (Firefox included!)

* Home Persistance (You keep your files!)

# Use

it's very simple to install, there is a pseudo-graphical installer.

first start a new codespace https://github.com/codespaces/new
to install just copy and paste this command in your codespace terminal
```
curl -O https://git.mollomm1.dev/Mollomm1/DesktopOnCodespaces/raw/branch/main/install.sh
chmod +x install.sh
./install.sh
```
for dev branch (unstable)
```
curl -O https://git.mollomm1.dev/Mollomm1/DesktopOnCodespaces/raw/branch/dev/install-dev.sh
chmod +x install-dev.sh
./install-dev.sh
```
