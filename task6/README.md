#### Task 6: Jenkins. Automate, Manage and Control  
##### Start jenkins container  

#### 3. Configure several (2-3) build agents. Agents must be run in docker.

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

##### Open jenkins -> Manage Nodes -> 
New Node -> Give a name to node (agent1) -> 
Labels (agent1) ->  
Launch method = Launch agents via SSH ->  
Host = root@bexruz-VirtualBox:/# ifconfig   `172.18.0.1`  
Credentials = Add Jenkins -> Give (ID, Descriptioin Username = `jenkins`) -> Private Key = cat id_rsa  
Relanch agent  

### 4. Create a Freestyle project. Which will show the current date as a result of execution.  
New Item -> Enter an Item name -> Freestyle project -> Buld -> Execute shell = `echo Today is $(date)` -> Buld  

### 5. Create Pipeline which will execute docker ps -a in docker agent, running on Jenkins master’s Host.  

New Item -> Enter an Item name -> Pipeline -> Pipline script  
`pipeline {  
  agent { label 'agent1'}  
  stages {  
    stage('Test') {  
      steps {  
        sh 'docker ps -a'  
      }  
    }  
  }  
}`  

### 6. Create Pipeline, which will build artefact using Dockerfile directly from your github repo (use Dockerfile from previous task).  

Pipelein ->  
Defenition = Piplene scriopt from SCM ->  
SCM = Git ->  
Repository URL = https://github.com/gitbexdevops/RepositoryForTask  
Credential = jenkins (my agent credentials) <- created during agent1 create  
Branch Specifier (blank for 'any') = main  
Script Path = task6/Create Pipeline, which will build artefact using Dockerfile


### 4 Extra. Configure integration between Jenkins and your Git repo. Jenkins project must be started automatically if you push or merge to master, you also must see Jenkins last build status(success/unsuccess)   in your Git repo.  

Pipelein ->  
Defenition = Piplene scriopt from SCM ->  
SCM = Git ->  
Repository URL = https://github.com/gitbexdevops/RepositoryForTask  
Credential = jenkins (my agent credentials) <- created during agent1 create  
Branch Specifier (blank for 'any') = main  
Script Path = task6/Jenkinsfile-2  


##### Docker inside Docker methods can be tried
`docker run -ti -v /var/run/docker.sock:/var/run/docker.sock docker`  
`docker pull ubuntu`  
`docker run --privileged -d --name dind-test docker:dind`  
`docker exec -it dind-test /bin/sh`  
`docker pull ubuntu`   

 
##### Open jenkins and build the Pipeline or Freestyle  
