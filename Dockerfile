ARG NGINX_VERSION=1.27

# Stage 1 -- install dev tools and build bundle
FROM node:22-bookworm-slim AS build
WORKDIR /build

# RUN apt-get update && apt-get install -y --no-install-recommends \
#   git \
#   ca-certificates \
#   && rm -rf /var/lib/apt/lists/*

# install dependencies & copy config files
COPY .npmrc *.json ./
RUN npm ci

COPY . ./
RUN npm run build

# Stage 2 -- serve static build with nginx
FROM nginxinc/nginx-unprivileged:${NGINX_VERSION}

ARG VERSION=latest

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build --link /build/assets/ /var/www/html/theme/${VERSION}/assets/
