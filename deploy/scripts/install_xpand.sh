#!/bin/bash

yum install -y bzip2 vsftpd nmap-ncat wget git mdadm

# Configure Drives
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/nvme1n1 /dev/nvme2n1
mkfs.ext4 /dev/md0
mkdir /data
mount /dev/md0 /data
echo "/dev/md0 /data ext4 defaults,noatime,nodiratime 0 2" >> /etc/fstab

# Extract Xpand Archive
bunzip2 xpand*.tar.bz2
mkdir xpand
tar -xf xpand*.tar --strip-components=1 -C ./xpand
cd ./xpand

# Install Xpand
sudo ./xpdnode_install.py --force

# Add /opt/clustrix/bin to PATH for xpand and xpandm
su xpand -c 'echo "PATH=$PATH:/opt/clustrix/bin" >> ~/.bashrc'
su xpandm -c 'echo "PATH=$PATH:/opt/clustrix/bin" >> ~/.bashrc'

# Copy SSH Key
mkdir -p /home/{xpand,xpandm}/.ssh
cp /home/centos/xpand_rsa /home/xpand/.ssh/id_rsa
cp /home/centos/xpand_rsa /home/xpandm/.ssh/id_rsa
chmod 400 /home/{xpand,xpandm}/.ssh/id_rsa
cat /home/centos/xpand_rsa.pub >> /home/xpand/.ssh/authorized_keys
cat /home/centos/xpand_rsa.pub >> /home/xpandm/.ssh/authorized_keys
chown -R xpand:xpand /home/xpand
chown -R xpandm:xpandm /home/xpandm