#!/bin/bash
#
# Molecule playbook tests.
cd molecule

# Run default test (Rocky Linux).
molecule test

# Run tests on Debian.
MOLECULE_DISTRO=debian12 molecule test