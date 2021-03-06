FROM node:16-alpine3 AS frontend
WORKDIR /build

# yarn install dependencies
COPY package.json yarn.lock ./
RUN yarn install

# yarn run prod dependencies
COPY .sassrc postcss.config.js tailwind.config.js webpack.mix.js .
COPY src/js src/js
COPY src/css src/css
COPY src/pages src/pages
RUN yarn run production-build

FROM crystallang/crystal:1.3-alpine-build

RUN apk add cmake

WORKDIR /build

# shards dependencies
COPY shard.yml shard.lock ./
ENV SKIP_LUCKY_TASK_PRECOMPILATION 1
RUN shards install # --production

ENV DATABASE_URL postgresql://host.docker.internal/production
ENV REDIS_URL redis://host.docker.internal:6379
ENV LUCKY_ENV production
ENV SECRET_KEY_BASE 00000000000000000000000000000000
ENV PORT 3001
ENV SEND_GRID_KEY unused
ENV HOST 0.0.0.0
ENV FORCE_SSL true
ENV APP_DOMAIN http://localhost:3001

# Top level app files
COPY tasks.cr ./

# Top level app folders
COPY config ./config
COPY db ./db
COPY spec ./spec
COPY src ./src
COPY tasks ./tasks

# copy front end assets
COPY public/assets ./public/assets/
COPY public/robots.txt public/favicon.ico public/

# assume the assets have already been generated
# COPY public public/
COPY --from=frontend /build/public public/

RUN shards build #--release

# setup for execution
COPY script/docker/entrypoint /usr/local/bin/

# move everything into it's final place
WORKDIR /app
COPY BUILD_DETAILS .
RUN cp -r /build/bin .
RUN cp -r /build/db .
RUN cp -r /build/public .

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD []
