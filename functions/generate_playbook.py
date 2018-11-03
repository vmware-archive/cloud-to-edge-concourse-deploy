#!/usr/bin/env python2.7

import sys, os
import re
import argparse

playbook = "task-playbook.yml"
hosts = []

aws_greengrass_enable = False
azure_iot_enable = False
truthy = ['true', 'True', 'yes', '1']

try:
    if os.environ['aws_greengrass_enable'] in truthy:
        aws_greengrass_enable = True
except KeyError:
    pass
try:
    if os.environ['azure_iot_enable'] in truthy:
        azure_iot_enable = True
except KeyError:
    pass

def emit_role(host, role, playbook_file):
    if "aws" in role or "greengrass" in role:
        if not aws_greengrass_enable:
            print ("Omitting role %s, provider not enabled." % role)
            return
    if "azure" in role:
        if not azure_iot_enable:
            print ("Omitting role %s, provider not enabled." % role)
            return
    if host not in hosts:
        # Assume hosts are ordered, i.e. no roles assigned to the one host
        # after assigning to a different host.
        hosts.append(host)
        playbook_file.write("- hosts: %s\n" % host)
        playbook_file.write("  roles:\n")
    playbook_file.write("    - role: %s\n" % role)

def generate_playbook(args=None):
    playbook_file = open(playbook, "w")
    # Create a minimal valid playbook, even with no arguments.
    playbook_file.write("---\n")
    playbook_file.write("- hosts: localhost\n")
    playbook_file.write("  connection: local\n")
    playbook_file.write("  gather_facts: no\n")
    try:
        if os.environ['ENABLE_ANSIBLE_DEBUG'] in truthy:
            # Add a debugging role to display active variables.
            print (">> localhost=vmware.iot_debug")
            emit_role("localhost", "vmware.iot_debug", playbook_file)
    except KeyError:
        pass
    if not args:
        return
    for hosts_and_role in args:
        print (">> %s" % hosts_and_role)
        vals = re.split('=', hosts_and_role)
        if len(vals) == 2:
            emit_role(vals[0], vals[1], playbook_file)
    playbook_file.close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='System deployer.')
    parser.add_argument('--host-role', dest='host_role', action='append',
                        help='associate an Ansible role with a host')
    parser.add_argument('--die', dest='die', action='store_true',
                        help='end with an error to ease debugging')
    args = parser.parse_known_args()[0]
    generate_playbook(args.host_role)
    if args.die:
        print ('Exiting early, die directive was passed in.')
        sys.exit(1)
