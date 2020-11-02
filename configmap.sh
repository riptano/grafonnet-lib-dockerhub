#!/bin/sh

file=$1

name=$(basename $file .jsonnet)

jsonnet --ext-str prefix=cndb /here/$file > /tmp/tmp.json
jsonnet --ext-str name=$name --ext-str-file dashboard=/tmp/tmp.json configmap.jsonnet | gojsontoyaml

