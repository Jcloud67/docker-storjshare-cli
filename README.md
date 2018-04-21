The Storj Share Daemon+CLI (https://github.com/Storj/storjshare-daemon).

## Build ##

This image is a dirty fork of the official repo, adding multiple node creation and storjstat.com monitor script.

```bash
docker pull zugz/r8mystorj:latest
```

## Local Build ##

Alternatively, build the container locally:

```bash
cd /path/to/your/buildarea
git clone https://github.com/Jcloud67/docker-storjshare-cli
docker build -t Jcloud67/storjshare-cli:latest docker-storjshare-cli/
```

## Run Daemon ##

Start the daemon by using this command (optional args shown in square brackets with default values):

```bash
docker run --detach \
    --name mystorjdaemon \
    --restart=always \
    -v /path/to/storjdata:/storj \
    -p 4000-4003:4000-4003 \
	-e WALLET_ADDRESS=your_ERC20_wallet_address \
	[-e DAEMONADDRESS=127.0.0.1] \
	[-e DATADIR=/storj] \
	[-e SHARE_SIZE=1TB] \
	[-e RPCADDRESS=0.0.0.0] \
	[-e MONITORKEY= ] \
	[-e NODE_COUNT=0 ] \
	[-e NODE_DIR=Node_ ] \
	[-e USE_HOSTNAME_SUFFIX=FALSE] \
     Jcloud67/storjshare-cli:latest
```

## Status ##

Check the status of the daemon by using this command:

```bash
docker exec mystorjdaemon storjshare status
```

The output should look something like this:

```
┌─────────────────────────────────────────────┬─────────┬──────────┬──────────┬─────────┬───────────────┬─────────┬──────────┬───────────┬──────────────┐
│ Share                                       │ Status  │ Uptime   │ Restarts │ Peers   │ Allocs        │ Delta   │ Port     │ Shared    │ Bridges      │
├─────────────────────────────────────────────┼─────────┼──────────┼──────────┼─────────┼───────────────┼─────────┼──────────┼───────────┼──────────────┤
│ abcdefabcdefabcdefabcdefabcdefabcdefabcd    │ running │ 4d 22h … │ 0        │ 243     │ 30            │ 20ms    │ 1234     │ 15.00MB   │ connected    │
│   → /storj/share                            │         │          │          │         │ 15 received   │         │ (Tunnel) │ (1%)      │              │
└─────────────────────────────────────────────┴─────────┴──────────┴──────────┴─────────┴───────────────┴─────────┴──────────┴───────────┴──────────────┘
```

## StorjMonitor ##
Storjstat.com monitor script is pre-installed, the API-Key can be given at time of container creation using ENV variable MONITORKEY.
API key can be added after creation of the Container using the following commands: (interactively)

```bash
docker exec -ti mystorjdaemon /bin/sh
sed -i "s/YOUR-TOKEN-HERE/MONITOR_KEY/" /StorjMonitor/storjMonitor.js
exit
```


## Stop Daemon ##

Stop the daemon by using these commands:

```bash
docker stop mystorjdaemon
docker rm mystorjdaemon
```

## Versions ##

Check versions for `npm`, `node` and `storjshare` with:

```bash
docker run --rm -ti --entrypoint /versions oreandawe/storjshare-cli:latest
node version:
v6.7.0

npm version:
{ npm: '3.10.3',
  ares: '1.10.1-DEV',
  http_parser: '2.7.0',
  icu: '57.1',
  modules: '48',
  node: '6.7.0',
  openssl: '1.0.2k',
  uv: '1.9.1',
  v8: '5.1.281.83',
  zlib: '1.2.11' }

storjshare version:
daemon: 5.3.0, core: 8.5.0, protocol: 1.2.0
```

Or run an interactive shell:

```bash
docker run --rm -ti --entrypoint /bin/sh oreandawe/storjshare-cli
```

Or connect to an existing container:

```bash
docker exec -ti nameofyourcontainer /bin/sh
```
