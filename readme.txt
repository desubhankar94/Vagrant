1. Install Latest Vagrant --> https://www.vagrantup.com/
2. Install Latest Virtual Box --> https://www.virtualbox.org/wiki/Downloads
3. Install Git Bash (optional)
4. Clone this repo
5. Inside the Vagrantfile
   a) Set HOST_PATH = '< dir path that is shared between host and this box >'
   b) Add ports that you want to open in config.vm.network "forwarded_port" and firewall-cmd inline script
   c) Make additional changes to setup_script.sh as per your need.
6. Go to the Vagrantfile dir and run cmd --> `vagrant up && vagrant ssh`
7. To Exit from vagrant box, use cmd from inside the box --> `exit`
8. To shutdown vagrant box gracefully, use cmd --> `vagrant halt`
