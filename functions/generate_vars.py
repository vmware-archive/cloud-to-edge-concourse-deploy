#!/usr/bin/env python2.7

import sys, os
import re

group_var_all = "group_vars/all/vars.yml"

def emit_var(key, value, vars_file):
    vars_file.write("%s: %s\n" % (key.lower(), value))

def generate_vars(args=None):
    if not os.path.exists(os.path.dirname(group_var_all)):
        os.makedirs(os.path.dirname(group_var_all))
    group_vars = open(group_var_all, "w")
    group_vars.write("---\n")
    for k, v in os.environ.items():
        if re.search("^skyway", k, re.IGNORECASE):
            emit_var(k, v, group_vars)
    group_vars.close()

if __name__ == '__main__':
    generate_vars(sys.argv)
