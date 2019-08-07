#!/usr/bin/env bash

if [ "$1" == "/start.sh" ]; then
  if [[ -n "$CONF_FILE_PATH" ]] ; then
      echo "Generating config file $CONF_FILE_PATH"
      touch "CONF_FILE_PATH"

      if [[ -n "$MATRIX_DOMAIN" ]]; then
          echo "Setting matrix domain to $MATRIX_DOMAIN"
          echo "matrix:" >> "$CONF_FILE_PATH"
          echo "  domain: '$MATRIX_DOMAIN'" >> "$CONF_FILE_PATH"
          if  [[ -n "${HOMESERVER_MXISD_TOKEN}" ]]; then
          
echo "
appsvc:
  enabled: true
  endpoint:
    toHS:
      url: 'http://matrix:8008'
      token: '${HOMESERVER_MXISD_AS_TOKEN}'
    toAS:
      url: 'http://identity:8090'
      token: '${HOMESERVER_MXISD_TOKEN}'" >> "$CONF_FILE_PATH"
	  fi
          echo "
dns:
  overwrite:
    homeserver:
      client:
        - name: '$MATRIX_DOMAIN'
          value: 'http://matrix:8008' " >> "$CONF_FILE_PATH"
      fi

      if [[ -n "$SIGN_KEY_PATH" ]]; then
          echo "Setting signing key path to $SIGN_KEY_PATH"
          echo "key:
  path: $SIGN_KEY_PATH" >> "$CONF_FILE_PATH"
      fi
      touch $SIGN_KEY_PATH
      if [[ -n "$SQLITE_DATABASE_PATH" ]]; then
          echo "Setting SQLite DB path to $SQLITE_DATABASE_PATH"
          echo "storage:
  provider:
    sqlite:
      database: $SQLITE_DATABASE_PATH" >> "$CONF_FILE_PATH"
      fi


      if [[ -n "${LDAP_HOST}" ]]; then
          echo "Setting LDAP"
          echo "ldap:
  enabled: true
  connection:
    host: '${LDAP_HOST}'
    bindDn: '${LDAP_BINDDN}'
    bindPassword: '${LDAP_BINDDN_PASS}'
    baseDn: '${LDAP_BASEDN}'
    tls: '${LDAP_TLS}'
    port: '${LDAP_PORT}'
  attribute:
    uid:
      type: 'uid'
      value: 'uid'
    name: 'cn' "  >> "$CONF_FILE_PATH"

           if [[ -n "$LDAP_FILTER" ]]; then
               echo "ldap:
  filter: '($LDAP_FILTER)'" >> "$CONF_FILE_PATH"
           fi
      fi

      if  [[ -n "${SMTP_HOST}" ]]; then
          echo "threepid:
  medium:
    email:
      identity:
        from: '${IDENTITY_EMAIL_FROM}'
        name: '${IDENTITY_EMAIL_NAME}'
      connectors:
        smtp:
          host: '${SMTP_HOST}'
          port: ${SMTP_PORT}
          tls: 1
      generators:
        template:
          generic:
            matrixId:  '/etc/mxisd/mxid-template.eml'"  >> "$CONF_FILE_PATH"
      fi     

     if  [[ -n "${HOMESERVER_MXISD_TOKEN}" ]]; then
          echo "
synapseSql:
  enabled: false ## Do not use this line if Synapse is used as an Identity Store
  type: 'postgresql'
  connection: '//db/${POSTGRES_DBNAME}?user=${POSTGRES_DBUSER}&password=${POSTGRES_DBPASS}'" >> "$CONF_FILE_PATH"
      fi

      if [[ -n "${MXISD_RIOT_URL}" ]]; then
	      sed "s#MXISD_RIOT_URL#$MXISD_RIOT_URL#g" /templates/mxid-template.eml > /etc/mxisd/mxid-template.eml
      fi

      echo "Starting mxisd..."
      echo
  fi

  cat "$CONF_FILE_PATH"

  exec java $JAVA_OPTS -jar /app/mxisd.jar  -c "$CONF_FILE_PATH"

fi

exec "$@"
