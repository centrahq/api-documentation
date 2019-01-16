FROM python:alpine

ARG CLI_VERSION=1.16.86

ADD ./ /api-docs

WORKDIR /api-docs

RUN apk add --update nodejs nodejs-npm alpine-sdk
RUN apk -uv add --no-cache groff jq less

CMD sh
