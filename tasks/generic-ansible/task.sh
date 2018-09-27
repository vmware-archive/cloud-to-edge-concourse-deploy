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
  DEBUG="-vv"
fi

create_hosts
copy_roles

cp hosts automation/.
cd automation
# It seems we need at least one value in extra_vars, so put a fake one.
echo "---" > extra_vars.yml
echo "is_dict: True" >> extra_vars.yml

$FUNCTIONS_DIR/create_ansible_cfg.py $@
$FUNCTIONS_DIR/generate_vars.py $@
$FUNCTIONS_DIR/generate_playbook.py $@

echo ""
set > my-env
echo "Args: $@" > my-args
echo "ansible-playbook $DEBUG -i hosts task-playbook.yml -e @extra_vars.yml"
start=`date +%s`
ansible-playbook $DEBUG -i hosts task-playbook.yml -e @extra_vars.yml
STATUS=$?
end=`date +%s`

echo "Finished in $((($(date +%s)-$start)/60)) minutes."
echo ""

if [ -d ../scratch-out ]; then
  cd ..
  git --version || (apt-get update -qq && apt-get install -y git)
  git clone scratch scratch-out
  cp automation/my-env scratch-out/task-env
  cp automation/my-args scratch-out/task-args
  cd scratch-out
  echo "Finished in $((($(date +%s)-$start)/60)) minutes." >> timings
  git add .
  git commit -m "Task completed."
fi

exit $STATUS
