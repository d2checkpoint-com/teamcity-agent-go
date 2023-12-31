FROM jetbrains/teamcity-agent:2023.05.4-linux-sudo
ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt update \
    && apt install software-properties-common -y

RUN apt update \ 
    && add-apt-repository ppa:longsleep/golang-backports \
    && apt update \
    && apt install golang-go git -y 

USER buildagent