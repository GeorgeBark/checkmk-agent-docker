# Deploy checkmk Agent with Docker

Building on the work of https://gitlab.com/BobyMCbobs/container-images/-/tree/master/checkmk-agent.

## Building
```bash
docker build -t checkmk-agent:latest .
```

## Running
```bash
# backgrounding it
docker run -d --privileged -p 6556:6556 --name checkmk-agent checkmk-agent:latest

# debugging
docker run -it --rm --privileged -p 6556:6556 --name checkmk-agent checkmk-agent:latest bash
```

## Customisation
### xinetd config
1. Download [this template](https://raw.githubusercontent.com/tribe29/checkmk/master/agents/cfg_examples/xinetd.conf) to customise the service
2. Update the line `#only_from`, removing the hash and address the server address for the checkmk server you want this to only talk to
3. Use `-v ./custom_xinetd.conf:/etc/xinetd.d/check_mk:ro` in the run command to use your custom config

## Plugins
1. Make a folder called `plugins`
2. Put the plugin scripts in the folder
3. Use `-v ./plugins:/usr/lib/check_mk_agent/plugins:ro` in the run command
