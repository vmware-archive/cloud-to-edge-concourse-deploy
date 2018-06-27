#!/bin/bash

function create_hosts {

cat > hosts <<-EOF
[localhost]
localhost       ansible_connection=local

[localhost:vars]
ovfToolPath='/usr/bin'
skywayOvaPath="$OVA_ISO_PATH"
sshEnabled='True'
allowSSHRootAccess='True'
managerOva=$SKYWAY_MANAGER_OVA
controllerOva=$SKYWAY_CONTROLLER_OVA
edgeOva=$SKYWAY_EDGE_OVA

deployVcIPAddress="$VCENTER_HOST"
deployVcUser=$VCENTER_USR
deployVcPassword="$VCENTER_PWD"
compute_manager="$VCENTER_MANAGER"
cm_cluster="$VCENTER_CLUSTER"

compute_vcenter_host="$COMPUTE_VCENTER_HOST"
compute_vcenter_user="$COMPUTE_VCENTER_USR"
compute_vcenter_password="$COMPUTE_VCENTER_PWD"
compute_vcenter_cluster="$COMPUTE_VCENTER_CLUSTER"
compute_vcenter_manager="$COMPUTE_VCENTER_MANAGER"

skywayInstaller="$SKYWAY_INSTALLER"
skywayAdminPass="$SKYWAY_MANAGER_ADMIN_PWD"
skywayCliPass="$SKYWAY_MANAGER_ROOT_PWD"

dns_server="$DNSSERVER"
dns_domain="$DNSDOMAIN"
ntp_server="$NTPSERVERS"

EOF

}
