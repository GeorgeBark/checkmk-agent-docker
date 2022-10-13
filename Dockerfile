FROM debian:bullseye-slim
RUN apt update
RUN apt install -y xinetd curl nano
RUN curl -sSL https://get.docker.com/ | sh
COPY ./plugins /usr/lib/check_mk_agent/plugins
RUN pip uninstall docker-py docker
RUN pip install docker
COPY ./files/xinetd.d/check-mk-agent /etc/xinetd.d/check-mk-agent
#RUN curl https://raw.githubusercontent.com/tribe29/checkmk/master/agents/cfg_examples/xinetd.conf > /etc/xinetd.d/check_mk
COPY ./files/check_mk_agent /usr/bin/check_mk_agent
#RUN curl https://raw.githubusercontent.com/tribe29/checkmk/master/agents/check_mk_agent.linux > /usr/bin/check_mk_agent
RUN chmod +x /usr/bin/check_mk_agent
EXPOSE 6556
CMD (/etc/init.d/xinetd start && sleep infinity)