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

root@2967e06d8e2f:/ check_mk_agent | head
<<<check_mk>>>
Version: 2.1.0i1
AgentOS: linux
Hostname: 2967e06d8e2f
AgentDirectory: /etc/check_mk
DataDirectory: /var/lib/check_mk_agent
SpoolDirectory: /var/lib/check_mk_agent/spool
PluginsDirectory: /usr/lib/check_mk_agent/plugins
LocalDirectory: /usr/lib/check_mk_agent/local
AgentController: 
root@2967e06d8e2f:/# 

```


## Customisation
### xinetd config
The original file is here: https://raw.githubusercontent.com/tribe29/checkmk/master/agents/cfg_examples/xinetd.conf

1. Update the file in ./files/xinitd.d/check-mk-agent with your preferences
2. Run docker build to include the updated file in your container

## Plugins
1. Make a folder called `plugins`
2. Put the plugin scripts in the folder
3. Use `-v ./plugins:/usr/lib/check_mk_agent/plugins:ro` in the run command


## Information about the linux agent
https://docs.checkmk.com/latest/en/agent_linux.html


## ToDo

- [ ] Configure the Agent with Docker
- [ ] Create a way to use the agent from the agent bakery