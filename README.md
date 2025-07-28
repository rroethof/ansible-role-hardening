# Ansible Role: Hardening

[![CI](https://github.com/rroethof/ansible-role-hardening/actions/workflows/prod.yml/badge.svg?branch=main)](https://github.com/rroethof/ansible-role-hardening/actions/workflows/prod.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/rroethof/ansible-role-hardening)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/rroethof/ansible-role-hardening)
![Ansible Role](https://img.shields.io/ansible/role/d/rroethof/hardening)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

[![github](https://img.shields.io/badge/GitHub-rroethof-181717.svg?style=flat&logo=github)](https://github.com/rroethof)
[![twitter](https://img.shields.io/badge/Twitter-@rroethof-00aced.svg?style=flat&logo=twitter)](https://twitter.com/rroethof)
[![website](https://img.shields.io/badge/Website-RonnyRoethof-5087B2.svg?style=flat&logo=telegram)](https://roethof.net)
[![website](https://img.shields.io/badge/Resume-RonnyRoethof-5087B2.svg?style=flat&logo=telegram)](https://ronnyroethof.nl)

> **An Ansible role to apply security hardening configurations to Linux systems.**

---

## Table of Contents

- [Ansible Role: Hardening](#ansible-role-hardening)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Supported Platforms](#supported-platforms)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Role Variables](#role-variables)
  - [Dependencies](#dependencies)
  - [Example Playbook](#example-playbook)
  - [Testing](#testing)
    - [Running Tests Locally](#running-tests-locally)
  - [CI Pipeline](#ci-pipeline)
  - [License](#license)
  - [Changelog](#changelog)
  - [Security](#security)
  - [Contributing](#contributing)
  - [Issues \& Support](#issues--support)

---

## Overview

This role applies a wide range of security hardening configurations to Debian and Enterprise Linux-based systems. It is designed to be configurable and idempotent.

**Key features:**
- Disabling uncommon filesystem kernel modules
- Securing `/tmp` and `/var/tmp` with `noexec`, `nosuid`, `nodev`
- Setting bootloader passwords and enabling AppArmor
- Configuring security banners
- Removing unnecessary packages (e.g., GUI)
- Configuring and enabling `auditd` with a comprehensive set of rules
- Restricting `cron` and `at` access to authorized users
- Hardening SSH server configuration
- Configuring secure `logrotate` permissions
- Enabling AIDE for filesystem integrity checking
- And more...

---

## Supported Platforms

This role is tested on the following platforms (see `meta/main.yml` for an updated list):

- Debian (Bookworm, Trixie)
- Ubuntu (Jammy, Noble)
- Enterprise Linux (EL9)

---

## Requirements

- Ansible >= 2.10
- Python 3.x
- Required Ansible collections (see below)

Before running Molecule tests or using Docker modules, ensure all required Ansible collections are installed:

```sh
ansible-galaxy collection install -r collections/requirements.yml
```

This will install all collections listed in `collections/requirements.yml`, including `community.docker` for Docker support.

---

## Installation

Install this role from Ansible Galaxy:

```sh
ansible-galaxy install rroethof.hardening
```

---

## Role Variables

Default values are defined in [`defaults/main.yml`](defaults/main.yml):

```yaml
# Example: Disable X11 forwarding in SSH
hardening_ssh_disable_x11_forwarding: true
```

See the file for all available variables and their descriptions.

---

## Dependencies

None.

---

## Example Playbook

This example is taken from [`molecule/default/converge.yml`](molecule/default/converge.yml) and is tested on each push, pull request, and release:

```yaml
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes
  roles:
    - role: rroethof.hardening
```

---

## Testing

This role is tested using [Molecule](https://molecule.readthedocs.io/) with the following matrix:

- Debian 12
- Ubuntu 22.04

### Running Tests Locally

1. Install Python dependencies:

   ```sh
   python -m pip install --upgrade -r requirements.txt
   ```

2. Install required Ansible collections:

   ```sh
   ansible-galaxy collection install -r collections/requirements.yml
   ```

3. Run tests for a specific distribution:

   ```sh
   # For Debian 12
   $env:MOLECULE_DISTRO="debian12"; molecule test

   # For Ubuntu 22.04
   $env:MOLECULE_DISTRO="ubuntu2404"; molecule test
   ```

The CI pipeline automatically tests all supported distributions on each push and pull request.

---

## CI Pipeline

Continuous Integration is provided via [GitHub Actions](.github/workflows/ci.yml):

- **Linting:** Runs yamllint and ansible-lint to check YAML and Ansible code quality.
- **Molecule Testing:** Runs Molecule tests in Docker for each supported distribution (Debian 12, Ubuntu 24.04, etc.).
- **(Optional) Galaxy Import:** The workflow includes a commented-out job to automatically import the role to Ansible Galaxy when changes are pushed to the main branch. To enable this, simply ensure you have set the **`GALAXY_API_KEY`** secret in your repository settings.

All pushes, pull requests, and releases are tested using Molecule. This ensures your role remains linted and tested across supported platforms.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of all notable changes to this project.

---

## Security

Please see our [Security Policy](SECURITY.md) for reporting vulnerabilities.

---

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) before submitting a Pull Request.

---

## Issues & Support

If you have any questions, feature requests, or find a bug, please [open an issue](https://github.com/rroethof/ansible-role-hardening/issues).

---
  
<sub>Author: Ronny Roethof ([ronny@roethof.net](mailto:ronny@roethof.net))</sub>
