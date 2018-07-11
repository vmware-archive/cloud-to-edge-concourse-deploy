#!/usr/bin/env python2.7

import sys, os
import re

playbook = "task-playbook.yml"

def emit_var(key, value, vars_file):
    vars_file.write("%s: %s\n" % (key.lower(), value))

def generate_playbook(args=None):
    playbook_file = open(playbook, "w")
    playbook_file.write("---\n")
    #- hosts: azure-driver
    #roles:
    #- { role: vmware.azure-iot }

    for hosts_and_role in args:
        print ("%s" % hosts_and_role)
        vals = re.split('=', hosts_and_role)
        if len(vals) == 2:
            playbook_file.write("- hosts: %s\n" % vals[0])
            playbook_file.write("  roles:\n")
            playbook_file.write("    - role: %s\n" % vals[1])

    playbook_file.close()

if __name__ == '__main__':
    generate_playbook(sys.argv)
