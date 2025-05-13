#!/bin/bash -e

ENVIRONMENT=${1:-vagrant}
CLUSTER_SLUG=${2:-cluster1}
CUSTOMER_SLUG=${3:-customer1}

if [ -z "${ENVIRONMENT}" ] || [ -z "${CLUSTER_SLUG}" ] || [ -z "${CUSTOMER_SLUG}" ]; then
  echo "Usage: $0 <environment> <cluster_slug> <customer_slug>"
  echo "Example: $0 vagrant cluster1 customer1"
  exit 1
fi

export BASE_SOURCE_PATH="${BASE_SOURCE_PATH:-/vagrant}"

INVENTORY_PATH="${BASE_SOURCE_PATH}/mysql-db-boxes/inventories/${ENVIRONMENT}/${CLUSTER_SLUG}/${CUSTOMER_SLUG}/inventory.ini"
PLAYBOOK_PATH="${BASE_SOURCE_PATH}/mysql-db-boxes/playbooks/playbook.yml"

# Ansible ve gerekli paketlerin kurulumu
apt-get update
apt-get install -y software-properties-common
apt-get install -y ansible sshpass

# Playbook'u çalıştır
ansible-playbook -i "${INVENTORY_PATH}" "${PLAYBOOK_PATH}"

# Create necessary directories
mkdir -p ${BASE_SOURCE_PATH}/${PROJECT_NAME}/inventories/${INVENTORY}/${CLUSTER_SLUG}/${CUSTOMER_SLUG}
mkdir -p ${BASE_SOURCE_PATH}/${PROJECT_NAME}/playbooks
mkdir -p ${BASE_SOURCE_PATH}/${PROJECT_NAME}/roles

# Create ansible.cfg if it doesn't exist
if [ ! -f ${BASE_SOURCE_PATH}/${PROJECT_NAME}/inventories/${INVENTORY}/${CLUSTER_SLUG}/${CUSTOMER_SLUG}/ansible.cfg ]; then
    cat > ${BASE_SOURCE_PATH}/${PROJECT_NAME}/inventories/${INVENTORY}/${CLUSTER_SLUG}/${CUSTOMER_SLUG}/ansible.cfg << EOF
[defaults]
inventory = ${ANSIBLE_INVENTORY}
roles_path = /vagrant/mysql-db-boxes/roles
host_key_checking = False
retry_files_enabled = False
EOF
fi 