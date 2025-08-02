FROM nginx:bookworm

ENV NODE_VERSION=22.13.1

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    xz-utils \
    --no-install-recommends

RUN ARCH="$(uname -m)" && \
    case "$ARCH" in \
    x86_64) NODE_ARCH="x64";; \
    aarch64) NODE_ARCH="arm64";; \
    *) echo "Unsupported architecture: $ARCH"; exit 1;; \
    esac && \
    curl -fsSLO https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$NODE_ARCH.tar.xz && \
    tar -xf node-v$NODE_VERSION-linux-$NODE_ARCH.tar.xz -C /usr/local --strip-components=1 && \
    rm node-v$NODE_VERSION-linux-$NODE_ARCH.tar.xz


RUN apt-get install -y \
    chromium \
    libnss3 \
    libfreetype6 \
    libharfbuzz0b \
    fonts-freefont-ttf \
    chromium-driver \
    bash \
    netcat-traditional \
    dumb-init

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /usr/share/nginx
