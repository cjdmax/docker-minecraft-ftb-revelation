# based on jaysonsantos/docker-minecraft-ftb-skyfactory3

FROM openjdk:8u212-jre-alpine

MAINTAINER example@example.com

# manual upgrades only chaps
# when you upgrade, you are responsible for removing the duplicate mods from your ./mods folder on your volume.
ENV VERSION=3.2.0

RUN apk update && apk add wget unzip bash
RUN adduser --disabled-password --home=/data --uid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/ftb && cd /tmp/ftb && \
  wget -c https://media.forgecdn.net/files/2778/975/FTBRevelationServer_3.2.0.zip -O revelation.zip && \
	unzip revelation.zip && \
	chown -R minecraft /tmp/ftb && \
	bash /tmp/ftb/FTBInstall.sh

USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD Revelation ${VERSION} RAIL world IV
ENV LEVEL world
ENV JVM_OPTS -Xms4096m -Xmx4096m
ENV FLIGHT true
