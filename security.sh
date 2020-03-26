#!/bin/bash

for i in {1..30}
do
    sleep 1

    CLUSTER_STATUS=`curl -k -s https://admin:admin@elasticsearch:9200/_cluster/health | jq -r .status`
    CLUSTER_NUMBER_OF_NODES=`curl -k -s https://admin:admin@elasticsearch:9200/_cluster/health | jq -r .number_of_nodes`

    if [ "$CLUSTER_STATUS" == "green" ]; then
        cd /usr/share/elasticsearch/plugins/opendistro_security/tools/
        chmod +x securityadmin.sh
        ./securityadmin.sh -cd ../securityconfig/ -icl -nhnv -cacert ../../../config/root-ca.pem -cert ../../../config/admin.pem -key ../../../config/admin-key.pem
        exit 0
    fi
done
