This will setup a local development linux(centos) virtual machine.

See setup_script.sh to know what packages will be available. Add more if you need anything else.

It will also setup a python virtual env for ansible usage. The pip dependencies are in requirements.txt file.
To activate the venv enter cmd: source /ansible_pyenv/venv/bin/activate

#######################################################################################

Before you start :
1. Install Latest Vagrant --> https://www.vagrantup.com/
2. Install Latest Virtual Box --> https://www.virtualbox.org/wiki/Downloads
3. Install Git along with Git Bash --> https://git-scm.com/downloads

Once Vagrant, Virtual Box and Git Bash are installed on your machine.
1. Clone this repo
2. Inside the Vagrantfile, make below changes if required, before use:
   a) Set HOST_PATH = '<dir path that is shared between host and this box>'
   b) Add ports that you want to open in config.vm.network "forwarded_port" and firewall-cmd inline script
   c) Make additional changes to setup_script.sh as per your need.
3. Start gitbash and go to the Vagrantfile dir.
4. To start the Vagrant box, run cmd --> `vagrant up && vagrant ssh`
5. To exit from vagrant box, use cmd from inside the box --> `exit`
6. To shutdown the vagrant box gracefully, use cmd after exiting the box --> `vagrant halt`

#######################################################################################