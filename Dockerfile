FROM kamax/mxisd:1.2.0
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

COPY docker-entrypoint.sh /

COPY templates /templates


ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/mxisd.jar"]
