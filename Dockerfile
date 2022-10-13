FROM debian:bullseye-slim
RUN apt update
RUN apt install -y xinetd curl nano python python3-pip dos2unix
RUN pip uninstall docker-py docker
RUN pip install docker
RUN curl -fsSL https://get.docker.com/ | sh
COPY ./plugins/mk_docker.py /usr/lib/check_mk_agent/plugins/mk_docker.py
RUN dos2unix /usr/lib/check_mk_agent/plugins/mk_docker.py
RUN chmod +x /usr/lib/check_mk_agent/plugins/mk_docker.py
COPY ./files/xinetd.d/check-mk-agent /etc/xinetd.d/check-mk-agent
#RUN curl https://raw.githubusercontent.com/tribe29/checkmk/master/agents/cfg_examples/xinetd.conf > /etc/xinetd.d/check_mk
COPY ./files/check_mk_agent /usr/bin/check_mk_agent
#RUN curl https://raw.githubusercontent.com/tribe29/checkmk/master/agents/check_mk_agent.linux > /usr/bin/check_mk_agent
RUN chmod +x /usr/bin/check_mk_agent
EXPOSE 6556
CMD (/etc/init.d/xinetd start && sleep infinity)