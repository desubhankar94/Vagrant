
# Box / OS
VAGRANT_BOX = 'generic/centos7'

# Memorable name for your
VM_NAME = 'my-centos-box'

# VM User -- 'vagrant' by default
VM_USER = 'vagrant'

# Host folder to sync
HOST_PATH = '../'

# Where to sync to on Guest -- 'vagrant' is the default user name
GUEST_PATH = '/SHARED'

# # VM Port -- uncomment this to use NAT instead of DHCP
VM_PORT = 8080
HTTP_PORT = 443
APP1_PORT = 8001
APP2_PORT = 8002

Vagrant.configure(2) do |config|
  # Vagrant box from Hashicorp
  config.vm.box = VAGRANT_BOX
  
  # Actual machine name
  config.vm.hostname = VM_NAME
  # Set VM name in Virtualbox
  config.vm.provider "virtualbox" do |v|
    v.name = VM_NAME
    v.memory = 2048
    v.cpus = 2
  end

  #DHCP -- comment this out if planning on using NAT instead
  # config.vm.network "private_network", type: "dhcp"
  # # Port forwarding -- uncomment this to use NAT instead of DHCP
  config.vm.network "forwarded_port", guest: 8080, host: VM_PORT
  config.vm.network "forwarded_port", guest: 443, host: HTTP_PORT
  config.vm.network "forwarded_port", guest: 8001, host: APP1_PORT
  config.vm.network "forwarded_port", guest: 8002, host: APP2_PORT

  # Sync folder
  config.vm.synced_folder HOST_PATH, GUEST_PATH,
  owner: "vagrant",
  mount_options: ["dmode=755,fmode=755"]

  # Disable default Vagrant folder, use a unique path per project
  # config.vm.synced_folder '.', '/home/'+VM_USER+'', disabled: true

  # Copy CA certs
  config.vm.provision "file", source: "./certs/tls-ca-bundle.pem", destination: "/tmp/tls-ca-bundle.pem", run: "once"
  # Copy EPEL repo file
  config.vm.provision "file", source: "./epel.repo", destination: "/tmp/epel.repo", run: "once"
  # Copy ansible venv requirements file
  config.vm.provision "file", source: "./requirements.txt", destination: "/tmp/requirements.txt", run: "once"
  # Copy zcaler certs
  config.vm.provision "file", source: "./certs/zs_root.cer", destination: "/tmp/", run: "once"
  config.vm.provision "file", source: "./certs/zs_inter.cer", destination: "/tmp/", run: "once"

  # Setup yum repository
  config.vm.provision "shell", inline: <<-SHELL, run: "once"
    echo "*******************"
	# rm /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
	cat /tmp/epel.repo > /etc/yum.repos.d/epel.repo
    yum-config-manager --enable epel
    rm -fr /var/cache/yum/*
    yum clean all
	yum -y install yum-utils
	yum -y install epel-release
    rm -fr /var/cache/yum/*
    yum-config-manager --disable epel
    yum clean all
    yum update -y
    yum upgrade -y
    yum autoremove -y
    cp /tmp/zs_*.cer /etc/pki/ca-trust/source/anchors/
	cat /tmp/tls-ca-bundle.pem >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
    update-ca-trust
    sudo firewall-cmd --zone=public --add-port={443,8080,8001,8002}/tcp --permanent
	sudo firewall-cmd --reload
	sudo firewall-cmd --zone=public --list-all
	echo "*******************"
  SHELL

  # Setup Script
  config.vm.provision "shell", path: "./setup_script.sh", run: "once"
 
  config.vm.provision "shell", inline: "date > /tmp/PROVISIONED", run: "once"
  
  config.vm.provision "shell", inline: <<-SHELL, run: "always"
    echo "*************************"
	if [ -f "/tmp/PROVISIONED" ]; then
     date=`cat /tmp/PROVISIONED`
	 echo "Time now :             `date`"
	 echo "Already Provisioned on ${date}. Run 'vagrant ssh' to login."
    fi
	echo "*************************"
  SHELL
      
end