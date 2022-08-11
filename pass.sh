#!/bin/sh
export ES_PASSWORD=$(kubectl -n elastic-system get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
echo $ES_PASSWORD
