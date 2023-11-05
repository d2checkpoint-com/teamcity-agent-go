FROM jetbrains/teamcity-minimal-agent:2023.05.4

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt update \
    && apt install software-properties-common -y

RUN apt update \ 
    && add-apt-repository ppa:longsleep/golang-backports \
    && apt update \
    && apt install golang-go git ca-certificates curl gnupg -y 

RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt update \
    && apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

RUN usermod -aG docker buildagent

USER buildagent