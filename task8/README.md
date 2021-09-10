### Task8 instruction CI/CD  

##### Have two instances  
1 - Jenkins server : VirtualBox Ubuntu 20.04 machine  192.168.0.103  
2 - Application server : AWS EC2 Ubuntu 20.04 machine 18.117.157.196  

##### Clone application repository to Application server  
`git clone https://github.com/gitbexdevops/RepositoryForTask-task8.git`
##### change directory to dowloaded folder   
`cd RepositoryForTask-task8.git`  
##### run commands to deploy containers  
`bin/setup`  
`docker network create reaction.localhost`  
`docker-compose up -d`  

##### Install Jenkins  
1 - Install Jenkins container on VirtualBox Ubuntu 20.04 machine  

2 - Create Slave agent (Label = agent1) for Application server : AWS EC2 Ubuntu 20.04 machine  

3 - Creata Freestyle project to Trigger after GitHub Push to stop Docker container for update  
 > Restrict where this project can be run = `agent1`    
 Source Code Management = Git =  `https://github.com/gitbexdevops/RepositoryForTask-task8`  
 Branch Specifier (blank for 'any') = `akarshit-fix-update-files`  
 Build Triggers = `GitHub hook trigger for GITScm polling`    
 Build = Execute shell = `sudo docker stop a3fbca43917d 85d5f9bd5273`    
 Post-build Actions => Projects to build =  `Docker container start` => Trigger only if build is stable   
 
4 - Create Pipeline `Docker container start`  
 > Pipeline => Definition => Pipeline script from SCM  
 SCM => Repositories => Repository URL => `https://github.com/gitbexdevops/RepositoryForTask-task8`  
 Branches to build => Branch Specifier (blank for 'any') = `*/trunk`  
 Script Path = `Jenkinsfile`  
 Jenkinsfile consist of:  
 `pipeline {`  
 ` agent { label 'agent1'}`  
 `  stages {`  
 `       stage('Test') {`  
 `           steps {`  
 `               sh 'sudo docker start a3fbca43917d'`  
 `               sh 'sudo docker start 85d5f9bd5273'`  
 `           }`  
 `       }`  
 `   }`  
`}`  

5 - Setting Up Github Webhooks, Jenkins, and Ngrok for Local Development  
 >  https://ngrok.com/ and signup for an account  
 >  run the following `./ngrok http 8080` on extract dir  
 >  copy Forwarding adrress `http://***********.ngrok.io` 
 >  GitHub => RepositoryForTask-task8 => Settings => Webhooks  
 >  Add webhooks  
 >  Payload URL = `http://***********.ngrok.io/github-webhook/`  
 >  Content type = `application/json`  
 >  Which events would you like to trigger this webhook? = `Just the push event.`  
 >  Enable `Active`  
 >  Press Update webhook  
 
6 - Mongodb backup job run once a day  
 > Freestyle project  
 > Restrict where this project can be run = `agent1` Label Expression  
 > Build Triggers => Build periodically => Schedule = `15 00 * * *`  
 > Build => Execute shell => Command = `sudo docker exec a21c487533aa mongodump -out/backup_mongo/`  
 > Save  
