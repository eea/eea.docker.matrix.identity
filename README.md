

Docker image based on https://github.com/kamax-io/mxisd with eea configuration


Example docker-compose:
```

  identity:
    image: mxisd2
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


