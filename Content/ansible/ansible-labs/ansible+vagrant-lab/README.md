***Introduction***

Deploy a Flask-based Book Library app with MongoDB across three VMs orchestrated by Vagrant and Ansible:

master: Runs Ansible playbooks

backend: Hosts MongoDB and the REST API

frontend: Serves the UI via Gunicorn

Automated provisioning and smoke tests ensure consistent, repeatable setups.

***Prerequisites***

Vagrant 

VirtualBox (or other Vagrant provider)

***Quick Start***
```bash
    git clone <repository_url>
    cd <repository_folder>
    vagrant up
```
Vagrant will power up three VMs configured at the vagrantfile  with all the needed inatallation for this project (master,backend and frontend)

***For running the ansible master playbook(master playbook controls e2e run. But, you can run each playbook individually)***

```bash
    vagrant ssh master
    cd /vagrant
    ansible-playbook -i inventory.ini master-playbook.yaml
```

***visit the webapp you just created using ansible-plybook***

http://192.168.56.11:5000/


