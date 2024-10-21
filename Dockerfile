# Execute using:
## docker build --build-arg SIGNAL_BRANCH=v7.29.0 --output out .
## podman build --build-arg SIGNAL_BRANCH=v7.29.0 --output out --format docker .          # "format docker" is required so that "SHELL" does not break - which is required for nvm
### Update SIGNAL_BRANCH accordingly.


FROM debian:12 AS builder

# Specify Branch or Tag. Find the version you want to build here: https://github.com/signalapp/Signal-Desktop
ARG SIGNAL_BRANCH

# Break if SIGNAL_BRANCH is not set.
RUN test -n "$SIGNAL_BRANCH" || (echo "SIGNAL_BRANCH  not set. Specify \"--build-arg SIGNAL_BRANCH=[SignalApp Branch or Tag]\"" && false)

# Install build dependencies
RUN apt update && apt upgrade -y && apt install -y build-essential curl git-lfs python3

# Required for nvm to work
ARG DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-l", "-c"]

# Install and source nvm
ENV NVM_DIR /usr/local/nvm
RUN mkdir -p "$NVM_DIR"; \
    curl -o- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" | \
        bash \
    ; \
    source $NVM_DIR/nvm.sh;

# Clone official SignalApp branch/tag
RUN mkdir /app && git clone --depth 1 -b "${SIGNAL_BRANCH}" --single-branch https://github.com/signalapp/Signal-Desktop.git /app/Signal-Desktop

WORKDIR /app/Signal-Desktop

# Install node version from .nvmrc
RUN nvm install $(cat .nvmrc)

RUN npm install

# Replace package.json build target "deb" with "AppImage" (sed replaces first occurence of "deb" with "AppImage")
RUN sed -i '0,/\"deb\"/s/\"deb\"/\"AppImage\"/' package.json

RUN npm run build-release

# Move built Signal AppImage to host's "out" dir
FROM scratch AS export
COPY --from=builder /app/Signal-Desktop/release/Signal* .
