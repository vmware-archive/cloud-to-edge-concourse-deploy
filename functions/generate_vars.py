#!/usr/bin/env python2.7

import sys, os
import re

group_var_all = "group_vars/all/vars.yml"

# These are multiline variables, need to be formatted correctly as yaml.
# There will be some sort of whitespace, explicity change that whitespace to
# newline and correct indentation.
force_multiline = [
    "skyway_edge_vm_ssh_priv_key",
    "skyway_edge_vm_ssh_pub_key"
]

def emit_var(key, value, vars_file):
    if key in force_multiline:
        lines = value.splitlines()
        vars_file.write("%s: |\n" % key.lower())
        for line in lines:
            vars_file.write("  %s\n" % line)
    else:
        vars_file.write("%s: %s\n" % (key.lower(), value))

def generate_vars(args=None):
    if not os.path.exists(os.path.dirname(group_var_all)):
        os.makedirs(os.path.dirname(group_var_all))
    group_vars = open(group_var_all, "w")
    group_vars.write("---\n")
    for k, v in os.environ.items():
        # Emit our own variables
        if re.search("^skyway", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        # Emit variables for cloud providers
        elif re.search("^aws", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        elif re.search("^azure", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        elif re.search("^google", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        elif re.search("^ibm", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        elif re.search("^greengrass", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        elif re.search(".*s3.*", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        elif re.search(".*lambda.*", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        # Some special cases; variables that aren't named according to
        # convention but that we need anyway.
        elif re.search("base_.*", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
        elif re.search("binary_.*", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
    group_vars.close()

if __name__ == '__main__':
    generate_vars(sys.argv)
