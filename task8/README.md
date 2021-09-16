### Task8 instruction CI/CD  

##### Have two instances  
> 1 - Jenkins server : VirtualBox Ubuntu 20.04 machine  192.168.0.103  
2 - Application server : AWS EC2 Ubuntu 20.04 machine 18.117.157.196  

##### Clone application repository to Application server  
> `git clone https://github.com/gitbexdevops/RepositoryForTask-task8.git`
> ##### change directory to dowloaded folder   
> `cd RepositoryForTask-task8.git`  
> ##### run commands to deploy containers  
> `bin/setup`  
> `docker network create reaction.localhost`  
> `docker-compose up -d`  

##### Installation on Jenkins server   
1 - Install Jenkins container on VirtualBox Ubuntu 20.04 machine  

2 - Create Slave agent (Label = agent1) for Application server : AWS EC2 Ubuntu 20.04 machine  

3 - Creata Freestyle project to Trigger after GitHub Push to stop Docker container for update  
 > + Restrict where this project can be run = `agent1`    
 > + Source Code Management = Git =  `https://github.com/gitbexdevops/RepositoryForTask-task8`  
 > + Branch Specifier (blank for 'any') = `akarshit-fix-update-files`  
 > + Build Triggers = `GitHub hook trigger for GITScm polling`    
 > + Build = Execute shell = `sudo docker stop a3fbca43917d 85d5f9bd5273`    
 > + Post-build Actions => Projects to build =  `Docker container start` => Trigger only if build is stable   
 
4 - Create Pipeline `Docker container start`  
 > + Pipeline => Definition => Pipeline script from SCM  
 > + SCM => Repositories => Repository URL => `https://github.com/gitbexdevops/RepositoryForTask-task8`  
 > + Branches to build => Branch Specifier (blank for 'any') = `*/trunk`  
 > + Script Path = `Jenkinsfile`  
 > + Jenkinsfile consist of:  
 ```YAML
 pipeline {  
  agent { label 'agent1'}  
   stages {  
        stage('Test') {  
            steps { 
                sh 'sudo docker start a3fbca43917d' 
                sh 'sudo docker start 85d5f9bd5273' 
            }  
        }  
    }  
} 
```  
5 - Setting Up Github Webhooks, Jenkins, and Ngrok for Local Development  
 >  + https://ngrok.com/ and signup for an account  
 >  + Run the following `./ngrok http 8080` on extract dir  
 >  + Copy Forwarding adrress `http://***********.ngrok.io` 
 >  + GitHub => RepositoryForTask-task8 => Settings => Webhooks  
 >  + Add webhooks  
 >  + Payload URL = `http://***********.ngrok.io/github-webhook/`  
 >  + Content type = `application/json`  
 >  + Which events would you like to trigger this webhook? = `Just the push event.`  
 >  + Enable `Active`  
 >  + Press Update webhook  
 
6 - Mongodb backup job run once a day  
 > + Freestyle project  
 > + Restrict where this project can be run = `agent1` Label Expression  
 > + Build Triggers => Build periodically => Schedule = `15 00 * * *`  
 > + Build => Execute shell => Command = `sudo docker exec a21c487533aa mongodump -out/backup_mongo/`  
 > + Save  

7 - Install and rung Zabbix for monitoring  
> + Install Zabbix from official Zabbix webisite for Ubuntu 20.04 system
> + Restart zabbix and nginx servers
> + Complete Frontend installation  

8 - Deploy application on Google Kuberates cloud  
> + gcloud config set project My First Project  
> + gcloud config set compute/zone s-west1-a  
> + gcloud config set compute/region us-west1  
> + gcloud container clusters create cluster-1 --num-nodes=1  
> + gcloud container clusters get-credentials cluster-1  
##### Instal Kopose to google cloud to convert docker compose to Kubernetes yaml file
> + curl -L https://github.com/kubernetes/kompose/releases/download/v1.24.0/kompose-linux-amd64 -o kompose  
> + chmod +x kompose  
> + sudo mv ./kompose /usr/local/bin/kompose  
> + kompose convert output  
> + kubectl apply -f output  
> + kubectl get pods  
> + kubectl get service cluster-1  

9 - Push Docker images to Google container registry  
> + Open Google cloud Powershel terminal where Google project created  
> + git clone required repostiroy https://github.com/gitbexdevops/RepositoryForTask-task8  
> + bin/setup  
> + docker-compose up -d  
> + Docker images are created now Tag them to Push to Google cloud container registry  
> + docker image ls  
> + `eactioncommerce/reaction   4.0.0     65bb0d99e960   2 weeks ago     700MB`  
> + `mongo                       4.2.0     5255aa8c3698   23 months ago   361MB`  
> + `docker tag reactioncommerce/reaction:4.0.0 gcr.io/august-strata-325411/reaction-gcr:latest`
> + `docker tag mongo:4.2.0 gcr.io/august-strata-325411/mongo-gcr` 
> + `docker push gcr.io/august-strata-325411/reaction-gcr`  
> + `docker push gcr.io/august-strata-325411/mongo-gcr`  
> + Google cloud container registy should containe images  

