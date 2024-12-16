# ansible-teamspeak

Installs teamspeak-server as docker container.

## System requirements

* Docker
* Systemd

## Role requirements

* python-docker package

## Tasks

* Pull official docker image
* Create volume paths for docker container
* Setup systemd unit file
* Start/Restart service

## Role parameters

| Variable                     | Type       | Mandatory? | Default | Description                              |
|------------------------------|------------|------------|---------|------------------------------------------|
| teamspeak_version            | text       | no         | 3.3.1   | Teamspeak server version                 |
| teamspeak_interface          | ip address | no         | 0.0.0.0 | Mapped network for web-interface ports   |
| teamspeak_port               | port       | no         | <empty> | Default port (UDP incomming): 9987       |
| teamspeak_filestransfer_port | port       | no         | <empty> | Filetransfer port (TCP incomming): 30033 |
| teamspeak_serverquery_port   | port       | no         | <empty> | Serverquery port (TCP incomming): 10011  |
| teamspeak_data_volume        | path       | yes        | <empty> | Path to data volume                      |
| teamspeak_log_volume         | path       | yes        | <empty> | Path to log volume                       |
| teamspeak_files_volume       | path       | yes        | <empty> | Path to files volume                     |

## Usage

### requirements.yml

```yaml
- name: install-teamspeak
  src: https://github.com/borisskert/ansible-teamspeak.git
  scm: git
```

### Example Playbook

Usage (without parameters):

```yaml
    - hosts: servers
      roles:
      - role: install-teamspeak
        teamspeak_accept_license: yes
```

Usage (with parameters):

```yaml
    - hosts: servers
      roles:
      - role: install-teamspeak
        teamspeak_version: '3.12'
        teamspeak_data_volume: /srv/teamspeak/data
        teamspeak_log_volume: /var/log/teamspeak
        teamspeak_files_volume: /srv/teamspeak/files
        teamspeak_interface: 0.0.0.0
        teamspeak_port: 9987
        teamspeak_filestransfer_port: 30033
        teamspeak_serverquery_port: 10011
        teamspeak_accept_license: true
```

## Testing

Requirements:

* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Ansible](https://docs.ansible.com/)
* [Molecule](https://molecule.readthedocs.io/en/latest/index.html)
* [yamllint](https://yamllint.readthedocs.io/en/stable/#)
* [ansible-lint](https://docs.ansible.com/ansible-lint/)
* [Docker](https://docs.docker.com/)

### Run within docker

```shell script
molecule test
```

### Run within Vagrant

```shell script
 molecule test --scenario-name vagrant --parallel
```

I recommend to use [pyenv](https://github.com/pyenv/pyenv) for local testing.
Within the GitHub Actions pipeline I use [my own molecule action](https://github.com/borisskert/molecule-action).

## Links

* [teamspeak @ Docker Hub](https://hub.docker.com/_/teamspeak/)
