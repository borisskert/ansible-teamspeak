ansible-teamspeak
=================

Installs teamspeak-server as docker container.

System requirements
-------------------

* Docker
* Systemd

Role requirements
-----------------

* python-docker package

Tasks
-----

* Build docker image locally
* Create volume paths for docker container
* Setup systemd unit file
* Start/Restart service

Role parameters
--------------

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| image_name    | text | no         | local/teamspeak-server | Docker image name    |
| image_version | text | no         | 3.1.0                  | Docker image version |
| interface     | ip address | no   | 0.0.0.0                | Mapped network for web-interface ports |
| default_port  | port       | no   | <empty>                | Default port (UDP incomming): 9987    |
| filetransfer_port | port   | no   | <empty>                | Filetransfer port (TCP incomming): 30033 |
| serverquery_port  | port   | no   | <empty>                | Serverquery port (TCP incomming): 10011  |
| weblist_port      | port   | no   | <empty>                | Weblist port (UDP outgoing): 2010        |
| tsdns_port        | port   | no   | <empty>                | Tsdns port (TCP incomming): 41144        |
| accounting_port   | port   | no   | <empty>                | Accounting port (TCP outgoing): 2008     |
| data_volume       | path   | no   | <empty>                | Path to data volume                      |
| log_volume        | path   | no   | <empty>                | Path to log volume                       |

Example Playbook
----------------

Usage (without parameters):

    - hosts: servers
      roles:
         - { role: install-docker-teamspeak }

Usage (with parameters):

    - hosts: servers
      roles:
      - role: install-docker-teamspeak
        image_name: local/teamspeak-server
        image_version: 3.1.0
        interface: 0.0.0.0
        default_port: 9987
        filetransfer_port: 30033
        serverquery_port: 10011
        weblist_port: 2010
        tsdns_port: 41144
        accounting_port: 2008
        data_volume: /srv/docker/teamspeak
        log_volume: /var/log/teamspeak
