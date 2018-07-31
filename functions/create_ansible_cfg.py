#!/usr/bin/env python2.7

import sys, os
import re
import argparse

ansible_cfg = "ansible.cfg"
hosts = []

def generate_ansible_cfg(args=None):
    ansible_cfg_file = open(ansible_cfg, "w")
    # Create a minimal valid ansible_cfg, even with no arguments.
    ansible_cfg_file.write("[defaults]\n")
    ansible_cfg_file.write("host_key_checking = false\n")
    try:
        if (os.environ['ENABLE_ANSIBLE_DEBUG'] in ['true', 'True', 'yes', '1']):
            # Add callbacks to enable timing output.
            ansible_cfg_file.write("callback_whitelist = timer, profile_tasks\n")
    except KeyError:
        pass
    ansible_cfg_file.close()

if __name__ == '__main__':
    generate_ansible_cfg()
