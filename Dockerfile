FROM openjdk:8-jre-alpine AS builder

RUN apk update && apk add gradle git && rm -rf /var/lib/apk/* /var/cache/apk/*

RUN git clone -b 2.5.0-eea https://github.com/eea/ma1sd.git /ma1sd \
  && cd /ma1sd \
  && ./gradlew shadowJar

FROM openjdk:8-jre-alpine

RUN apk update && apk add bash && rm -rf /var/lib/apk/* /var/cache/apk/*

VOLUME /var/ma1sd
EXPOSE 8090

ENV JAVA_OPTS=""
ENV CONF_FILE_PATH="/etc/ma1sd/ma1sd.yaml"
ENV SIGN_KEY_PATH="/var/ma1sd/sign.key"
ENV SQLITE_DATABASE_PATH="/var/ma1sd/ma1sd.db"

COPY --from=builder /ma1sd/ma1sd/src/docker/start.sh /start.sh
COPY --from=builder /ma1sd/ma1sd/src/script/ma1sd /app/ma1sd
COPY --from=builder /ma1sd/build/libs/ma1sd.jar /app/ma1sd.jar

LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

COPY docker-entrypoint.sh /

COPY templates /templates

CMD ["/start.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
