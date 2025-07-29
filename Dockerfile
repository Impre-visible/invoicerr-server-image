FROM nginx:bookworm

ENV NODE_VERSION=22.13.1

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    xz-utils \
    --no-install-recommends

RUN curl -fsSLO https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz \
    && tar -xf node-v$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1 \
    && rm node-v$NODE_VERSION-linux-x64.tar.xz

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

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /usr/share/nginx
