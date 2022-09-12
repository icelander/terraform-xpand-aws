#!/bin/bash

token=$1

yum install -y wget

#Add Repo and update yum
wget https://dlm.mariadb.com/enterprise-release-helpers/mariadb_es_repo_setup

chmod +x mariadb_es_repo_setup 

./mariadb_es_repo_setup --token="$token" --apply \
	--skip-server \
    --skip-tools \
    --mariadb-maxscale-version="2.5"


yum update -y

yum install maxscale -y

cat << EOF > /etc/maxscale.cnf
[maxscale]
threads=auto
admin_host=0.0.0.0
admin_secure_gui=false
EOF


systemctl start maxscale