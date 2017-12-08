#!/bin/bash
set -e
if [ -n "$SOLR_PORT" ]; then
  if [ -z "$SOLR_URL" ]; then
    SOLR_URL="http://"$SOLR_PORT_8983_TCP_ADDR":"$SOLR_PORT_8983_TCP_PORT"/solr/blacklight-core"
  else
    echo >&2 '[WARN]: Linked container, "web" overridden by $SOLR_URL.'
    echo >&2 "===> Connecting to WEB_HOST ($SOLR_URL)"
  fi
fi
if [ -z "$SOLR_URL" ]; then
  echo >&2 '[ERROR]: specify a linked container, "web" or SOLR_URL environ-
   ment variable'
  exit 1
fi
exec "$@" # run the default command
