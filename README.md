# Signal-Desktop AppImage

Latest stable AppImage build of Signal Desktop: https://github.com/signalapp/Signal-Desktop

## Why AppImage?

There is no official Signal-Desktop rpm, and for security reasons I try to avoid community built snaps or flatpaks (especially when they are hard to reproduce). AppImages are portable and easy to build.  

This repository provides a simple and comprehensible way to build the Signal-Desktop AppImage from scratch by yourself using Docker or Podman.  
The source code is pulled from the official [Signal-Desktop Repository](https://github.com/signalapp/Signal-Desktop) and the version can be specified.

## Build Manually

Prerequisites:  
Either `docker` - Tested using Debian 12  
Or `podman` - Tested using Fedora 40

* Clone repository or Download `Dockerfile`
* Check [Signal-Desktop Repository Releases](https://github.com/signalapp/Signal-Desktop/releases) and choose the version you want to build (avoid beta/pre-release).
  * Either choose a git tag, e.g.: `v7.29.0`
  * Or choose a git branch, e.g.: `7.29.x`
* Execute docker build and **update the SIGNAL_BRANCH accordingly to the choosen version.**

```bash
docker build --build-arg SIGNAL_BRANCH=v7.29.0 --output out .
#or
podman build --build-arg SIGNAL_BRANCH=v7.29.0 --output out --format docker .
```

* Folder `./out` will contain new Signal AppImage.

## FAQ

### How to update?

Build a later version as you have built the previous version and start the new AppImage.  
Messages are stored in `~/.config/Signal` your home directory and won't be lost.

### What if the build fails?

Signal must have changed something breaking in their build requirements (they e.g. removed `yarn` from the project recently).  
I'll try to keep this repository updated.

## Future Works

* Automate build using GitHub Actions
* Execute weekly and check latest stable Signal version via GitHub API / releases
* Store AppImage as release in this GitHub project.
