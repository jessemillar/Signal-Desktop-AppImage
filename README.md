# Signal-Desktop AppImage

Latest stable AppImage build of Signal Desktop: https://github.com/signalapp/Signal-Desktop

## Why AppImage?

There is no official Signal-Desktop rpm, and for security reasons I try to avoid community built snaps or flatpaks (especially when they are hard to reproduce). AppImages are portable and easy to build.  

This repository provides a simple and comprehensible way to build the Signal-Desktop AppImage from scratch by yourself using Docker or Podman.  
The source code is pulled from the official [Signal-Desktop Repository](https://github.com/signalapp/Signal-Desktop) and the version can be specified.

I am always open for improvments, feel free to create a GitHub Issue.

## Download Release

You can download the automated build of Signal from [Releases](https://github.com/karo-solutions/Signal-Desktop-AppImage/releases)  
After the download don't forget to allow the execution of the AppImage:
`chmod +x Signal-[version].AppImage`

### Can I trust this build?

A [GitHub Action](https://github.com/karo-solutions/Signal-Desktop-AppImage/actions) builds and releases the AppImage automatically weekly if Signal released a new version.  
The Action and its logs can be reviewed.
Of course you can also review the [Dockerfile](./Dockerfile) and build the AppImage by yourself (see next section).

## Build Manually

Prerequisites:  
Either `docker` - Tested using Debian 12  
Or `podman` - Tested using Fedora 40

* Clone repository or download `Dockerfile`
* Check [Signal-Desktop Repository Releases](https://github.com/signalapp/Signal-Desktop/releases) and select the version you want to build (avoid beta/pre-release).
  * Either choose the git tag, e.g.: `v7.29.0`
  * Or choose the git branch, e.g.: `7.29.x`
* Execute docker build and **update the SIGNAL_BRANCH accordingly to the version you want to build:**

```bash
docker build --build-arg SIGNAL_BRANCH=v7.29.0 --output out .
#or
podman build --build-arg SIGNAL_BRANCH=v7.29.0 --output out --format docker .
```

* Folder `./out` will contain new Signal AppImage.

## FAQ

### How to update to a new version of Signal?

Download or build a later version as you have built the previous version and start the new AppImage.  
Messages are stored in `~/.config/Signal` and won't be lost.

### What if the build fails?

Signal must have changed something breaking in their build requirements (they e.g. removed `yarn` from the project recently).  
I will try to keep this repository updated.

### How long does the build take and why does it take so long?

The build time depends a lot on internet speed and computing resources.  
Signal-Desktop requires many node modules that all have to be downloaded from npm before the build.
Usually the build is done within a few minutes, however, with a slow internet connection and a weak computer it can take up to 20 minutes.

#### Does this build work with Wayland?

The following command worked on my system:  
`./Signal-7.29.0.AppImage --use-tray-icon --no-sandbox %U --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WaylandWindowDecorations`  
Confirmed with `xeyes`.  

I found this solution in this comment: https://github.com/signalapp/Signal-Desktop/issues/3411#issuecomment-1763576244
There you can also find a more detailed description and **possible implications** of these flags.
For me the App seem to be useable, the only two problems I have found are:
* Window resizing does not work (snapping does)
* The app starts minimized (have to click the icon in the taskbar)

There is also a feature request for Signal to support Wayland and additional information: https://community.signalusers.org/t/support-wayland-natively/58021

