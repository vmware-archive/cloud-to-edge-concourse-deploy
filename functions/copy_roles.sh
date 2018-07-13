#!/bin/bash

function check_copy {
  if ! [ -d $2 ]; then
    echo "Copying role $1 into place."
    cp -r ../../$1 $2
  fi
}

function copy_roles {

  # TODO: make this more elegant and wildcard it.
  mkdir -p skyway-automation/roles
  pushd .
  cd skyway-automation/roles
  check_copy ansible-role-azure-iot vmware.azure-iot
  check_copy ansible-role-azure-edge vmware.azure-edge
  check_copy ansible-aws-greengrass/roles/awscli vmware.awscli
  check_copy ansible-aws-greengrass/roles/greengrass-init vmware.greengrass-init
  check_copy ansible-aws-greengrass/roles/greengrass-core vmware.greengrass-core
  check_copy ansible-aws-greengrass/roles/greengrass-deploy vmware.greengrass-deploy
  check_copy ansible-aws-greengrass/roles/greengrass-lambda vmware.greengrass-lambda
  ansible-galaxy install huxoll.azure-cli
  popd
}
