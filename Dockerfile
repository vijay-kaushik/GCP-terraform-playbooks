FROM debian:latest

RUN apt-get update && apt-get install -y git

RUN apt install wget

RUN apt-get install -y gnupg software-properties-common

RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
 tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

RUN gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
tee /etc/apt/sources.list.d/hashicorp.list

RUN apt update

RUN apt-get install terraform

ENV PATH=$PATH:/usr/bin/terraform
ENV PATH=$PATH:/usr/bin/git