#!/bin/bash

set -e

export ROOT_DIR=`pwd`

export TASKS_DIR=$(dirname $BASH_SOURCE)
export PIPELINE_DIR=$(cd $TASKS_DIR/../../ && pwd)
export FUNCTIONS_DIR=$(cd $PIPELINE_DIR/functions && pwd)

source $FUNCTIONS_DIR/create_ansible_cfg.sh
source $FUNCTIONS_DIR/create_hosts.sh
source $FUNCTIONS_DIR/copy_roles.sh

DEBUG=""
if [ "$ENABLE_ANSIBLE_DEBUG" == "true" ]; then
  DEBUG="-vvv"
fi

create_hosts
create_ansible_cfg
copy_roles

cp hosts ansible.cfg skyway-automation/.
cd skyway-automation
# It seems we need at least one value in extra_vars, so put a fake one.
echo "---" > extra_vars.yml
echo "is_dict: True" >> extra_vars.yml

$FUNCTIONS_DIR/generate_vars.py

echo ""
set > my-env
ansible-playbook $DEBUG -i hosts site.yml -e @extra_vars.yml
STATUS=$?

echo ""

exit $STATUS
