# Docker image for MXISD  Federated Matrix Identity Server

Docker image for https://github.com/kamax-io/mxisd with added EEA LDAP configurations.


## Supported tags and respective Dockerfile links

 - [Tags](https://hub.docker.com/r/eeacms/matrix-mxisd/tags/)


## Base docker image

 - [eeacms/matrix-mxisd](https://hub.docker.com/r/eeacms/matrix-mxisd/)


## Source code

 - [github.com](http://github.com/eea/eea.docker.matrix.mxisd)


## Usage

Example docker-compose:

```
  identity:
    image: eeacms/matrix-mxisd
    restart: always
    volumes:
      - ./data/mxisd/etc:/etc/mxisd
      - ./data/mxisd/var:/var/mxisd
    ports:
      - 18290:8090
    environment:
      MATRIX_DOMAIN: public-url
      LDAP_HOST: host
      LDAP_BINDDN: ddn
      LDAP_BINDDN_PASS: pass
      LDAP_BASEDN: basedn
      LDAP_PORT: port
      LDAP_TLS: 'true'
```


## Supported environment variables

* `MATRIX_DOMAIN` - The public url of matrix, used in federation and under which every user is saved
* `LDAP_HOST` - LDAP  hostname/ip
* `LDAP_PORT` - LDAP port
* `LDAP_TLS` - true/false
* `LDAP_BINDDN` - The DN for the user to read from LDAP ( must have access to emails)
* `LDAP_BINDDN_PASS` - The password for the user to read from LDAP
* `LDAP_FILTER` - Filter for LDAP users
* `LDAP_BASEDN` - LDAP BASE DN to give access to users
* `JAVA_OPTS` - Extra Java OPTS


## Copyright and license

The Initial Owner of the Original Code is European Environment Agency (EEA).
All Rights Reserved.

The Original Code is free software;
you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later
version.


## Funding

[European Environment Agency (EU)](http://eea.europa.eu)
