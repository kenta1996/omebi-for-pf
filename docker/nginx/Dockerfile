FROM node:16 as node-build

COPY ./src /application
WORKDIR /application

# RUN apt-get update \
# 		&& npm install \
# 		&& npm run prod

FROM nginx:1.19.2

WORKDIR /application

RUN apt-get update

# install Node.js
COPY --from=node-build /usr/local/bin /usr/local/bin
COPY --from=node-build /usr/local/lib /usr/local/lib
COPY ./docker/nginx/ecs/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=node-build /application/public /application/public/

# COPY ./src/package*.json /application/
COPY ./src/public /application/public

EXPOSE 80