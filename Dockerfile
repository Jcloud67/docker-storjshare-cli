FROM gliderlabs/alpine:3.4
RUN apk add --no-cache nodejs

RUN \
        apk add --no-cache g++ gcc git make bash python && \
        export MAKEFLAGS=-j8 && \
        npm install -g storjshare-daemon && \
        git clone https://github.com/calxibe/StorjMonitor.git && \
        chmod +x /StorjMonitor/storjMonitor-install.sh && \
        cd /StorjMonitor && \
        /StorjMonitor/storjMonitor-install.sh && \
        npm cache clear --force && \
        apk del --no-cache g++ gcc git make bash python

ENV USE_HOSTNAME_SUFFIX=FALSE
ENV DATADIR=/storj
ENV WALLET_ADDRESS=
ENV MONITORKEY=
ENV NODE_COUNT=0
ENV NODE_DIR=Node_
ENV SHARE_SIZE=1TB
ENV RPCADDRESS=0.0.0.0
ENV DAEMONADDRESS=127.0.0.1
EXPOSE 4000-4003/tcp

ADD versions entrypoint /
ENTRYPOINT ["/entrypoint"]

RUN chmod a+rx /entrypoint
