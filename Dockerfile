FROM node:12-buster-slim

RUN set -ex; \
    useradd -m codewarrior; \
    mkdir /workspace; \
    chown codewarrior:codewarrior /workspace;

ENV NPM_CONFIG_LOGLEVEL=warn
COPY --chown=codewarrior:codewarrior package.json /workspace/package.json
COPY --chown=codewarrior:codewarrior package-lock.json /workspace/package-lock.json

RUN set -ex; \
   build_deps='ca-certificates git'; \
   apt-get update; \
   apt-get install -y --no-install-recommends $build_deps; \
    cd /workspace; \
    su -c "npm install" codewarrior; \
    rm -rf /var/lib/apt/lists/* /tmp/* /home/codewarrior/.npm;

USER codewarrior
COPY --chown=codewarrior:codewarrior . /workspace
WORKDIR /workspace
ENV NODE_ENV=production
RUN set -ex; \
    npx hardhat compile; \
    npx hardhat test; \
    rm contracts/*.sol; \
    rm test/*.js;
