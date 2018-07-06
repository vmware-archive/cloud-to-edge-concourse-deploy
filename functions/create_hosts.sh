#!/bin/bash

function create_hosts {

cat > hosts <<-EOF
[azure-driver]
localhost       ansible_connection=local

[greengrass-driver]
localhost       ansible_connection=local

[iot-driver]
localhost       ansible_connection=local

[iot-driver:vars]
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
azure_cli_application_id="$azure_cli_application_id"
azure_cli_application_key="$azure_cli_application_key"
azure_cli_tenant_id="$azure_cli_tenant_id"
azure_iot_hub_name="$azure_iot_hub_name"
azure_iot_group="$azure_iot_group"
aws_access_key_id="$aws_access_key_id"
aws_secret_access_key="$aws_secret_access_key"
greengrass_s3_bucket="$greengrass_s3_bucket"
greengrass_group_names="$greengrass_group_names"
greengrass_device_stub="$greengrass_device_stub"
greengrass_device_count="$greengrass_device_count"
greengrass_deploy="$greengrass_deploy"

EOF

}
