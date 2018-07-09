#!/bin/bash

echo
echo "Setting up user $user at host $ip to connect to Gitlab"

if [ -n "$GITLAB_SSH_KEY" ] && ! [ -f "$HOME/.ssh/id_rsa_gitlab" ]; then
  echo "Expect a value for GITLAB_SSH_KEY or a key to exist at \
  ~/.ssh/id_rsa_gitlab that can connect to gitlab."
  exit 1
fi
if [ -f "$HOME/.ssh/id_rsa_gitlab" ]; then
  echo "Using key file ~/.ssh/id_rsa_gitlab for gitlab access."
  KEY_FILE_CONTENTS=$(cat $HOME/.ssh/id_rsa_gitlab)
fi
: ${GITLAB_SSH_KEY:=$KEY_FILE_CONTENTS}

read -r -d '' ssh_commands <<EOC
echo "${GITLAB_SSH_KEY}" > ~/.ssh/id_rsa_gitlab
chmod go-rwx ~/.ssh/id_rsa_gitlab
touch ~/.ssh/config
sed -i.bak '/### bootstrap start ###/,/### bootstrap end ###/d' ~/.ssh/config
echo "### bootstrap start ###" >> ~/.ssh/config
echo "Host gitlab.eng.vmware.com" >> ~/.ssh/config
echo "StrictHostKeyChecking no" >> ~/.ssh/config
echo "IdentityFile ~/.ssh/id_rsa_gitlab" >> ~/.ssh/config
echo "### bootstrap end ###" >> ~/.ssh/config
EOC

ssh -T "${opts[@]}" ${user}@$ip "$"
