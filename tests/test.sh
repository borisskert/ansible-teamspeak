#!/bin/bash
set -e

vagrant up --provision

ansible-galaxy install -r requirements.yml -p ./roles --force

ansible-playbook -i inventory.ini test.yml

ansible-playbook -i inventory.ini test.yml \
  | grep -q 'changed=0.*failed=0' \
  && (echo 'Idempotence test: pass' && exit 0) \
  || (echo 'Idempotence test: fail' && exit 1)

(nc -zu -w300 192.168.33.48 9987 && \
nc -z -w300 192.168.33.48 10011 && \
nc -z -w300 192.168.33.48 30033) && \
(echo 'Netcat test: pass' && exit 0) ||
(echo 'Netcat test: fail' && exit 1)

vagrant destroy -f
