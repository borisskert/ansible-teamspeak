# ansible-teamspeak

Installs teamspeak-server as docker container.

## System requirements

* Docker
* docker-compose
* Systemd

## Role requirements

* python-docker package

## Tasks

* Build docker image locally
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
| publish.tsdns_port        | port | no | <empty> | Tsdns port (TCP incomming): 41144        |
| volumes.data              | path | no | <empty> | Path to data volume                      |
| volumes.log               | path | no | <empty> | Path to log volume                       |

## Usage

### requirements.yml

```
- name: install-teamspeak
  src: https://github.com/flandiGT/ansible-teamspeak.git
  scm: git
```

### Example Playbook

Usage (without parameters):

    - hosts: servers
      roles:
         - { role: install-teamspeak }

Usage (with parameters):

    - hosts: servers
      roles:
      - role: install-teamspeak
        version: 3.3.1
        artifact_checksum: b3891341a9ff4c4b6b0173ac57f1d64d4752550c95eeb26d2518ac2f5ca9fbc1
        publish:
          interface: 0.0.0.0
          default_port: 9987
          filetransfer_port: 30033
          serverquery_port: 10011
          tsdns_port: 41144
        volumes:
          data: /srv/docker/teamspeak
          log: /var/log/teamspeak
