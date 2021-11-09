#!/usr/bin/env bash

#Install git and python.
sudo yum -y install git python3
python3 -m pip install --upgrade wheel pip setuptools

#Install and setup docker.
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
sudo usermod -aG docker vagrant

#Install dependencies for ansible and pywinrm[kerberos]
sudo yum install -y gcc krb5-pkinit krb5-libs krb5-server krb5-workstation python3-devel python-devel libxslt-devel libffi-devel openssl-devel

#Setup ansible python venv.
sudo mkdir /ansible_pyenv
sudo chown vagrant:vagrant /ansible_pyenv
python3 -m venv /ansible_pyenv/venv --copies
source /ansible_pyenv/venv/bin/activate
which python
python -m pip install --upgrade wheel pip setuptools
cp /tmp/requirements.txt /ansible_pyenv/requirements.txt
python -m pip install -r /ansible_pyenv/requirements.txt

echo "*** Done ***"