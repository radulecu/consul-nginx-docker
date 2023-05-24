FROM nginx:latest

# Tell apt-get we're never going to be able to give manual feedback
RUN export DEBIAN_FRONTEND=noninteractive

# Download latest listing of available packages
RUN apt-get -y update

# Upgrade already installed packages
RUN apt-get -y upgrade

# Install wget
RUN apt install -y wget

# Install unzip
RUN apt install -y unzip

# Download consul-template
RUN wget https://releases.hashicorp.com/consul-template/0.25.1/consul-template_0.25.1_linux_amd64.zip -P /tmp

# Install consul-template
RUN unzip /tmp/consul-template_0.25.1_linux_amd64.zip -d /tmp && mv /tmp/consul-template /usr/local/bin/consul-template

# Download consul-agent
RUN wget https://releases.hashicorp.com/consul/1.8.5/consul_1.8.5_linux_amd64.zip -P /tmp

# Install consul-agent
RUN unzip /tmp/consul_1.8.5_linux_amd64.zip -d /tmp && mv /tmp/consul /usr/local/bin/consul
# Start nginx
CMD service nginx start ; while true ; do sleep 100; done;