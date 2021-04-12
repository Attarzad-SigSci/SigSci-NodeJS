# Dockerfile example for debian Signal Sciences agent container
FROM ubuntu:xenial

COPY sigsci-release.list /etc/apt/sources.list.d/sigsci-release.list
RUN  apt-get update; apt-get install -y apt-transport-https curl ca-certificates
RUN curl -slL https://apt.signalsciences.net/gpg.key | apt-key add -; apt-get update; apt-get install -y sigsci-agent;  apt-get clean
RUN apt-get install -y nodejs npm
CMD mkdir app
RUN npm install https://dl.signalsciences.net/sigsci-module-nodejs/sigsci-module-nodejs_latest.tgz
RUN npm install -g express-generator
COPY app/app.js /app/app.js
COPY app/package.json /app/package.json
COPY agent.conf /etc/sigsci/agent.conf

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
ENTRYPOINT ["/app/start.sh"]

