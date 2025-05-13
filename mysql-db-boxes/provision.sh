#!/bin/bash -e

ENVIRONMENT=${1:-vagrant}
CLUSTER_SLUG=${2:-cluster1}
CUSTOMER_SLUG=${3:-customer1}

export BASE_SOURCE_PATH="${BASE_SOURCE_PATH:-/vagrant}"

INVENTORY_PATH="${BASE_SOURCE_PATH}/mysql-db-boxes/inventories/${ENVIRONMENT}/${CLUSTER_SLUG}/${CUSTOMER_SLUG}/inventory.ini"
PLAYBOOK_PATH="${BASE_SOURCE_PATH}/mysql-db-boxes/playbooks/playbook.yml"
ANSIBLE_CONFIG="${BASE_SOURCE_PATH}/mysql-db-boxes/inventories/${ENVIRONMENT}/${CLUSTER_SLUG}/${CUSTOMER_SLUG}/ansible.cfg"

export ANSIBLE_CONFIG=/vagrant/mysql-db-boxes/inventories/vagrant/cluster1/customer1/ansible.cfg

apt-get update
apt-get install -y software-properties-common
apt-get install -y ansible sshpass

ansible-playbook -i "${INVENTORY_PATH}" "${PLAYBOOK_PATH}" 