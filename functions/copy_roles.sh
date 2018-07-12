#!/bin/bash

function copy_roles {

  # TODO: make this more elegant and wildcard it.
  mkdir -p skyway-automation/roles
  cp -r ansible-role-azure-iot skyway-automation/roles/vmware.azure-iot
  cp -r ansible-role-azure-edge skyway-automation/roles/vmware.azure-edge
  cp -r ansible-aws-greengrass/roles/awscli skyway-automation/roles/vmware.awscli
  cp -r ansible-aws-greengrass/roles/greengrass-init skyway-automation/roles/vmware.greengrass-init
  cp -r ansible-aws-greengrass/roles/greengrass-core skyway-automation/roles/vmware.greengrass-core
  cp -r ansible-aws-greengrass/roles/greengrass-deploy skyway-automation/roles/vmware.greengrass-deploy
  cp -r ansible-aws-greengrass/roles/greengrass-lambda skyway-automation/roles/vmware.greengrass-lambda
  ansible-galaxy install huxoll.azure-cli
}
