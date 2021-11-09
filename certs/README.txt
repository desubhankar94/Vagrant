# RHEL 8
# Add any required certs here. Example: cert for docker login

Append /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
with this file data to add some missing certs


sudo cp *.cer /etc/pki/ca-trust/source/anchors/ 
sudo update-ca-trust
sudo systemctl restart docker
docker login
