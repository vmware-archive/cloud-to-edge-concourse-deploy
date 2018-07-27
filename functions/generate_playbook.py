#!/usr/bin/env python2.7

import sys, os
import re
import argparse

playbook = "task-playbook.yml"
hosts = ["localhost"]

def emit_role(host, role, playbook_file):
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
        if (os.environ['ENABLE_ANSIBLE_DEBUG'] in ['true', 'True', 'yes', '1']):
            # Add a debugging role to display active variables.
            playbook_file.write("  roles:\n")
            emit_role("localhost", "dumpall", playbook_file)
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
        sys.exit(1)
