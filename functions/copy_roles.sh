#!/bin/bash

function copy_roles {

  # TODO: make this more elegant and wildcard it.
  mkdir -p skyway-automation/roles
  cp -r ansible-role-azure-iot skyway-automation/roles/azure-iot
  cp -r ansible-role-azure-iot skyway-automation/roles/azure-edge
  cp -r ansible-role-azure-iot skyway-automation/roles/azure-edge
  cp -r ansible-role-azure-iot skyway-automation/roles/azure-edge
  cp -r ansible-aws-greengrass/roles/awscli skyway-automation/roles/awscli
  cp -r ansible-aws-greengrass/roles/greengrass-init skyway-automation/roles/greengrass-init
  cp -r ansible-aws-greengrass/roles/greengrass-core skyway-automation/roles/greengrass-core
  cp -r ansible-aws-greengrass/roles/greengrass-deploy skyway-automation/roles/greengrass-deploy
  cp -r ansible-aws-greengrass/roles/greengrass-lambda skyway-automation/roles/greengrass-lambda

}
