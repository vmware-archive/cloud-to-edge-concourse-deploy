#!/bin/bash

function check_copy {
  if ! [ -d $2 ]; then
    if [ -d ../../$1 ]; then
      echo "Copying role $1 into place."
      cp -r ../../$1 $2
    fi
  fi
}

function copy_roles {

  # TODO: make this more elegant and wildcard it.
  mkdir -p automation/roles
  pushd .
  cd automation/roles
  check_copy azure-iot vmware.azure-iot
  check_copy azure-edge vmware.azure-edge
  check_copy edge-vm vmware.edge-vm
  check_copy aws-greengrass/roles/awscli vmware.awscli
  check_copy aws-greengrass/roles/greengrass-init vmware.greengrass-init
  check_copy aws-greengrass/roles/greengrass-core vmware.greengrass-core
  check_copy aws-greengrass/roles/greengrass-deploy vmware.greengrass-deploy
  check_copy aws-greengrass/roles/greengrass-lambda vmware.greengrass-lambda
  cd ..
  [ -f requirements.yml ] && ansible-galaxy install -r requirements.yml
  popd
}
