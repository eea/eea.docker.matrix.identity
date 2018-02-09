#!/usr/bin/env bash

if [ "$1" == "/mxisd.jar" ]; then
  if [[ -n "$CONF_FILE_PATH" ]] && [ ! -f "$CONF_FILE_PATH" ]; then
      echo "Generating config file $CONF_FILE_PATH"
      touch "CONF_FILE_PATH"

      if [[ -n "$MATRIX_DOMAIN" ]]; then
          echo "Setting matrix domain to $MATRIX_DOMAIN"
          echo "matrix.domain: $MATRIX_DOMAIN
dns.overwrite.homeserver.client:
  - name: '$MATRIX_DOMAIN'
    value: 'http://matrix:8008' " >> "$CONF_FILE_PATH"
      fi

      if [[ -n "$SIGN_KEY_PATH" ]]; then
          echo "Setting signing key path to $SIGN_KEY_PATH"
          echo "key.path: $SIGN_KEY_PATH" >> "$CONF_FILE_PATH"
      fi

      if [[ -n "$SQLITE_DATABASE_PATH" ]]; then
          echo "Setting SQLite DB path to $SQLITE_DATABASE_PATH"
          echo "storage.provider.sqlite.database: $SQLITE_DATABASE_PATH" >> "$CONF_FILE_PATH"
      fi


      if [[ -n "${LDAP_HOST}" ]]; then
          echo "Setting LDAP"
          echo "ldap.enabled: true
ldap.connection.host: '${LDAP_HOST}'
ldap.connection.bindDn: '${LDAP_BINDDN}'
ldap.connection.bindPassword: '${LDAP_BINDDN_PASS}'
ldap.connection.baseDn: '${LDAP_BASEDN}'
ldap.connection.tls: '${LDAP_TLS}'
ldap.connection.port: '${LDAP_PORT}'
ldap.attribute.uid.type: 'uid'
ldap.attribute.uid.value: 'uid'
ldap.attribute.name: 'cn' "  >> "$CONF_FILE_PATH"

           if [[ -n "$LDAP_FILTER" ]]; then
               echo "ldap.filter: '($LDAP_FILTER)'" >> "$CONF_FILE_PATH"
           fi
      fi

      echo "Starting mxisd..."
      echo
  fi

  exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -Dspring.config.location=/etc/mxisd/ -Dspring.config.name=mxisd -jar /mxisd.jar
fi

exec "$@"
