#!/bin/bash

function create_hosts {

cat > hosts <<-EOF
[azure-driver]
localhost       ansible_connection=local

[greengrass-driver]
localhost       ansible_connection=local

[iot-driver]
localhost       ansible_connection=local
EOF

}
