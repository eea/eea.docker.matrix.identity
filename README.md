# Docker image for MXISD  Federated Matrix Identity Server


Docker image for https://github.com/kamax-io/mxisd with added EEA LDAP configurations. 


## Supported tags and respective `Dockerfile` links

- [`latest` (*Dockerfile*)](https://github.com/eea/eea.docker.matrix.mxisd/blob/master/Dockerfile)
- [`0.6.1-1-g6a5a4b3` (*Dockerfile*)](https://github.com/eea/eea.docker.matrix.mxisd/blob/0.6.1-1-g6a5a4b3/Dockerfile)

## Variables

1. MATRIX_DOMAIN: The public url of matrix, used in federation and under which every user is saved
2. LDAP_HOST: LDAP  hostname/ip
7. LDAP_PORT:  LDAP port
3. LDAP_TLS:  true/false
3. LDAP_BINDDN: The DN for the user to read from LDAP ( must have access to emails)
4. LDAP_BINDDN_PASS: The password for the user to read from LDAP
5. LDAP_FILTER: Filter for LDAP users
6. LDAP_BASEDN:  LDAP BASE DN to give access to users
7. JAVA_OPTS: Extra Java OPTS
      
      
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


