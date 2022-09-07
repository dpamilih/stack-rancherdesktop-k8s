#!/bin/sh
export ES_PASSWORD=$(kubectl -n cluster1 get secret es-cluster1-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
echo $ES_PASSWORD
