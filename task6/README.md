#### Task 6: Jenkins. Automate, Manage and Control  
##### Start jenkins container  

`docker run --detach --publish 8080:8080 --volume jenkins_home:/var/jenkins_home --name jenkins jenkins/jenkins:lts`  
##### password of container for jenkins  
`docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`  
##### create slave agents
`docker run -i --rm --name agent1 --init -p 2222:22 -v agent1-workdir:/home/jenkins/agent jenkins/agent java -jar /usr/share/jenkins/agent.jar -workDir /home/jenkins/agent`  
`docker run -i --rm --name agent2 --init -p 2223:22 -v agent2-workdir:/home/jenkins/agent jenkins/agent java -jar /usr/share/jenkins/agent.jar -workDir /home/jenkins/agent`  

##### In docker slave container  
`/etc/init.d/ssh start`  
`apt install ssh`  
`/etc/init.d/ssh start`  
`useradd -m -d /home/jenkins jenkins`  
` su jenkins`  
`ssh-keygen`  
`cat id_rsa.pub > authorized_keys`  
##### Open jenkins and build the Pipeline or Freestyle  
