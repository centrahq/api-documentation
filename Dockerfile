FROM python:alpine

ARG CLI_VERSION=1.16.86

COPY . /api-docs

WORKDIR /api-docs

RUN apk add --update nodejs nodejs-npm alpine-sdk
RUN apk -uv add --no-cache groff jq less && \
    pip install --no-cache-dir awscli==$CLI_VERSION

CMD sh
