FROM debian:bullseye-slim
RUN apt update
RUN apt install -y xinetd curl
RUN curl https://raw.githubusercontent.com/tribe29/checkmk/master/agents/cfg_examples/xinetd.conf > /etc/xinetd.d/check_mk
RUN curl https://raw.githubusercontent.com/tribe29/checkmk/master/agents/check_mk_agent.linux > /usr/bin/check_mk_agent
RUN chmod +x /etc/xinetd.d/check_mk /usr/bin/check_mk_agent
EXPOSE 6556
CMD (/etc/init.d/xinetd start && sleep infinity)