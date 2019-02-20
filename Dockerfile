FROM kamax/mxisd:1.3.1
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

COPY docker-entrypoint.sh /

COPY templates /templates


ENTRYPOINT ["/docker-entrypoint.sh"]
