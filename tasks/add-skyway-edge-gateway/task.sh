#!/bin/bash

set -e

export ROOT_DIR=`pwd`

export TASKS_DIR=$(dirname $BASH_SOURCE)
export PIPELINE_DIR=$(cd $TASKS_DIR/../../ && pwd)
export FUNCTIONS_DIR=$(cd $PIPELINE_DIR/functions && pwd)

source $FUNCTIONS_DIR/create_ansible_cfg.sh
source $FUNCTIONS_DIR/create_hosts.sh

DEBUG=""
if [ "$ENABLE_ANSIBLE_DEBUG" == "true" ]; then
  DEBUG="-vvv"
fi

create_hosts
create_ansible_cfg

cp hosts ansible.cfg skyway-automation/.
cd skyway-automation
echo "---" > extra_vars.yml

echo ""

ansible-playbook $DEBUG -i hosts site.yml -e @extra_vars.yml
STATUS=$?

echo ""

exit $STATUS
