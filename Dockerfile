FROM node:12-alpine

RUN set -ex; \
    adduser -D -u 9999 codewarrior; \
    mkdir /workspace; \
    chown codewarrior:codewarrior /workspace;

ENV NPM_CONFIG_LOGLEVEL=warn
COPY --chown=codewarrior:codewarrior package.json /workspace/package.json
COPY --chown=codewarrior:codewarrior package-lock.json /workspace/package-lock.json

RUN set -ex; \
    apk add --no-cache --virtual .build-deps \
# su-exec makes running commands as a different user easy
        su-exec \
        bash \
        build-base \
        git \
        python \
    ; \
    cd /workspace; \
    su-exec codewarrior npm install; \
    apk del --purge .build-deps; \
    rm -rf /var/cache/apk/* /tmp/* /home/codewarrior/.npm;

USER codewarrior
COPY --chown=codewarrior:codewarrior . /workspace
WORKDIR /workspace
ENV NODE_ENV=production
RUN set -ex; \
    npx hardhat compile; \
    npx hardhat test; \
    rm contracts/*.sol; \
    rm test/*.js;
