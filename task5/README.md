#### Deployed three virtual machines (18.206.219.150, 54.80.10.29, 52.202.73.37) in the AWS Cloud.   
#### Installed Ansible is on the 18.206.219.150 machine.  

#### Ping pong - execute the built-in ansible ping command.   
#### Ping the other two machines.  


``ansible all -i inventory -m ping``  

##### The result:  

``54.80.10.29 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
52.202.73.37 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}``  

### Playbook for installing Docker on two machines and run it  

##### Use file ``install_docker.yml``  

##### Execute command ``ansible-playbook -i inventory --ask-become-pass install_docker.yml``  
