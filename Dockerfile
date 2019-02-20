FROM kamax/mxisd:latest-dev
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

COPY docker-entrypoint.sh /

COPY templates /templates

CMD ["/start.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
