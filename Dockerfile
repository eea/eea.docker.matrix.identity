FROM kamax/mxisd:0.6.1-1-g6a5a4b3

COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh"]

#ENV JAVA_OPTS




