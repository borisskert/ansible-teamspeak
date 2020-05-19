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

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| version       | text | no         | 3.3.1   | Teamspeak server version |
| publish.interface | ip address | no | 0.0.0.0 | Mapped network for web-interface ports |
| publish.default_port | port    | no | <empty> | Default port (UDP incomming): 9987     |
| publish.filetransfer_port | port | no | <empty> | Filetransfer port (TCP incomming): 30033 |
| publish.serverquery_port  | port | no | <empty> | Serverquery port (TCP incomming): 10011  |
| volumes.data              | path | yes | <empty> | Path to data volume                     |
| volumes.log               | path | yes | <empty> | Path to log volume                      |
| volumes.files             | path | yes | <empty> | Path to files volume                    |

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
        accept_license: yes
```

Usage (with parameters):

```yaml
    - hosts: servers
      roles:
      - role: install-teamspeak
        version: 3.12
        accept_license: yes
        publish:
          interface: 0.0.0.0
          default_port: 9987
          filetransfer_port: 30033
          serverquery_port: 10011
        volumes:
          data: /srv/docker/teamspeak/data
          files: /var/docker/teamspeak/files
          log: /var/log/teamspeak
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
Within the Github Actions pipeline I use [my own molecule Docker image](https://github.com/borisskert/docker-molecule).

## Links

* [teamspeak @ Docker Hub](https://hub.docker.com/_/teamspeak/)
