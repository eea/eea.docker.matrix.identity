FROM kamax/mxisd:1.4.6
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"

COPY docker-entrypoint.sh /

COPY templates /templates

CMD ["/start.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
